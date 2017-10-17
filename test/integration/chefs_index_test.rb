require 'test_helper'

class ChefsIndexTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @chef = Chef.create!(chefname: "John", email: "john@gmail.com", password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "Jenney", email: "jenney@gmail.com", password: "password", password_confirmation: "password")
  end
  
  test "should show chef index" do
    get chefs_path
    assert_response :success
  end
  
  test "should get chef listing" do
    get chefs_path
    assert_template 'chefs/index'
    assert_select 'a[href=?]', chef_path(@chef), text: @chef.chefname
    assert_select 'a[href=?]', chef_path(@chef2), text: @chef2.chefname
  end
  
  test "should delete chef" do
    get chefs_path
    assert_template 'chefs/index'
    #assert_select "a[href=?]", chef_path(@chef), text: "Delete this chef"
    assert_difference 'Chef.count', -1 do
      delete chef_path(@chef)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end
end
