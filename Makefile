default: config

ZSH_FILES:=.zshrc .zshenv
TMUX_FILES:=.tmux.conf
VIM_FILES:=.vimrc
SOURCE_PREFIX:=~/
DEST_FILES:=$(ZSH_FILES) $(TMUX_FILES) $(VIM_FILES)
SOURCE_FILES:=$(foreach F,$(DEST_FILES),$(SOURCE_PREFIX)$(F))

config: $(DEST_FILES)

$(DEST_FILES): %: $(SOURCE_PREFIX)%
	@cp $(SOURCE_PREFIX)$(@) .

echo-%:
	@echo "$*=$($*)"

.PHONY: config echo-%
