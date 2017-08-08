%w{
aspell
aspell-en
curl
emacs-nox
git
make
man-pages
mg
pcre-devel
pkgconfig
rsync
tmux
screen
unzip
}.each do |a_pkg|
	package "#{a_pkg}"
end
