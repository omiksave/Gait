function test_run(obj,event)
    if obj.UserData.split == 0
        obj.UserData.split = 1;
        obj.UserData.s = 1000;
        obj.UserData.a = 250;
    else
        obj.UserData.split = 0;
        obj.UserData.s = 0;
        obj.UserData.a = 250;
    end
end