" Exit quickly when already loaded.
if exists("g:loaded_gtype")
  finish
endif

" Exit quicky if running in compatible mode
if &compatible
  echohl ErrorMsg
  echohl none
  finish
endif

" Check for Ruby functionality.
if !has("ruby")
    echohl ErrorMsg
    echon "Sorry, Gtype requires ruby support."
  finish
endif

let g:loaded_gtype = "true"


ruby << EOF
# Creates a simple drill excercise for Gytypist
# see  http://www.gnu.org/software/gtypist/doc/#Script-file-commands for instructions on
# the gtypist excercise format

# Opened class string
class String

  #if is not the first line
  def to_gtypist
   " :#{self}"
  end

  #if is the first line
  def to_gtypist_first_line
   "D:#{self}"
  end

end

#Wrapper class
class Gtype
  attr_reader :path

  # @path holds the path to the temporary file that stores the excercice
  def initialize(args)
   # we don't want empty lines
   @args = args || []
   @path = '/tmp/selectionXXX.typ'
  end

  def add(line)
   @args << line unless line.strip.empty?
  end

  # modifies the args strings with the correct format
  def prepare
    maximum_lines = 20
    @args = @args.map {|x| x.strip}
    @args = @args.slice(0, maximum_lines - 1) if @args.length > maximum_lines
    self
  end

  def process
    res = []
    @args.each_with_index do |s, index|
      index == 0 ? res << s.to_gtypist_first_line : res << s.to_gtypist
    end
    res
  end


  # write the temporary fle that holds the
  # excercice that will be passed to gtypist
  def write
    File.open(@path, 'w') do |f|
      f.puts prepare().process()
    end
  end

  def clean
    File.delete(@path) if File.exists?(@path)
  end

  # enough content for an excercice
  def can_create_exercice?
    @args.length > 0
  end

end

if __FILE__ == $0
  Gtype.new(ARGF, '/tmp/selectionXXX.typ').write()
  exit!
end
EOF


function! Gtype() range
ruby << LEOF
  gtype = Gtype.new([])
  VIM.command(":'<,'>rubydo(gtype.add($_))")
  if gtype.can_create_exercice?
    gtype.write()
    VIM.command(":silent !gtypist -S #{gtype.path}")
    VIM.command(':redraw!')
    gtype.clean()
  else 
    print "current line(s) is/are empty"
  end
LEOF
endfunction
command Gtype :'<, '>call Gtype()
