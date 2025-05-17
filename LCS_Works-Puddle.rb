use_random_seed 2025
end_time = Time.now.to_f + 200
with_fx :reverb, mix: 0.6, room: 0.8 do
  10.times do
    in_thread do
      use_synth :noise
      while Time.now.to_f < end_time
        pan_val = rrand(-1, 1)
        amp_val = rrand(0.02, 0.08)
        play 60, pan: pan_val, amp: amp_val, attack: 0.01, release: 0.1
        sleep rrand(0.03, 0.15)
      end
    end
  end
end
