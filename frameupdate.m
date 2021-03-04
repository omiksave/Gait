function [LHEE,RHEE,LF,RF] = frameupdate(MyClient)
    MyClient.GetFrame();
    LF = MyClient.GetGlobalForceVector(1,1).ForceVector(3);
    RF = MyClient.GetGlobalForceVector(2,1).ForceVector(3);
    LHEE = MyClient.GetMarkerGlobalTranslation('Test','LHEE').Translation(2);
    RHEE = MyClient.GetMarkerGlobalTranslation('Test','RHEE').Translation(2);
end