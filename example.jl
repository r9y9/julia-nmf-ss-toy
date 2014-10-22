include("stft.jl")
include("nmf.jl")

using WAV

x, fs = wavread("test10k.wav")
@assert fs == 10000

x = vec(x)

framelen = 512
hopsize = div(framelen, 2)
X = stft(x, framelen, hopsize)

Y, phase = abs(X), angle(X)

# perform NMF on spectrogram
K = 4
srand(98765)
@time H, U = nmf_euc(Y, K)

for k=1:K
    y = istft(H[:,k]*U[k,:] .* exp(im * phase), framelen, hopsize)
    wavwrite(float16(y), string(k, ".wav"), Fs=fs)
end
