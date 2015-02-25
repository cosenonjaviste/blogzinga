U=$1
#P=$( echo "$U" | perl -MURI -le 'chomp($url = <>); print URI->new($url)->fragment' )
final_url=$U
P=${P:1}
final_path=$2
mkdir -p ./gh-pages/_escaped_fragment_=
phantomjs ./bower_components/AngularJS-SEO-Article/.phantomjs-runner.js $final_url > ./gh-pages/_escaped_fragment_=/$final_path
