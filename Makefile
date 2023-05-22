include generic_flags.mk

src=

all: clean


clean:
	$(RM) *.o
	$(RM) a.out


.PHONY: clean all
