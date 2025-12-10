% input  : vectors B (numerator)
%          A (denominator)
%          Fs (sampling frequency in Hz)
% output : 1. Pole-zero plot for the digital filter in the Z-domain
%          2. Magnitude response of the filter (dB) in the f range (-Fs/2 -> Fs/2)
%          3. Phase response of the filter in the f range (-Fs/2 -> Fs/2)
%          4. Group delay of the filter in the ω range (-π -> π)
%          5. The filter's impulse response
% return : z which is zeros vector
%          p which is poles vector
%          k which is gain
function [z, p, k] = plot_filter_analysis(b, a, Fs)
    [z, p, k] = tf2zp(b, a);
    
    figure('Position', [50, 50, 1400, 700]);
    
% 1. Pole-zero plot
    subplot(3, 2, 1)
    zplane(b, a)
    title('Pole-Zero Plot in Z-Domain')
    grid on
    
% 2. Magnitude response (dB) from -Fs/2 to Fs/2
    subplot(3, 2, 2)
    [H, w] = freqz(b, a, 4096);
    f = w * Fs / (2*pi);
    H_neg = conj(H(end:-1:2));
    f_neg = -f(end:-1:2);
    H_full = [H_neg; H];
    f_full = [f_neg; f];
    mag_dB = 20*log10(abs(H_full));
    plot(f_full, mag_dB, 'LineWidth', 1.5)
    title('Magnitude Response')
    xlabel('Frequency (Hz)')
    ylabel('Magnitude (dB)')
    grid on
    xlim([-Fs/2, Fs/2])
    
% 3. Phase response (wrapped) from -Fs/2 to Fs/2
    subplot(3, 2, 3)
    phase_rad = angle(H_full);
    plot(f_full, phase_rad, 'LineWidth', 1.5)
    title('Phase Response (Wrapped)')
    xlabel('Frequency (Hz)')
    ylabel('Phase (radians)')
    grid on
    xlim([-Fs/2, Fs/2])
    
% 4. Phase response (unwrapped) from -Fs/2 to Fs/2
    subplot(3, 2, 4)
    phase_unwrapped = unwrap(angle(H_full));
    plot(f_full, phase_unwrapped, 'LineWidth', 1.5)
    title('Phase Response (Unwrapped)')
    xlabel('Frequency (Hz)')
    ylabel('Phase (radians)')
    grid on
    xlim([-Fs/2, Fs/2])
    
% 5. Group delay from -π to π
    subplot(3, 2, 5)
    [gd, w_gd] = grpdelay(b, a, 4096);
    w_neg = -w_gd(end:-1:2);
    gd_neg = gd(end:-1:2);
    w_full = [w_neg; w_gd];
    gd_full = [gd_neg; gd];
    plot(w_full, gd_full, 'LineWidth', 1.5)
    title('Group Delay')
    xlabel('Frequency (rad/sample)')
    ylabel('Group Delay (samples)')
    grid on
    xlim([-pi, pi])
    
% 6. Impulse response
    subplot(3, 2, 6)
    if length(b) > length(a) || max(abs(p)) < 0.95
        n_samples = min(100, length(b)*3);
    else
        n_samples = 100;
    end
    [h_imp, n_imp] = impz(b, a, n_samples);
    stem(n_imp, h_imp, 'filled')
    title('Impulse Response')
    xlabel('Sample (n)')
    ylabel('Amplitude')
    grid on
    
% Add overall title
    sgtitle('Filter Analysis', 'FontSize', 14, 'FontWeight', 'bold')
end
