import random
import math
import wave
import struct
import csv
from PIL import Image, ImageDraw, ImageFont

def get_user_input(prompt_text, default, val_type=float):
    try:
        user_input = input(f"{prompt_text} (default: {default}): ").strip()
        return val_type(user_input) if user_input else default
    except:
        print(f"Invalid input. Using default: {default}")
        return default

def get_user_filename(prompt_text, default):
    name = input(f"{prompt_text} (default: {default}): ").strip()
    return name if name else default

def generate_freq_dur_amp(low_min, low_max, high_min, high_max, num_low=random.randint(1, 200), num_high=random.randint(1, 200)):
    low_freqs = [random.uniform(low_min, low_max) for _ in range(num_low)]
    high_freqs = [random.uniform(high_min, high_max) for _ in range(num_high)]
    low_durs = [random.uniform(0.1, 2.0) for _ in range(num_low)]
    high_durs = [random.uniform(0.1, 2.0) for _ in range(num_high)]
    low_amps = [random.uniform(0.1, 1.0) for _ in range(num_low)]
    high_amps = [random.uniform(0.1, 1.0) for _ in range(num_high)]
    low_data = list(zip(low_freqs, low_durs, low_amps))
    high_data = list(zip(high_freqs, high_durs, high_amps))
    data = low_data + high_data
    random.shuffle(data)
    return data

def write_wave_file(filename, freq_dur_amp_list, sample_rate=44100):
    wav_file = wave.open(filename, 'w')
    wav_file.setparams((1, 2, sample_rate, 0, 'NONE', 'not compressed'))
    max_amplitude = 32767
    for freq, dur, amp in freq_dur_amp_list:
        num_samples = int(sample_rate * dur)
        for i in range(num_samples):
            value = 0 if freq == 0 else int(max_amplitude * amp * math.sin(2 * math.pi * freq * i / sample_rate))
            data = struct.pack('<h', value)
            wav_file.writeframesraw(data)
    wav_file.close()
    print(f"Generated WAV: '{filename}'.")

def write_csv(filename, freq_dur_amp_list):
    with open(filename, 'w', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(['frequency_Hz', 'duration_sec', 'amplitude_0_to_1'])
        writer.writerows(freq_dur_amp_list)
    print(f"Generated CSV: '{filename}'.")

def print_text_spectrogram(freq_duration_list):
    max_freq = max(freq for freq, _, _ in freq_duration_list)
    min_freq = min(freq for freq, _, _ in freq_duration_list)
    max_dur = max(dur for _, dur, _ in freq_duration_list)
    rows, cols = 20, 40
    def freq_to_row(freq):
        return int((freq - min_freq) / (max_freq - min_freq + 1e-9) * (rows-1))
    print("\n Serial Inaudible Sound")
    grid = [[' ']*cols for _ in range(rows)]
    for freq, dur, _ in freq_duration_list:
        row = freq_to_row(freq)
        width = int((dur / max_dur) * cols)
        for c in range(width):
            grid[row][c] = '#'
    for r in reversed(range(rows)):
        freq_label = int(min_freq + (max_freq - min_freq) * r / (rows - 1))
        print(f"{freq_label:6} Hz | " + ''.join(grid[r]))
    print("       + " + '-'*cols)
    print("         " + "Time →")

def create_grayscale_image(filename, freq_duration_list, image_size=800, high_max_input=30000):
    width = height = image_size
    margin_left = 100
    margin_bottom = 70
    margin_top = 20
    margin_right = 20
    img_width = width + margin_left + margin_right
    img_height = height + margin_bottom + margin_top

    image = Image.new('L', (img_width, img_height), 255)
    draw = ImageDraw.Draw(image)
    font = ImageFont.load_default()

    total_duration = sum(dur for _, dur, _ in freq_duration_list)
    low_min, low_max = 0, 20
    high_min = 20000
    high_max = high_max_input

    def normalize_time(x):
        return int(x / total_duration * (width - 1)) if total_duration > 0 else 0

    def normalize_freq(f):
        if low_max - low_min == 0 or high_max - high_min == 0:
            return None  # avoid division by zero
        if low_min <= f < low_max:
            return int((f - low_min) / (low_max - low_min) * (height // 2 - 1))
        elif high_min < f <= high_max:
            return height // 2 + int((f - high_min) / (high_max - high_min) * (height // 2 - 1))
        else:
            return None

    current_time = 0
    for freq, dur, amp in freq_duration_list:
        y = normalize_freq(freq)
        if y is None:
            current_time += dur
            continue
        start_x = normalize_time(current_time)
        end_x = normalize_time(current_time + dur)
        gray = 255 - int(amp * 255)
        for x in range(start_x, min(end_x + 1, width)):
            for dy in range(-1, 2):
                yy = max(0, min(height - 1, y + dy))
                image.putpixel((margin_left + x, margin_top + height - 1 - yy), gray)
        current_time += dur

    for f in range(int(low_min), int(low_max)):
        y = normalize_freq(f)
        if y is not None:
            label_text = f"{f}Hz"
            draw.text((5, margin_top + height - 1 - y - 5), label_text, fill=0, font=font)

    for f in range(int(high_min), int(high_max) + 1, 1000):
        y = normalize_freq(f)
        if y is not None:
            label_text = f"{f}Hz"
            draw.text((5, margin_top + height - 1 - y - 5), label_text, fill=0, font=font)

    for i in range(6):
        t = total_duration * i / 5
        x = normalize_time(t)
        label_text = f"{t:.1f}s"
        draw.text((margin_left + x - 10, margin_top + height + 5), label_text, fill=0, font=font)

    image.save(filename)
    print(f"Generated grayscale spectrogram image: '{filename}'.")

if __name__ == '__main__':
    print("Enter frequency ranges and filenames. Press Enter to use default values.\n")
    low_min = get_user_input("Low frequency minimum (Hz)", 0)
    low_max = get_user_input("Low frequency maximum (Hz)", 20)
    high_min = get_user_input("High frequency minimum (Hz)", 20000)
    high_max = get_user_input("High frequency maximum (Hz)", 30000)

    wav_filename = get_user_filename("Output WAV filename", "output.wav")
    csv_filename = get_user_filename("Output CSV filename", "freq_duration.csv")
    img_filename = get_user_filename("Output image filename", "spectrogram.png")

    data = generate_freq_dur_amp(low_min, low_max, high_min, high_max)
    write_wave_file(wav_filename, data)
    write_csv(csv_filename, data)
    print_text_spectrogram(data)
    create_grayscale_image(img_filename, data, high_max_input=high_max)
