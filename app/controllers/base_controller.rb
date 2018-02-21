class BaseController
  attr_reader :request

  def initialize(req)
    @request = req
  end

  def index
    server_response <<~HTML
      <html>
        <head><title>My Awesome Application</title></head>
        <body>
          <h1>This is the home page</h1>
        </body>
      </html>
    HTML
  end

  private

  #Default status code to 200 but allow customization
  def server_response(body, status: 200)
    [status, { "Content-Type" => "text/html" }, [body]]
  end

  def redirect_to(uri)
    #Add location to Header
    [302, { "Location" => uri }, []]
  end

  def params
    request.params
  end
end
