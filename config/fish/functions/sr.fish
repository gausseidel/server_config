function sr --wraps='systemctl restart' --description 'alias sr systemctl restart'
  systemctl restart $argv
        
end
