class User < ActiveRecord::Base
  def hello
    @message = "hello, how are you today?"
  end
end
