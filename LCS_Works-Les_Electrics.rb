use_bpm 96
use_random_seed Time.now.strftime("%Y%m%d%H%M%S").to_i
METER = {
  two_two:      [2, 2],
  three_two:    [3, 2],
  two_four:     [2, 4],
  three_four:   [3, 4],
  four_four:    [4, 4],
  five_four:    [5, 4],
  six_four:     [6, 4],
  three_eight:  [3, 8],
  four_eight:   [4, 8],
  five_eight:   [5, 8],
  six_eight:    [6, 8],
  seven_eight:  [7, 8],
  nine_eight:   [9, 8]
}
METER_KEY = :two_four
NUM, DEN = METER[METER_KEY]
BAR_BEATS = NUM * (4.0 / DEN)
CELL_COUNT = 8
CELL_BEATS = BAR_BEATS / CELL_COUNT
ROOT = 48
SERIES = [0, 1, 4, 2, 7, 3, 11, 5, 8, 10, 6, 9]
RETRO  = SERIES.reverse
INV    = SERIES.map { |pc| (12 - pc) % 12 }
FIBS = [1, 1, 2, 3, 5, 8, 13, 21]
FORM_CHAIN = {
  organum:    [[:conductus, 3], [:clausula, 2], [:minimal, 1]],
  conductus:  [[:clausula, 3], [:variation, 2], [:rondo, 1]],
  clausula:   [[:fugue, 3], [:canon, 2], [:sonata, 2]],
  fugue:      [[:canon, 3], [:variation, 2], [:serial, 2]],
  canon:      [[:variation, 3], [:minimal, 2], [:rondo, 2]],
  variation:  [[:sonata, 3], [:rondo, 2], [:refrain, 2]],
  sonata:     [[:rondo, 2], [:serial, 2], [:minimal, 1]],
  rondo:      [[:ritornello, 3], [:refrain, 3], [:sonatina, 1]],
  ritornello: [[:refrain, 3], [:variation, 2], [:minimal, 1]],
  refrain:    [[:rondo, 2], [:serial, 2], [:minimal, 2]],
  sonatina:   [[:minimal, 3], [:variation, 2], [:rondo, 1]],
  serial:     [[:minimal, 3], [:fugue, 2], [:canon, 1]],
  minimal:    [[:organum, 2], [:conductus, 2], [:clausula, 2]]
}
define :pick_weighted do |pairs|
  total = 0.0
  pairs.each { |_, w| total += w }
  r = rand(total)
  acc = 0.0
  pairs.each do |value, weight|
    acc += weight
    return value if r < acc
  end
  pairs[-1][0]
end
define :pc_note do |pc, oct = 0|
  ROOT + pc + (12 * oct)
end
define :clamp_note do |n|
  [[n.to_i, 0].max, 127].min
end
define :send_poly do |notes, sustain_beats, velocity = 90, channel = 1|
  notes.flatten.uniq.each do |n|
    midi clamp_note(n), sustain: sustain_beats, velocity: velocity, channel: channel
  end
end
define :lorenz_step do |x, y, z|
  sigma = 10.0
  rho   = 28.0
  beta  = 8.0 / 3.0
  dt    = 0.01
  dx = sigma * (y - x)
  dy = x * (rho - z) - y
  dz = x * y - beta * z
  [x + dx * dt, y + dy * dt, z + dz * dt]
end
define :normalize_pattern do |pattern, total_beats|
  sum = pattern.reduce(0.0) { |a, b| a + b }
  pattern.map { |v| total_beats * v / sum }
end
define :pitch_class_for do |form, bar_i, step_i|
  idx = (bar_i * CELL_COUNT + step_i) % 12
  case form
  when :serial
    SERIES[idx]
  when :fugue
    RETRO[idx]
  when :canon
    INV[idx]
  when :variation
    INV.rotate(bar_i % 12)[idx]
  else
    SERIES[idx]
  end
end
define :register_shift do |bar_i|
  spectral_proxy = ((Math.sin(bar_i * 0.07) + Math.cos(bar_i * 0.11)) + 2.0) / 4.0
  complex_proxy  = Complex(Math.cos(bar_i * 0.17), Math.sin(bar_i * 0.17))
  (spectral_proxy * 3).floor - 1 + (complex_proxy.imaginary > 0 ? 0 : -1)
end
define :voice_stack do |form, pc, reg, step_i|
  root   = pc_note(pc, reg)
  third  = pc_note((pc + 4) % 12, reg)
  fifth  = pc_note((pc + 7) % 12, reg)
  octave = pc_note(pc, reg + 1)
  bass   = pc_note(pc, reg - 1)
  case form
  when :organum
    [root, fifth]
  when :conductus
    [root, third, fifth]
  when :clausula
    step_i >= 6 ? [root, fifth, octave] : [root, fifth]
  when :fugue
    [root, octave, bass]
  when :canon
    [root, fifth]
  when :variation
    [root, third, octave]
  when :sonata
    [root, third, fifth]
  when :rondo, :ritornello, :refrain
    [root, fifth, octave]
  when :sonatina
    [root, third]
  when :serial
    [root]
  when :minimal
    [root, bass]
  else
    [root]
  end
end
define :rhythm_pattern do |form, bar_i|
  fib = FIBS.rotate(bar_i % FIBS.length)
  case form
  when :serial
    [1, 1, 1, 1, 1, 1, 1, 1]
  when :minimal
    [1, 1, 1, 1, 1, 1, 1, 1]
  when :fugue, :canon
    [1, 2, 1, 1, 2, 1, 1, 1]
  when :organum, :conductus
    [1, 1, 2, 1, 1, 2, 1, 1]
  when :clausula
    [1, 1, 1, 1, 1, 1, 2, 2]
  when :variation
    [fib[0], fib[1], fib[2], fib[3], fib[4], fib[5], fib[6], fib[7]]
  when :sonata
    [1, 2, 1, 1, 1, 2, 1, 1]
  when :rondo, :ritornello, :refrain
    [2, 1, 1, 1, 2, 1, 1, 1]
  when :sonatina
    [1, 1, 1, 2, 1, 1, 1, 2]
  else
    [1, 1, 2, 1, 1, 3, 1, 1]
  end
end
define :play_bar do |form, bar_i, x, y, z|
  pattern = rhythm_pattern(form, bar_i)
  durs = normalize_pattern(pattern, BAR_BEATS)
  doppler_shift = (Math.sin(bar_i * 0.09) * 2).round
  reg = register_shift(bar_i)
  8.times do |step_i|
    pc = (pitch_class_for(form, bar_i, step_i) + doppler_shift) % 12
    notes = voice_stack(form, pc, reg, step_i)
    phase = Complex(Math.cos(bar_i * 0.13), Math.sin(bar_i * 0.13))
    vel = 72 + (phase.imaginary.abs * 18).to_i + ((x.abs + y.abs) * 6).to_i
    vel = [[vel, 35].max, 120].min
    if [:fugue, :canon].include?(form) && step_i == 0
      echoed = notes.map { |n| n + 12 }
      delay = BAR_BEATS / 2.0
      echo_vel = [vel - 10, 30].max
      in_thread do
        sleep delay
        send_poly(echoed, BAR_BEATS / 4.0, echo_vel, 1)
      end
    end
    send_poly(notes, durs[step_i] * 0.92, vel, 1)
    sleep durs[step_i]
  end
end
current_form = :organum
x = 0.1
y = 0.0
z = 0.0
bar_i = 0
start_time = Time.now.to_f
while Time.now.to_f - start_time < 300 do
  x, y, z = lorenz_step(x, y, z)
  play_bar(current_form, bar_i, x, y, z)
  current_form = pick_weighted(FORM_CHAIN[current_form])
  bar_i += 1
end
send_poly([ROOT, ROOT + 7, ROOT + 12], BAR_BEATS, 100, 1)
sleep BAR_BEATS