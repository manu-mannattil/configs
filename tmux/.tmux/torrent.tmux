# vim: ft=sh fdm=marker et sts=4 sw=4
#
# torrent.tmux -- a tmux session to run rtorrent in a Docker container
#

tmux new-session -A -s "torrent" "sudo docker start -i rtorrent"
