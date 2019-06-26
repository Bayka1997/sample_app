class ApplicationController < ActionController::Base
    def hello
      render html: "Xin chào nguyễn văn bảy"
    end
end
