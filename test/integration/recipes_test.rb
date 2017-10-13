require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @chef = Chef.create!(chefname: "Test data", email: "test@gmail.com")
    @recipe = Recipe.create(name: "vegetable saute", description: "this is a cool test on vegetable", chef_id: @chef.id)
    @recipe2 = @chef.recipes.build(name: "cool chicken", description: "test data on chicken")
    @recipe2.save
  end
  
  
  test "should get recipes#index" do
    get recipes_path
    assert_response :success
  end
  
  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end
end
