require 'test_helper'

class ChefTest < ActiveSupport::TestCase

	def setup
		@chef = Chef.new(chefname: "john", email: "john@example.com")
	end

	test "chef should be valid" do
		assert @chef.valid?
	end

	test "chefname should be present" do
		@chef.chefname = " "
		assert_not @chef.valid?
	end

	test "chefname should not be too long" do
		@chef.chefname = "a" * 41
		assert_not @chef.valid?
	end

	test "chefname should not be too short" do
		@chef.chefname = "aa"
		assert_not @chef.valid?
	end

	test "email must be present" do
		@chef.email = " "
		assert_not @chef.valid?
	end

	test "email length should be within bounds" do
		@chef.email = "a" * 101 + "example.com"
		assert_not @chef.valid?
	end

	test "email address should be unique" do
		dup_chef = @chef.dup
		dup_chef.email = @chef.email.upcase
		@chef.save
		@chef.save
		assert_not dup_chef.valid?
	end

	test "email validaton should accept valid addresses" do
		valid_addresses = %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@eem.eu]
		valid_addresses.each do |va|
			@chef.email = va
			assert @chef.valid?, '#{va.inspect} should be valid'
		end
	end

	test "email validaton should reject invalid address" do
		invalid_addresses = %w[user@example,com user_at_ee.org user.name@example. ee@i_am_.com]
		invalid_addresses.each do |ia|
			@chef.email = ia
			@chef.email = assert_not @chef.valid?, '#{ia.inspect} should be invalid'
		end
	end

end	