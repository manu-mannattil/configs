# vim: ft=sh fdm=marker et sts=4 sw=4
#
# torrent.tmux -- a tmux session to run rtorrent
#

tmux new-session -A -s "torrent" "rtorrent"
