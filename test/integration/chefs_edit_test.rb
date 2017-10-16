require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @chef = Chef.create!(chefname: "Test data", email: "test@gmail.com", password: "password", password_confirmation: "password")
  end
  
  test "reject invalid profile edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: {chefname: " ", email: "edit@gmail.com"} }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "allow valid profile edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: {chefname: "Test Edit", email: "edit@gmail.com"} }
    follow_redirect!
    assert_not flash.empty?
    @chef.reload
    assert_match "Test Edit", @chef.chefname
    assert_match "edit@gmail.com", @chef.email
  end
  
end
