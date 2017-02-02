default: config

PRESERVE_MODE?='--no-preserve=mode'

define extract=
sed -e 's/[# \t].*$$//' -e '/^$$/d' tracked.conf
endef

SOURCE_FILES=$(shell $(extract))
DEST_FILES=$(foreach f,$(SOURCE_FILES),$(f:~%=.%))
config: $(DEST_FILES)

$(DEST_FILES): ./%: ~/%
	cp $(PRESERVE_MODE) ~/$@ ./$*

clean:
	@$(RM) $(DEST_FILES)

echo-%:
	@echo "$*=$($*)"

.PHONY: config clean echo-%
