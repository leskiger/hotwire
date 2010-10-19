class Hash #:nodoc:
  
  # Returns a new Wire formatted hash
  def to_wire
    Hotwire::Data.new(self).to_wire
  end
  
end