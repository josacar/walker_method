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

  it "should work with two big arrays" do
    words = ["you", "the", "i", "to", "a", "and", "it", "of", "that", "in", "is", "me", "what", "this", "for", "my", "on", "your", "we", "have", "do", "no", "don't", "are", "be"] * 500

    freqs = [4621939, 3957465, 3476773, 2873389, 2551033, 1775393, 1693042, 1531878, 1323823, 1295198, 1242191, 1208959, 1071825, 961194, 898671, 877684, 867296, 834953, 819499, 812625, 799991, 788200, 764177, 743194, 743014] * 500

    sampler = WalkerMethod.new(words, freqs)
    samples = Hash(String, Float64).new(0.0)

    10_000.times do
      samples[sampler.random] += 1
    end

    (samples["you"] / samples["on"]).should be < 7
    (samples["you"] / samples["on"]).should be > 2
  end
end
