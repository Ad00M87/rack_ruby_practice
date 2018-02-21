require 'erb'

class BaseController
  attr_reader :request

  def initialize(req)
    @request = req
  end

  def index
    server_response render_template
  end

  private

  def render_template(name = params[:action])
    templates_dir = self.class.name.downcase.sub("controller", "")
    template_file = File.join(templates_dir, "#{name}.html.erb")

    file_path = template_file_path_for(template_file)

    if File.exists?(file_path)
      puts "Rendering template file #{template_file}"
      render_erb_file(file_path)
    else
      "ERROR: no available template file #{template_file}"
    end
  end

  def template_file_path_for(file_name)
    File.expand_path(File.join("../../views", file_name), __FILE__)
  end

  def render_erb_file(file_path)
    raw = File.read(file_path)
    #NOTE passing in binding will allow ERB to access the controllers instance variable
    ERB.new(raw).result(binding)
  end

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
