require "./walker_method/version"
require "big"

class WalkerMethod
  property prob, inx, keys, weights, sumw, length

  def initialize(keys : Array(String), weights : Array(Int32))
    @keys = keys
    @weights = weights
    @sumw = weights.sum.as(Int32)
    @prob = [] of BigFloat
    @inx = [] of Int32
    @length = weights.size.as(Int32)
    short = [] of Int32
    long = [] of Int32
    weights.each do |w|
      inx << -1
      prob << w * ( BigInt.new(length) / BigFloat.new(sumw) )
    end

    prob.each.with_index do |p, index|
      short << index if p < 1
      long << index if p > 1
    end

    while short.size > 0 && long.size > 0
      j = short.pop
      k = long[-1]
      inx[j] = k
      prob[k] -= (1 - prob[j])
      if prob[k] < 1
        short << k
        long.pop
      end
    end
  end

  def random
    u = rand
    j = (rand * length).to_i32
    if u <= prob[j]
      keys[j]
    else
      keys[inx[j]]
    end
  end
end
