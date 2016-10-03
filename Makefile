# makefile for alarm library for Lua

# these will probably work if Lua has been installed globally
LUA= /usr
LUAINC= $(LUA)/include/$(LUAVER)
LUALIB= $(LUA)/lib
LUABIN= $(LUA)/bin
LUAVER= lua5.1

# probably no need to change anything below here
CC= gcc
CFLAGS= $(INCS) $(WARN) -O2 $G -fPIC
WARN= -pedantic -Wall
INCS= -I$(LUAINC)
MAKESO= $(CC) -shared

MYNAME= alarm
MYLIB= l$(MYNAME)
T= $(MYNAME).so
OBJS= $(MYLIB).o
TEST= test.lua

all:	test

test:	$T
	$(LUABIN)/lua $(TEST)

o:	$(MYLIB).o

so:	$T

$T:	$(OBJS)
	$(MAKESO) -o $@ $(OBJS)

clean:
	rm -f $(OBJS) $T core core.*

doc:
	@echo "$(MYNAME) library:"
	@fgrep '/**' $(MYLIB).c | cut -f2 -d/ | tr -d '*' | sort | column

# distribution

FTP= $(HOME)/public/ftp/lua/5.1
D= $(MYNAME)
A= $(MYLIB).tar.gz
TOTAR= Makefile,README,$(MYLIB).c,test.lua

distr:	clean
	tar zcvf $A -C .. $D/{$(TOTAR)}
	touch -r $A .stamp
	mv $A $(FTP)

diff:	clean
	tar zxf $(FTP)/$A
	diff $D .

# eof
