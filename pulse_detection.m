% Liczba ramek do wczytania (przy 10 sekundach i 30 FPS będzie to 300)
L = 300;
Fs = 30;

% wektor jasności
br = zeros(1, L);

% alternatywnie można załadować bezpośrednio plik wideo
v = VideoReader('movie.mp4');

% wczytanie pierwszych N obrazów i analiza jasności
for i=1:L
    % dla pliku wideo ładowanie ramki z otwartego źródła
    I = rgb2gray(read(v,i));
    % wyznaczamy średnią z całego obrazu
    br(i) = mean(I, 'all');
end

% dla ułatwienia późniejszej analizy od razu można odjąć od sygnału składową stałą
br = br - mean(br);

Y = fft(br);
A = abs(Y);
A = A/L;

A = A(1:L/2+1);
A(2:end-1) = 2*A(2:end-1);
F = angle(Y);
F = F(1:L/2+1);

f_step = Fs/L;
f = 0:f_step:Fs/2;

% wykres amplitudowy
figure;
plot(f, A);

[v, i] = maxk(A, 1);
ff = f(i);
ph = F(i);

pulse = 2 * Fs * ff;
disp(pulse);