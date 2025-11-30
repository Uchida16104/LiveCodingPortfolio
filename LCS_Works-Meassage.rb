use_bpm 120
ary = []
dur = []
16.times do |i|
  dur << ((i+1)/16.0)
end
def left(num, base_note)
  sin = ((Math.sin(num)+1)*base_note).round
  sin -= base_note if sin >= base_note
  sin += 24 if sin < 24
  sin
end
def right(num, base_note)
  cos = ((Math.cos(num)+1)*base_note).round
  cos += base_note if cos < base_note
  cos -= 24 if cos > 96
  cos
end
4000.times do |j|
  idx = ((Math.tan(j)).round).abs % dur.length
  duration = dur[idx] || 0.5
  ary << [left(j, 60), right(j, 60), duration]
end
ary.each_with_index do |(l_note, r_note, dur_time), j|
  l_note = [[l_note, 0].max, 127].min
  r_note = [[r_note, 0].max, 127].min
  dur_time = dur_time.nil? || dur_time <= 0 ? 0.5 : dur_time
  l_vel = (((Math.cos(j) + 1) / 2) * 127).round
  r_vel = (((Math.sin(j) + 1) / 2) * 127).round
  in_thread do
    midi l_note, channel: 0, velocity: l_vel
  end
  in_thread do
    midi r_note, channel: 1, velocity: r_vel
  end
  sleep dur_time
end