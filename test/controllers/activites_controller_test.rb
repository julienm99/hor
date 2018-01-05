require 'test_helper'

class ActivitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @activite = activites(:one)
  end

  test "should get index" do
    get activites_url
    assert_response :success
  end

  test "should get new" do
    get new_activite_url
    assert_response :success
  end

  test "should create activite" do
    assert_difference('Activite.count') do
      post activites_url, params: { activite: { groupe: @activite.groupe, listeFoyers: @activite.listeFoyers, matiere: @activite.matiere, metaclass_id: @activite.metaclass_id, nom: @activite.nom, periodHor: @activite.periodHor, periodTache: @activite.periodTache, prof: @activite.prof, salle: @activite.salle } }
    end

    assert_redirected_to activite_url(Activite.last)
  end

  test "should show activite" do
    get activite_url(@activite)
    assert_response :success
  end

  test "should get edit" do
    get edit_activite_url(@activite)
    assert_response :success
  end

  test "should update activite" do
    patch activite_url(@activite), params: { activite: { groupe: @activite.groupe, listeFoyers: @activite.listeFoyers, matiere: @activite.matiere, metaclass_id: @activite.metaclass_id, nom: @activite.nom, periodHor: @activite.periodHor, periodTache: @activite.periodTache, prof: @activite.prof, salle: @activite.salle } }
    assert_redirected_to activite_url(@activite)
  end

  test "should destroy activite" do
    assert_difference('Activite.count', -1) do
      delete activite_url(@activite)
    end

    assert_redirected_to activites_url
  end
end
