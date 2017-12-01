def install_packages
  run 'apk add --update curl apache2-utils'
  run 'rm -rf /var/cache/apk/*'
end

from 'tomwilkie/prom-run'

install_packages

cmds = {
  slow: %w(-period 30s ab -n 1000 -c 80 http://nodejs-demo/),
  fast: %w(-period 60s ab -n 500 -c 40 http://nodejs-demo/),
  latest: [],
}

flatten

cmds.each do |tag,cmd|
  set_exec entrypoint: %w(/prom-run), cmd: cmd
  tag "docker.io/errordeveloper/prom-nodejs-demo-load-test:#{tag}"
end
