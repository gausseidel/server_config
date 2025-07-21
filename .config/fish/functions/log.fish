function log --wraps='journalctl -xe' --description 'alias log journalctl -xe'
  journalctl -xe $argv
        
end
