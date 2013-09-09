class TrackPhrasesController < ApplicationController
  before_action :set_track_phrase, only: [:show, :edit, :update, :destroy]

  # GET /track_phrases
  # GET /track_phrases.json
  def index
    @track_phrases = TrackPhrase.all
  end

  # GET /track_phrases/1
  # GET /track_phrases/1.json
  def show
  end

  # GET /track_phrases/new
  def new
    @track_phrase = TrackPhrase.new
  end

  # GET /track_phrases/1/edit
  def edit
  end

  # POST /track_phrases
  # POST /track_phrases.json
  def create
    @track_phrase = TrackPhrase.new(track_phrase_params)

    respond_to do |format|
      if @track_phrase.save
        format.html { redirect_to @track_phrase, notice: 'Track phrase was successfully created.' }
        format.json { render action: 'show', status: :created, location: @track_phrase }
      else
        format.html { render action: 'new' }
        format.json { render json: @track_phrase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /track_phrases/1
  # PATCH/PUT /track_phrases/1.json
  def update
    respond_to do |format|
      if @track_phrase.update(track_phrase_params)
        format.html { redirect_to @track_phrase, notice: 'Track phrase was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @track_phrase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /track_phrases/1
  # DELETE /track_phrases/1.json
  def destroy
    @track_phrase.destroy
    respond_to do |format|
      format.html { redirect_to track_phrases_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_track_phrase
      @track_phrase = TrackPhrase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def track_phrase_params
      params.require(:track_phrase).permit(:text)
    end
end
