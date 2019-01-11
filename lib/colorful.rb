require "colorful/version"

require File.expand_path('colorful/class_methods', File.dirname(__FILE__))
require File.expand_path('colorful/instance_methods', File.dirname(__FILE__))

class String

  extend Colorful::ClassMethods
  include Colorful::InstanceMethods

  color_methods
  modes_methods

end
