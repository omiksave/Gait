function temp = get_vtm()
    
    trg = tcpip('localhost',4000,'InputBufferSize',32,'BytesAvailableFcnMode','byte','BytesAvailableFcnCount',32);%,'BytesAvailableFcn',@curr_vtm);
    fopen(trg);
    while trg.BytesAvailable<=24
        continue;
    end
    fread(trg,1,'uint8');
    temp = fread(trg,4,'int16');
    fclose(trg);
    delete(trg);
end
    