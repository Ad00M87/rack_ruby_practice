class Router
  def initialize(req)
    @request = req
  end

  def route
    if @request.path == "/"
      [200, { "Content-Type" => "text/plain" }, ["This is the root route"]]
    else
      page_not_found
    end
  end

  private
    def page_not_found
      [404, { "Content-Type" => "text/plain" }, ["404 Page Not Found"]]
    end

    def route_info
      @route_info ||= begin
        resource = path_fragments[0] || "base"
        id, action = find_id_and_action(path_fragments[1])
        { resource: resource, action: action, id: id }
      end
    end

    def find_id_and_action(fragment)
      case fragment
        when "new"
          [nil, :new]
        when nil
          action = @request.get? ? :index : :create
          [nil, action]
        else
          [fragment, :show]
      end
    end

    def path_fragments
      @fragments ||= @request.path.split('/').reject { |s| s.empty? }
    end
end
