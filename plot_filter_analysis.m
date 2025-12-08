% input  : vectors B (numerator)
%          A (denominator)
% output : 1. Pole-zero plot for the digital filter in the Z´domain
%          2. Magnitude and phase response of the filter (dB) in the f range (-FS/2 -> Fs/2)
%          3. Phase response of the filter in the f range (-FS/2 -> Fs/2)
%          4. Group delay of the filter in the ω range (-π -> π)
%          5. The filter’s impulse response
% return : z which is zeros vector
%          p which is poles vector

function [z, p] = plot_filter_analysis(b, a, Fs)

    % 0. Zeros, Poles, Gain
    [z, p, k] = tf2zp(b, a);

    % 1. Pole-zero plot
    figure
    zplane(z, p)
    title('Pole-Zero Plot in Z-Domain')
    grid on

    % 2. Magnitude and phase response (dB)
    [H, f] = freqz(b, a, 2048, Fs);
    H_shift = fftshift(H);
    f_shift = f - Fs/2;

    mag_H_dB = 20*log10(abs(H_shift));
    figure
    plot(f_shift, mag_H_dB)
    title('Magnitude Response (dB)')
    xlabel('Frequency (Hz)')
    ylabel('Magnitude (dB)')
    grid on

    figure
    plot(f_shift, angle(H_shift))  % Wrapped phase
    title('Phase Response (Wrapped)')
    xlabel('Frequency (Hz)')
    ylabel('Phase (radians)')
    grid on

    % 3. Phase response (unwrapped)
    figure
    plot(f_shift, unwrap(angle(H_shift)))  % Unwrapped phase
    title('Phase Response (Unwrapped)')
    xlabel('Frequency (Hz)')
    ylabel('Phase (radians)')
    grid on

    % 4. Group delay
    [gd, w] = grpdelay(b, a, 2048);
    w = w - pi; % shift from 0->pi to -pi->pi
    figure
    plot(w, gd)
    title('Group Delay')
    xlabel('Frequency (rad/sample)')
    ylabel('Samples')
    grid on

    % 5. Impulse response
    figure
    impz(b, a)
    title('Impulse Response')
    grid on

end
