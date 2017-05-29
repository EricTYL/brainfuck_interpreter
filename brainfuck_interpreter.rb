eval 'mem=Hash.new(p=0);'+ARGF.read.gsub(/./,
	      '>' => 'p+=1;',
	      '<' => 'p-=1;',
	      '+' => 'mem[p]+=1;',
	      '-' => 'mem[p]-=1;',
	      '.' => 'putc mem[p];',
	      ',' => 'mem[p]=STDIN.getbyte if !STDIN.eof;',
	      '[' => 'while mem[p]!=0 do ',
	      ']' => 'end;')
