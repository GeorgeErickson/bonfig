require 'spec_helper'

describe Bonfig do
  subject do
    module MyModule
      extend Bonfig

      bonfig do
        config :name

        config :has_default, default: 'hello'
        config :has_block_default, default: -> { name }
        config :nested do
          config :hello
        end

        config :size
      end
    end

    MyModule.config do |c|
      c.name = 'shit'
    end
    MyModule
  end
  it 'should have a VERSION constant' do
    expect(subject.config.name).to eq('shit')
  end
end
