class Dance < Array
  def spin(num)
    self = self.drop(self.length - num) + self.take(self.length - num)
  end

  def exchange(a, b)
    temp = self[a]
    self[a] = self[b]
    self[b] = temp
  end

  def partner(a,b)
    idx_a = self.index(a)
    idx_b = self.index(b)
    excahnge(idx_a, idx_b)
  end

end
