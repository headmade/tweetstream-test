require 'test_helper'

class TrackPhrasesControllerTest < ActionController::TestCase
  setup do
    @track_phrase = track_phrases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:track_phrases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create track_phrase" do
    assert_difference('TrackPhrase.count') do
      post :create, track_phrase: { text: @track_phrase.text }
    end

    assert_redirected_to track_phrase_path(assigns(:track_phrase))
  end

  test "should show track_phrase" do
    get :show, id: @track_phrase
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @track_phrase
    assert_response :success
  end

  test "should update track_phrase" do
    patch :update, id: @track_phrase, track_phrase: { text: @track_phrase.text }
    assert_redirected_to track_phrase_path(assigns(:track_phrase))
  end

  test "should destroy track_phrase" do
    assert_difference('TrackPhrase.count', -1) do
      delete :destroy, id: @track_phrase
    end

    assert_redirected_to track_phrases_path
  end
end
