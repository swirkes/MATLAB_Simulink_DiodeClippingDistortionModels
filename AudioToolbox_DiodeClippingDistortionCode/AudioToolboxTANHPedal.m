frameLength = 1024;

fileReader = dsp.AudioFileReader('ElectricGuitarSample.wav');
deviceWriter = audioDeviceWriter('SampleRate',fileReader.SampleRate);

scope = dsp.TimeScope('SampleRate',fileReader.SampleRate, ... 
                      'TimeSpan',2,'BufferLength',... 
                      fileReader.SampleRate*2*2,'YLimits', ... 
                      [-1,1],'TimeSpanOverrunAction',"Scroll");

process = @(x) (tanh(x.*25)/tanh(25));

while ~isDone(fileReader)
    mySignal = fileReader();
    myProcessedSignal = process(mySignal);
    deviceWriter(myProcessedSignal);
    scope([mySignal,mean(myProcessedSignal,2)])
end

release(fileReader);
release(deviceWriter);
release(scope);