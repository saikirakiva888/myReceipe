require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @chef = Chef.create!(chefname: "Test data", email: "test@gmail.com", password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "Jenney", email: "jenney@gmail.com", password: "password", password_confirmation: "password")
    @admin = Chef.create!(chefname: "Jen", email: "jen@gmail.com", password: "password", password_confirmation: "password", admin: true)
  end
  
  test "reject invalid profile edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: {chefname: " ", email: "edit@gmail.com"} }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "allow valid profile edit" do
    sign_in_as(@chef, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: {chefname: "Test Edit", email: "edit@gmail.com"} }
    follow_redirect!
    assert_not flash.empty?
    @chef.reload
    assert_match "Test Edit", @chef.chefname
    assert_match "edit@gmail.com", @chef.email
  end
  
  test "accept edit attempt by admin user" do
    sign_in_as(@admin, "password")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: {chefname: "Test Edit 2", email: "edit2@gmail.com"} }
    follow_redirect!
    assert_not flash.empty?
    @chef.reload
    assert_match "Test Edit 2", @chef.chefname
    assert_match "edit2@gmail.com", @chef.email
  end
  
  test "redirect if non-admin user tries to edit other chefs' profile" do
    sign_in_as(@chef2, "password")
    update_chefname = "jame"
    update_email = "jame@email.com"
    patch chef_path(@chef), params: {chef: {chefname: update_chefname, email: update_email} }
    assert_redirected_to chefs_path
    assert_not flash.empty?
    assert_match "Test data", @chef.chefname
    assert_match "test@gmail.com", @chef.email
  end
end
