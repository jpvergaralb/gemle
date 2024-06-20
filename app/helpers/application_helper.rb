module ApplicationHelper
    def are_we_in_home?
        request.path != root_path
    end
end
