require 'spec_helper'

describe Bonfig do
  subject do
    module MyModule
      extend Bonfig

      bonfig do
        config :name

        config :has_default, default: 'hello'
        config :nested do
          config :hello
        end

        config :size
      end
    end

    MyModule.config do |c|
      c.name = 1
      c.size = 'test'
      c.nested.hello = 2
    end
    MyModule
  end
  it 'should be configurable' do
    config = subject.config

    expect(config.name).to eq(1)
    expect(config.has_default).to eq('hello')
    expect(config.nested.hello).to eq(2)

    expect(config.size).to eq('test')
  end
end
