require "./spec_helper"

describe WalkerMethod do
  it "should work with two arrays" do
    sampler = WalkerMethod.new(%w[hello world], [8, 2])
    samples = Hash(String, Float64).new(0.0)
    10_000.times do
      samples[sampler.random] += 1
    end
    (samples["hello"] / samples["world"]).should be > 3.8
    (samples["hello"] / samples["world"]).should be < 4.2
  end
end
