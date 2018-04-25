.PHONY: install uninstall

install:
	./install.sh

# testes para a apresentação P1
fact:
	ruby ./ruby/main.rb

add:
	ruby ./testes/add.rb

sub:
	ruby ./testes/sub.rb

mul:
	ruby ./testes/mul.rb

div:
	ruby ./testes/div.rb

while:
	ruby ./testes/while.rb

if:
	ruby ./testes/if.rb


uninstall:
	gem uninstall parslet
	rbenv uninstall 2.5.1
	brew uninstall rbenv