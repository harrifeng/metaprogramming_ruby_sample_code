#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'thor/parser'

describe Thor::Argument do

  def argument(name, options={})
    @argument ||= Thor::Argument.new(name, options)
  end

  describe "errors" do
    it "raises an error if name is not supplied" do
      expect {
        argument(nil)
      }.to raise_error(ArgumentError, "Argument name can't be nil.")
    end

    it "raises an error if type is unknown" do
      expect {
        argument(:task, :type => :unknown)
      }.to raise_error(ArgumentError, "Type :unknown is not valid for arguments.")
    end

    it "raises an error if argument is required and have default values" do
      expect {
        argument(:task, :type => :string, :default => "bar", :required => true)
      }.to raise_error(ArgumentError, "An argument cannot be required and have default value.")
    end

    it "raises an error if enum isn't an array" do
      expect {
        argument(:task, :type => :string, :enum => "bar")
      }.to raise_error(ArgumentError, "An argument cannot have an enum other than an array.")
    end
  end

  describe "#usage" do
    it "returns usage for string types" do
      expect(argument(:foo, :type => :string).usage).to eq("FOO")
    end

    it "returns usage for numeric types" do
      expect(argument(:foo, :type => :numeric).usage).to eq("N")
    end

    it "returns usage for array types" do
      expect(argument(:foo, :type => :array).usage).to eq("one two three")
    end

    it "returns usage for hash types" do
      expect(argument(:foo, :type => :hash).usage).to eq("key:value")
    end
  end
end
