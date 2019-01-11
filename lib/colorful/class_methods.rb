module Colorful
  module ClassMethods
    #
    # Property to disable colorization
    #
    def disable_colorization(value = nil)
      if value.nil?
        if defined?(@disable_colorization)
          @disable_colorization || false
        else
          false
        end
      else
        @disable_colorization = (value || false)
      end
    end

    #
    # Setter for disable colorization
    #
    def disable_colorization=(value)
      @disable_colorization = (value || false)
    end

    #
    # Return array of available colors used by colorize
    #
    def colors
      color_codes.keys
    end

    #
    # Return array of available modes used by colorize
    #
    def modes
      mode_codes.keys
    end

    #
    # Display color samples
    #
    def color_samples
      colors.permutation(2).each do |background, color|
        sample_text = "#{color.inspect.rjust(15)} on #{background.inspect.ljust(15)}"
        puts "#{new(sample_text).colorful(:color => color, :background => background)} #{sample_text}"
      end
    end

    def colorful_usage

      puts "********************************************************************************************************************************"
      puts "******************************************************** COLORFUL USAGE ********************************************************"
      puts "********************************************************************************************************************************"
      puts "require 'colorize'"
      puts "\r\n"
      puts "\r\n"

      puts "String.colors                       # return array of all possible colors names"
      puts "String.modes                        # return array of all possible modes"
      puts "String.color_samples                # displays color samples in all combinations"
      puts "String.disable_colorization         # check if colorization is disabled"
      puts "String.disable_colorization = false # enable colorization"
      puts "String.disable_colorization false   # enable colorization"
      puts "String.disable_colorization = true  # disable colorization"
      puts "String.disable_colorization true    # disable colorization"

      puts "\r\n"
      puts "\r\n"

      puts "puts \"This is blue\".colorful(:blue)"
      puts "puts \"This is light blue\".colorful(:light_blue)"
      puts "puts \"This is also blue\".colorful(:color => :blue)"
      puts "puts \"This is light blue with red background\".colorful(:color => :light_blue, :background => :red)"
      puts "puts \"This is light blue with red background\".colorful(:light_blue ).colorful( :background => :red)"
      puts "puts \"This is blue text on red\".blue.on_red"
      puts "puts \"This is red on blue\".colorful(:red).on_blue"
      puts "puts \"This is red on blue and underline\".colorful(:red).on_blue.underline"
      puts "puts \"This is blue text on red\".blue.on_red.blink"
      puts "puts \"This is uncolorfuled\".blue.on_red.uncolorful"
      puts "********************************************************************************************************************************"
    end


    # private

    #
    # Color codes hash
    #
    def color_codes
      {
          :black   => 0, :light_black    => 60,
          :red     => 1, :light_red      => 61,
          :green   => 2, :light_green    => 62,
          :yellow  => 3, :light_yellow   => 63,
          :blue    => 4, :light_blue     => 64,
          :magenta => 5, :light_magenta  => 65,
          :cyan    => 6, :light_cyan     => 66,
          :white   => 7, :light_white    => 67,
          :default => 9
      }
    end

    #
    # Mode codes hash
    #
    def mode_codes
      {
          :default   => 0, # Turn off all attributes
          :bold      => 1, # Set bold mode
          :italic    => 3, # Set italic mode
          :underline => 4, # Set underline mode
          :blink     => 5, # Set blink mode
          :swap      => 7, # Exchange foreground and background colors
          :hide      => 8  # Hide text (foreground color would be the same as background)
      }
    end

    #
    # Generate color and on_color methods
    #
    def color_methods
      colors.each do |key|
        next if key == :default

        define_method key do
          colorful(:color => key)
        end

        define_method "on_#{key}" do
          colorful(:background => key)
        end
      end
    end

    #
    # Generate modes methods
    #
    def modes_methods
      modes.each do |key|
        next if key == :default

        define_method key do
          colorful(:mode => key)
        end
      end
    end
  end

end