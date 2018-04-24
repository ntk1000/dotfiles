# set dock left
defaults write com.apple.dock orientation -string "left"
# set dock autohide
defaults write com.apple.dock autohide -bool true
# set dock icon tiny
defaults write com.apple.dock tilesize -int 30
# restart dock
killall Dock

