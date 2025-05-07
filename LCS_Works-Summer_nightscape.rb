define :sort do |s: :ambi_choir, n: 20, r: 1, k: 1|
  slices = (0...n).to_a.shuffle
  slice_duration = sample_duration(s) / n
  live_loop "sort_#{k}" do
    slices.each do |i|
      sample s,
        num_slices: n,
        slice: i,
        rate: r
      sleep slice_duration
    end
  end
end
with_fx :ping_pong do
  t=1.5
  u=:guit_em9
  v=:ambi_piano
  sort s: u, r: -t, n: 2, k: 1
  sort s: u, r: t, n: 2, k: 2
  sort s: u, r: -t/2.to_f, n: 2*2.to_f, k: 3
  sort s: u, r: t/2.to_f, n: 2*2.to_f, k: 4
  sort s: u, r: -t/4.to_f, n: 2*4.to_f, k: 5
  sort s: u, r: t/4.to_f, n: 2*4.to_f, k: 6
  sort s: u, r: -t/8.to_f, n: 2*8.to_f, k: 7
  sort s: u, r: t/8.to_f, n: 2*8.to_f, k: 8
  sort s: v, r: -t, n: 2, k: 9
  sort s: v, r: t, n: 2, k: 10
  sort s: v, r: -t/2.to_f, n: 2*2.to_f, k: 11
  sort s: v, r: t/2.to_f, n: 2*2.to_f, k: 12
  sort s: v, r: -t/4.to_f, n: 2*4.to_f, k: 13
  sort s: v, r: t/4.to_f, n: 2*4.to_f, k: 14
  sort s: v, r: -t/8.to_f, n: 2*8.to_f, k: 15
  sort s: v, r: t/8.to_f, n: 2*8.to_f, k: 16
end