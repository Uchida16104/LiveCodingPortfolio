define :clamp do |x, min, max|
  [[x, min].max, max].min
end
define :normalize_01 do |x, xmin, xmax|
  (x - xmin).to_f / (xmax - xmin)
end
define :uniform do |min, max|
  min + rand * (max - min)
end
define :box_muller do
  u1 = rand
  u2 = rand
  Math.sqrt(-2 * Math.log(u1)) * Math.cos(2 * Math::PI * u2)
end
define :lorentz do |min, max|
  x = Math.tan(Math::PI * (rand - 0.5))
  clamp(x, min, max)
end
define :exponential do |min, max, lambda = 1.0|
  x = -Math.log(1 - rand) / lambda
  min + (x % (max - min))
end
define :gamma_sample do |k|
  if k < 1
    return gamma_sample(k + 1) * rand ** (1.0 / k)
  end
  d = k - 1.0 / 3.0
  c = 1.0 / Math.sqrt(9.0 * d)
  loop do
    x = box_muller
    v = 1 + c * x
    next if v <= 0
    v = v ** 3
    u = rand
    if u < 1 - 0.0331 * (x ** 4)
      return d * v
    end
    if Math.log(u) < 0.5 * x * x + d * (1 - v + Math.log(v))
      return d * v
    end
  end
end
define :beta_distribution do |min, max, a = 2.0, b = 5.0|
  x = gamma_sample(a)
  y = gamma_sample(b)
  beta_val = x / (x + y)
  min + beta_val * (max - min)
end
$logistic_x = rand
define :logistic_random do |min, max, r = 3.99|
  $logistic_x = r * $logistic_x * (1 - $logistic_x)
  min + $logistic_x * (max - min)
end
$henon_x = 0.1
$henon_y = 0.1
define :henon_random do |min, max, a = 1.4, b = 0.3|
  xn = 1 - a * ($henon_x ** 2) + $henon_y
  yn = b * $henon_x
  $henon_x = xn
  $henon_y = yn
  norm = ($henon_x + 1) / 2.0
  min + norm * (max - min)
end
define :levy do |min, max, c = 1.0|
  z = box_muller
  x = c / (z * z)
  min + (x % (max - min))
end
define :gaussian do |min, max, sigma = 1.0|
  z = box_muller * sigma
  clamp(z, min, max)
end
define :white_noise do |min, max|
  rand * (max - min) + min
end
define :weibull do |min, max, k = 1.5, lambda = 1.0|
  u = rand
  x = lambda * (-Math.log(1 - u)) ** (1.0 / k)
  min + (x % (max - min))
end
define :poisson do |min, max, lambda = 4.0|
  l = Math.exp(-lambda)
  k = 0
  p = 1.0
  loop do
    k += 1
    p *= rand
    break if p <= l
  end
  x = k - 1
  clamp(x, min, max)
end
define :student_t do |min, max, v = 5|
  z = box_muller
  s = Array.new(v) { box_muller ** 2 }.sum
  t = z / Math.sqrt(s / v)
  clamp(t, min, max)
end
define :composite_gdw do |min, max|
  g = exponential(0, 1, 1.0)
  d = beta_distribution(0, 1, 2, 5)
  w = weibull(0, 1, 2.0, 1.0)
  mix = (g + d + w) / 3.0
  min + mix * (max - min)
end
define :gaussian_mix do |min, max|
  if rand < 0.5
    z = gaussian(-1, 1, 0.3)
  else
    z = gaussian(-1, 1, 0.8)
  end
  min + (z + 1) / 2.0 * (max - min)
end
$fbm_y = 0.0
define :fbm do |min, max, h = 0.7|
  step = gaussian(0, 1, 1.0)
  $fbm_y += step * (rand ** h)
  norm = normalize_01($fbm_y, -5.0, 5.0)
  norm = [[norm, 0.0].max, 1.0].min
  min + norm * (max - min)
end
$perlin_x = 0.0
define :perlin do |min, max, inc = 0.1|
  define :grad do |x|
    Math.sin(x * 12.9898) * 43758.5453 % 1.0
  end
  define :fade do |t|
    t * t * t * (t * (t * 6 - 15) + 10)
  end
  x = $perlin_x
  x0 = x.floor
  x1 = x0 + 1
  t = x - x0
  g0 = grad(x0)
  g1 = grad(x1)
  v = (1 - fade(t)) * g0 + fade(t) * g1
  v = normalize_01(v, -1.0, 1.0)
  $perlin_x += inc
  min + v * (max - min)
end
define :math_random do |min, max, mode = :logistic|
  case mode
  when :uniform      then uniform(min, max)
  when :lorentz      then lorentz(min, max)
  when :exp          then exponential(min, max)
  when :beta         then beta_distribution(min, max)
  when :logistic     then logistic_random(min, max)
    # when :henon        then henon_random(min, max)
  when :levy         then levy(min, max)
    ## when :gaussian     then gaussian(min, max)
  when :white        then white_noise(min, max)
  when :weibull      then weibull(min, max)
    # when :poisson      then poisson(min, max)
    ## when :student_t    then student_t(min, max)
    ## when :gdw          then composite_gdw(min, max)
    ## when :mix_gauss    then gaussian_mix(min, max)
    ## when :fbm          then fbm(min, max)
  when :perlin       then perlin(min, max)
  else
    white_noise(min, max)
  end
end
define :mrand do |min, max, mode|
  v = math_random(min, max, mode)
  v >= max ? max - v : v
end
define :doppler do
  sample_name = :perc_bell
  approach_speed = 0.02
  distance_min = 0.2
  distance_max = 3.0
  pitch_shift_range = 0.5
  amp_base = 1.0
  pan_steps = 50
  use_bpm 60
  sample_ok = false
  begin
    sample_ok = sample_duration(sample_name) > 0
  rescue
    sample_ok = false
  end
  if !sample_ok
    puts "Sample not found or invalid. Stopping."
    stop
  end
  define :doppler_pan_play do |s_name, dist, pan_val|
    pitch_factor = 1 + (pitch_shift_range * (1.0 - (dist / distance_max)))
    amp_factor = amp_base * (1.0 / (dist + 0.1)) * (1 - pan_val.abs)
    pan_val = [[pan_val, -1.0].max, 1.0].min
    sample s_name, rate: pitch_factor, amp: amp_factor, pan: pan_val, pitch: -48, pitch_stretch: 24
  end
  distance = distance_max
  approach = -approach_speed
  pan_vals = (0..pan_steps).map { |i| -1.0 + 2.0 * i.to_f / pan_steps }
  pan_vals.each do |pan_val|
    doppler_pan_play(sample_name, distance, pan_val)
    distance += approach
    if distance < distance_min
      distance = distance_min
      approach = -approach
    elsif distance > distance_max
      distance = distance_max
      approach = -approach
    end
    sleep 0.05
  end
end
define :ps_bell do |time = 1|
  time.times do
    with_fx :gverb, room: 100, spread: 1, ref_level: 4, tail_level: 4, release: 5 do
      sample :perc_bell, pitch_stretch: 24, pitch: -48, amp: 0.5, pitch_dis: 1
      sleep 24
    end
  end
end
define :rm_bell do |time = 1|
  time.times do
    with_fx :gverb, room: 100, spread: 1, ref_level: 4, tail_level: 4, release: 5 do
      with_fx :ring_mod, freq: 96, mod_amp: 5, pre_amp: 2 do
        sample :perc_bell, pitch_stretch: 24, pitch: -48, amp: 0.125
        sleep 24
      end
    end
  end
end
define :rev_bell do |time = 1|
  time.times do
    with_fx :gverb, room: 100, spread: 1, ref_level: 4, tail_level: 4, release: 5 do
      sample :perc_bell, pitch_stretch: 24, pitch: -48, amp: 1, rate: -1
      sleep 24
    end
  end
end
define :bell do |time = 1|
  time.times do
    with_fx :gverb, room: 100, spread: 1, ref_level: 4, tail_level: 4, release: 5 do
      sample :perc_bell, pitch_stretch: 24, pitch: -48, amp: 1
      sleep 24/time.to_f
    end
  end
end
define :whole do |min = -11, max = 0|
  ary=[]
  for i in min..max do
    ary.push(i)
  end
  return ary
end
define :cluster do |name = :perc_bell, base_pitch = -48, cluster_pitches = (whole -11, 0), amp_level = 0.25, time = 1|
  time.times do
    with_fx :gverb, room: 100, spread: 1, ref_level: 4, tail_level: 4, release: 5 do
      cluster_pitches.each do |p|
        sample name,
          pitch: base_pitch + p,
          pitch_stretch: 24,
          amp: amp_level
      end
      sleep 24
    end
  end
end
define :glitch do |time = 1|
  time.times do
    with_fx :gverb, room: 100, spread: 1, ref_level: 4, tail_level: 4, release: 5 do
      random = mrand(0, 1, :uniform)
      sample :perc_bell, beat_stretch: random, pitch_stretch: 24, pitch: -48, amp: 1, slice: mrand(0, 15, :lorentz)
      sleep random
    end
  end
end
define :crash do
  crash = "/Users/hirotoshiuchida/crash.mp3"
  with_fx :reverb, room: 0.5 do
    sample crash, amp: 0.5, pitch_dis: 1
    sleep sample_duration(crash)
  end
end
define :noises do |synths, min, max, time|
  atk = mrand(0, 1, :exp)
  atk_lvl = mrand(0, 1, :beta)
  dcy = mrand(0, 1, :logistic)
  dcy_lvl = mrand(0, 1, :levy)
  stn = mrand(0, 1, :white)
  stn_lvl = mrand(0, 1, :weibull)
  rls = mrand(0, 1, :perlin)
  synths.each do |s|
    in_thread do
      time.times do
        with_fx :gverb, room: 100, spread: 1, ref_level: 4, tail_level: 4, release: 5 do
          with_fx :compressor do
            with_fx :tanh, krunch: Math::PI*10.to_f do
              use_synth s
              play (whole min, max), amp: 0.125, attack: atk, attack_level: atk_lvl, decay: dcy, decay_level: dcy_lvl, sustain: stn, sustain_level: stn_lvl, release: rls, env_curve: [1, 2, 3, 4, 6 , 7].tick, on: mrand(0, 1, :uniform)
              sleep (atk + dcy + stn + rls).to_f
            end
          end
        end
      end
    end
  end
end
bell 8
rev_bell
doppler
rm_bell
cluster
glitch 32
ps_bell
crash
noises [:bnoise, :chipnoise, :cnoise, :gnoise, :noise, :pnoise], 60, 72, 1