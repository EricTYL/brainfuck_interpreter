
def naive(bf_code)
  rb_code = 'mem=Hash.new(p=0);' + 
    bf_code.gsub(/./,
		 '>' => 'p+=1;',
		 '<' => 'p-=1;',
		 '+' => 'mem[p]+=1;',
		 '-' => 'mem[p]-=1;',
		 '.' => 'putc mem[p];',
		 ',' => 'mem[p]=STDIN.getbyte if !STDIN.eof;',
		 '[' => 'while mem[p]!=0 do ',
		 ']' => 'end;')

  return rb_code
end

def contraction(bf_code)
  pre_rb_code = bf_code.gsub(/[\[\]\.\,]/,
			     '.' => 'putc mem[p];',
			     ',' => 'mem[p]=STDIN.getbyte if !STDIN.eof;',
			     '[' => 'while mem[p]!=0 do ',
			     ']' => 'end;')
  #puts pre_rb_code
  con_rb_code = pre_rb_code.gsub(/\+{1,}|\-{1,}|>{1,}|<{1,}/) { |match|
    case match[0]
    when "+"
      "mem[p]+=#{match.length};"
    when "-"
      "mem[p]-=#{match.length};"
    when ">"
      "p+=#{match.length};"
    when "<"
      "p-=#{match.length};"
    end
  }
  final = 'mem=Hash.new(p=0);' + con_rb_code
  #puts final 
  return final
end

def main

  puts "Enter your brainfuck code"

  bf = ARGF.read
  #puts bf

  time_start = Time.now.getutc 
  # run ruby code
  eval naive(bf)
  time_end = Time.now.getutc

  #puts bf
  puts "Naive exe time: #{time_end - time_start}"

  time_start = Time.now.getutc 
  # run ruby code
  eval contraction(bf) 
  time_end = Time.now.getutc

  puts "Contraction exe time: #{time_end - time_start}"
end

main
