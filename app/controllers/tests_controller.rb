class TestsController < ApplicationController

  def index 
    @test = Test.new
    @tests = Test.all
  end

  def create
    Test.create(test_params)
  end
  
  private

  def test_params
    params.require(:test).permit(:image)
  end  

end
