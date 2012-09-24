#it has to prepend a space: to each line
#and open the gtypist with the result
class String

  #if is the first line
  def to_gtypist
   " :#{self}"
  end

  #if is not the first line
  def to_gtypist_first_line
   "D:#{self}"
  end

end

#Wrapper class
class Gtype
  attr_reader :path

  def initialize(args, filename_path_and_name)
   @args = args
   @path = filename_path_and_name
  end

  def process
    res = []
    @args.each_with_index do |s, index|
      index == 0 ? res << s.to_gtypist_first_line : res << s.to_gtypist
    end
    res
  end


  def write
    File.open(@path, 'w') do |f|
      f.puts process()
    end
  end

end

if __FILE__ == $0
  Gtype.new(ARGF, '/tmp/selectionXXX.typ').write()
  exit!
end
