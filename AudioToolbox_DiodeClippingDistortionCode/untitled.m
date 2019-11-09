frameLength = 1024;

fileReader = dsp.AudioFileReader('ElectricGuitarSample.wav');
deviceWriter = audioDeviceWriter('SampleRate',fileReader.SampleRate);

process = @(x) x.*5;

while ~isDone(fileReader)
    mySignal = fileReader();
    myProcessedSignal = process(mySignal);
    deviceWriter(myProcessedSignal);
end

release(fileReader);
release(deviceWriter);