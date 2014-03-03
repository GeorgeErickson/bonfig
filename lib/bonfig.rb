require 'bonfig/version'

module Bonfig
  class BlankConfig < BasicObject
    def __class__
      BlankConfig
    end

    def initialize(&block)
      @_data = ::Hash.new
      instance_eval(&block)
    end

    def config(name, options = {}, &block)
      name = name.to_sym
      if block
        @_data[name] = BlankConfig.new(&block)
      else
        @_data[name] = options[:default]
      end

      include_field(name)
    end

    protected

    def include_field(name)
      name = name.to_sym
      (class << self; self; end).class_eval do
        define_method(name) { @_data[name] }
        define_method("#{name}?") { @_data.key?(name) }
        define_method("#{name}=") { |value| @_data[name] = value }
      end
      name
    end
  end

  def bonfig(&block)
    @config ||= BlankConfig.new(&block)
  end

  def config(data = nil, &block)
    yield(@config) if block_given?
    @config
  end
end
