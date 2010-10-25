module Hotwire
  module Response
    # Specialization responsible for producing responses in HTML format.
    # Invoking +response+ on this class doesn't do anything, as this class
    # should be passed to a view and generate HTML over there.
    class Html < Hotwire::Response::Base
      # no need to answer anything ... response rendering is handled by
      # an erb template.
    end
  end
end