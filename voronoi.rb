#!/usr/bin/ruby


require 'Qt'

class QtApp < Qt::Widget

    def initialize
        
        super
        setWindowTitle "VORONOI"
        
        resize 360, 240
        move 300, 300

        
    end 
    def paintEvent event

          painter = Qt::Painter.new self
        
          drawDonut painter
          painter.end
    end

    
    def drawDonut painter
      
      painter.setRenderHint Qt::Painter::Antialiasing
      
      color=Qt::Color.new
      color.setNamedColor "#333333"
      
      pen= Qt::Pen.new color
      pen.setWidth 1
      painter.setPen pen
      
      w=width
      h=height
      
     # painter.translate Qt::Point.new w/2,h/2
      @arr.each { |a| 
                 painter.setPen Qt::Color.new a.r,a.g,a.b
                 painter.drawPoint a.x,a.y
                 # puts a.x.to_s + " "+ a.y.to_s+ "  "
              }
      
      
    end      

    def start arr
      @arr=arr
      show
    end
end




class Point
  def initialize(x,y,r,g,b)
    @x,@y,@r,@g,@b=x,y,r,g,b
  end
  attr_reader :x, :y,:r,:g,:b
   
  def distance (point)
    Math.hypot(point.x-x,point.y-y)
  end
  def setColor (point) 
    @r,@g,@b=point.r,point.g,point.b
  end
end
arr = Array.new
150.times do
  arr.push(Point.new rand(360), rand(240) ,rand(256), rand(256) ,rand(256)) 
end
#
out = Array.new
360.times do |x|
  240.times do |y|
    p=Point.new x, y ,0,0,0
    minima=1000
    arr.each { |a| 
                if minima>(dist=a.distance(p)) 
                     minima=dist  
                     p.setColor(a)
                end
             #   puts a.x.to_s + " "+ a.y.to_s+ "  "+ minima.to_s
              }
    
    out.push(p) 

  end
end
#Qt::Color.new 150,150,150
app = Qt::Application.new ARGV
qtapp=QtApp.new 
qtapp.start(out)
app.exec

