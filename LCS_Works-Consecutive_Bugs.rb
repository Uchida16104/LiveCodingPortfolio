live_loop :bd do
  with_fx :ping_pong, phase: rrand(0,1), phase_slide: 0.125 do |pp1|
    use_random_seed rrand(0,rrand(1,10000))
    use_random_source [:dark_pink,:light_pink,:perlin,:pink,:white].shuffle.choose
    v=sample_names(sample_groups[3])[rrand(0,sample_names(sample_groups[3]).length)]
    s=sample_duration v
    t=rrand(0,s).to_f
    u=rrand(s-t,s).to_f
    if t>1 && u>1
      sample v,start:1/t.to_f,finish:1/u.to_f,rate: [-1,1].choose
    elsif t>1
      sample v,start:1/t.to_f,finish:u.to_f,rate: [-1,1].choose
    elsif u>1
      sample v,start:t.to_f,finish:1/u.to_f,rate: [-1,1].choose
    else
      sample v,start:t.to_f,finish:u.to_f,rate: [-1,1].choose
    end
    sleep u-t
    control pp1, phase: rrand(0,1)
  end
end
live_loop :drum do
  with_fx :ping_pong, phase: rrand(0,1), phase_slide: 0.125 do |pp2|
    use_random_seed rrand(0,rrand(1,10000))
    use_random_source [:dark_pink,:light_pink,:perlin,:pink,:white].shuffle.choose
    v=sample_names(sample_groups[4])[rrand(0,sample_names(sample_groups[4]).length)]
    s=sample_duration v
    t=rrand(0,s).to_f
    u=rrand(s-t,s).to_f
    if t>1 && u>1
      sample v,start:1/t.to_f,finish:1/u.to_f,rate: [-1,1].choose
    elsif t>1
      sample v,start:1/t.to_f,finish:u.to_f,rate: [-1,1].choose
    elsif u>1
      sample v,start:t.to_f,finish:1/u.to_f,rate: [-1,1].choose
    else
      sample v,start:t.to_f,finish:u.to_f,rate: [-1,1].choose
    end
    sleep u-t
    control pp2, phase: rrand(0,1)
  end
end
live_loop :elec do
  with_fx :ping_pong, phase: rrand(0,1), phase_slide: 0.125 do |pp3|
    use_random_seed rrand(0,rrand(1,10000))
    use_random_source [:dark_pink,:light_pink,:perlin,:pink,:white].shuffle.choose
    v=sample_names(sample_groups[5])[rrand(0,sample_names(sample_groups[5]).length)]
    s=sample_duration v
    t=rrand(0,s).to_f
    u=rrand(s-t,s).to_f
    if t>1 && u>1
      sample v,start:1/t.to_f,finish:1/u.to_f,rate: [-1,1].choose
    elsif t>1
      sample v,start:1/t.to_f,finish:u.to_f,rate: [-1,1].choose
    elsif u>1
      sample v,start:t.to_f,finish:1/u.to_f,rate: [-1,1].choose
    else
      sample v,start:t.to_f,finish:u.to_f,rate: [-1,1].choose
    end
    sleep u-t
    control pp3, phase: rrand(0,1)
  end
end
live_loop :glitch do
  with_fx :ping_pong, phase: rrand(0,1), phase_slide: 0.125 do |pp4|
    use_random_seed rrand(0,rrand(1,10000))
    use_random_source [:dark_pink,:light_pink,:perlin,:pink,:white].shuffle.choose
    v=sample_names(sample_groups[6])[rrand(0,sample_names(sample_groups[6]).length)]
    s=sample_duration v
    t=rrand(0,s).to_f
    u=rrand(s-t,s).to_f
    if t>1 && u>1
      sample v,start:1/t.to_f,finish:1/u.to_f,rate: [-1,1].choose
    elsif t>1
      sample v,start:1/t.to_f,finish:u.to_f,rate: [-1,1].choose
    elsif u>1
      sample v,start:t.to_f,finish:1/u.to_f,rate: [-1,1].choose
    else
      sample v,start:t.to_f,finish:u.to_f,rate: [-1,1].choose
    end
    sleep u-t
    control pp4, phase: rrand(0,1)
  end
end
live_loop :hat do
  with_fx :ping_pong, phase: rrand(0,1), phase_slide: 0.125 do |pp5|
    use_random_seed rrand(0,rrand(1,10000))
    use_random_source [:dark_pink,:light_pink,:perlin,:pink,:white].shuffle.choose
    v=sample_names(sample_groups[8])[rrand(0,sample_names(sample_groups[8]).length)]
    s=sample_duration v
    t=rrand(0,s).to_f
    u=rrand(s-t,s).to_f
    if t>1 && u>1
      sample v,start:1/t.to_f,finish:1/u.to_f,rate: [-1,1].choose
    elsif t>1
      sample v,start:1/t.to_f,finish:u.to_f,rate: [-1,1].choose
    elsif u>1
      sample v,start:t.to_f,finish:1/u.to_f,rate: [-1,1].choose
    else
      sample v,start:t.to_f,finish:u.to_f,rate: [-1,1].choose
    end
    sleep u-t
    control pp5, phase: rrand(0,1)
  end
end
live_loop :sn do
  with_fx :ping_pong, phase: rrand(0,1), phase_slide: 0.125 do |pp6|
    use_random_seed rrand(0,rrand(1,10000))
    use_random_source [:dark_pink,:light_pink,:perlin,:pink,:white].shuffle.choose
    v=sample_names(sample_groups[13])[rrand(0,sample_names(sample_groups[13]).length)]
    s=sample_duration v
    t=rrand(0,s).to_f
    u=rrand(s-t,s).to_f
    if t>1 && u>1
      sample v,start:1/t.to_f,finish:1/u.to_f,rate: [-1,1].choose
    elsif t>1
      sample v,start:1/t.to_f,finish:u.to_f,rate: [-1,1].choose
    elsif u>1
      sample v,start:t.to_f,finish:1/u.to_f,rate: [-1,1].choose
    else
      sample v,start:t.to_f,finish:u.to_f,rate: [-1,1].choose
    end
    sleep u-t
    control pp6, phase: rrand(0,1)
  end
end
live_loop :vinyl do
  with_fx :ping_pong, phase: rrand(0,1), phase_slide: 0.125 do |pp7|
    use_random_seed rrand(0,rrand(1,10000))
    use_random_source [:dark_pink,:light_pink,:perlin,:pink,:white].shuffle.choose
    v=sample_names(sample_groups[15])[rrand(0,sample_names(sample_groups[15]).length)]
    s=sample_duration v
    t=rrand(0,s).to_f
    u=rrand(s-t,s).to_f
    if t>1 && u>1
      sample v,start:1/t.to_f,finish:1/u.to_f,rate: [-1,1].choose
    elsif t>1
      sample v,start:1/t.to_f,finish:u.to_f,rate: [-1,1].choose
    elsif u>1
      sample v,start:t.to_f,finish:1/u.to_f,rate: [-1,1].choose
    else
      sample v,start:t.to_f,finish:u.to_f,rate: [-1,1].choose
    end
    sleep u-t
    control pp7, phase: rrand(0,1)
  end
end