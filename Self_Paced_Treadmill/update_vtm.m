function update_vtm(trg,~)
fread(trg,1,'uint8');
trg.UserData.vtm = fread(trg,4,'int16');
flushinput(trg);%Clear Input Buffer
%disp(trg.UserData.vtm)
end