function keep_clean()

directory  = dir;
for i = 1:length(directory(1:end))
    check = directory(i).name;
    siz = directory(i).bytes;
   if length(check)>4 && siz ~=0
      if strcmp(check(end-3:end),'.DAT')~=1
        delete(check)
      end
   elseif siz == 0 && strcmp(check(1),'s') == 1
       rmdir(check,'s')
   elseif siz == 0 && strcmp(check(1),'V') == 1
       rmdir(check,'s')
   end
end

