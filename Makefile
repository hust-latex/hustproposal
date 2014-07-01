# OS detected
ifeq ($(OS),Windows_NT)
	ifneq ($(findstring .exe,$(SHELL)),)
    OS_TYPE := Windows
	else
    OS_TYPE := Cygwin
	endif
else
    OS_TYPE := $(shell uname -s)
endif

all:unpack example doc
example:example-zh example-en

unpack:FORCE
	make -C ./hustproposal unpack

example-zh ./hustproposal/hustproposal-zh-example.pdf:
	make -C ./hustproposal example-zh

example-en ./hustproposal/hustproposal-en-example.pdf:
	make -C ./hustproposal example-en

doc ./hustproposal/hustproposal.pdf:
	make -C ./hustproposal doc

clean:
	make -C ./hustproposal clean

reallyclean:
	make -C ./hustproposal reallyclean

install:unpack ./hustproposal/hustproposal-zh-example.pdf ./hustproposal/hustproposal-en-example.pdf ./hustproposal/hustproposal.pdf
ifeq ($(OS_TYPE),Windows)
	./install/win32.bat install
else
	./install/unix.sh install
endif

uninstall:
ifeq ($(OS_TYPE),Windows)
	./install/win32.bat uninstall
else
	./install/unix.sh uninstall
endif

checksum:FORCE
	make -C ./hustproposal checksum

FORCE:
.PHONY:all unpack example example-zh example-en doc install uninstall clean reallyclean checksum FORCE
