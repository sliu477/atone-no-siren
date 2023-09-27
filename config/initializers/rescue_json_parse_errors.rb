class RescueJsonParseErrors
  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      @app.call(env)
    rescue ActionDispatch::ParamsParser::ParseError => _e
      return [
        400, { 'Content-Type' => 'application/json' },
        [{ error: "json形式が不正です。" }.to_json]
      ]
    end
  end
end