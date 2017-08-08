from 'alpine'

run 'apk add --update curl apache2-utils'
run 'rm -rf /var/cache/apk/*'

cmds = {
  slow: "while true; do (ab -n 1000 -c 80 http://nodejs-demo/; sleep 30;); done",
  fast: "while true; do (ab -n 500 -c 40 http://nodejs-demo/; sleep 60;); done",
}

flatten

cmds.each do |tag,cmd|
  set_exec entrypoint: %w(sh -c), cmd: [cmd]
  tag "docker.io/errordeveloper/prom-nodejs-demo-load-test:#{tag}"
end
