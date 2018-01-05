require 'test_helper'

class MetaclassesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @metaclass = metaclasses(:one)
  end

  test "should get index" do
    get metaclasses_url
    assert_response :success
  end

  test "should get new" do
    get new_metaclass_url
    assert_response :success
  end

  test "should create metaclass" do
    assert_difference('Metaclass.count') do
      post metaclasses_url, params: { metaclass: { FixCedulables: @metaclass.FixCedulables, checked: @metaclass.checked, horFix: @metaclass.horFix, listClasses: @metaclass.listClasses, nom: @metaclass.nom } }
    end

    assert_redirected_to metaclass_url(Metaclass.last)
  end

  test "should show metaclass" do
    get metaclass_url(@metaclass)
    assert_response :success
  end

  test "should get edit" do
    get edit_metaclass_url(@metaclass)
    assert_response :success
  end

  test "should update metaclass" do
    patch metaclass_url(@metaclass), params: { metaclass: { FixCedulables: @metaclass.FixCedulables, checked: @metaclass.checked, horFix: @metaclass.horFix, listClasses: @metaclass.listClasses, nom: @metaclass.nom } }
    assert_redirected_to metaclass_url(@metaclass)
  end

  test "should destroy metaclass" do
    assert_difference('Metaclass.count', -1) do
      delete metaclass_url(@metaclass)
    end

    assert_redirected_to metaclasses_url
  end
end
