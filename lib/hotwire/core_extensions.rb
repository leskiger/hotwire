class Hash #:nodoc:
  
  ##
  # Returns a new Wire formatted hash based on an approriately formatted hash.
  # For information on required keys, see Hotwire::Table.initialize
  #
  def to_wire
    Hotwire::Table.new(self).to_wire
  end
  
end