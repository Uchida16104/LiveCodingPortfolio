# Final retry: corrected string literal and regenerate SVG with legend centered below time-axis ticks.
import pandas as pd, math, html
csv_path = "/tmp/midi_log.csv"
df = pd.read_csv(csv_path, header=None, names=[
    "time","note","velocity","attack","attack_level","decay","decay_level","sustain","sustain_level","release",
    "amp","mix","pan","pitch","cutoff","stereo_width","hard","fx_summary"
])

df["time_rel"] = (df["time"] - df["time"].min()).astype(float)
df["duration"] = (df["sustain"].fillna(0) + df["release"].fillna(0)).clip(lower=0.05, upper=6.0)
df["pitch_total"] = (df["note"].astype(float) + df["pitch"].astype(float)).clip(0,127)

W = 1600; H = 1000; margin = 120
plot_w = W - margin*2
plot_h = H - margin*2 - 140

t_min, t_max = df["time_rel"].min(), df["time_rel"].max()
if t_max - t_min < 0.1:
    t_max = t_min + 10.0
def time_to_x(t):
    return margin + ((t - t_min) / (t_max - t_min)) * plot_w

p_min = max(0, df["pitch_total"].min() - 4)
p_max = min(127, df["pitch_total"].max() + 4)
if p_max - p_min < 12:
    p_max = p_min + 12
def pitch_to_y(p):
    return margin + (1 - (p - p_min) / (p_max - p_min)) * plot_h

def fx_to_shape(fx_summary):
    s = str(fx_summary).lower()
    if "distort" in s or "distortion" in s:
        return "triangle"
    if "flanger" in s:
        return "diamond"
    if "echo" in s:
        return "ellipse"
    if "slicer" in s:
        return "star"
    return "rect"

def visual_style(row):
    hard = float(row["hard"]) if not pd.isna(row["hard"]) else 0.2
    cutoff = float(row["cutoff"]) if not pd.isna(row["cutoff"]) else 80.0
    amp = float(row["amp"]) if not pd.isna(row["amp"]) else 0.5
    pan = float(row["pan"]) if not pd.isna(row["pan"]) else 0.0
    hue = int(max(0.0, min(1.0, hard)) * 360)
    sat = int(40 + (max(10.0, min(130.0, cutoff)) - 10) / 120.0 * 60)
    light = int(30 + max(0.0, min(1.0, amp)) * 40)
    opacity = max(0.12, min(1.0, amp))
    pan_bias = (pan + 1.0) / 2.0
    return {"hue":hue, "sat":sat, "light":light, "opacity":opacity, "pan_bias":pan_bias}

svg_parts = []
svg_parts.append('<?xml version="1.0" encoding="UTF-8"?>')
svg_parts.append(f'<svg width="{W}" height="{H}" viewBox="0 0 {W} {H}" xmlns="http://www.w3.org/2000/svg">')
svg_parts.append('<style> .label{font:12px/1.2 "Helvetica Neue", Arial, sans-serif; fill:#222;} .title{font:20px/1.2 "Helvetica Neue", Arial, sans-serif; fill:#111; font-weight:700;} .small{font:11px; fill:#333;} </style>')
svg_parts.append(f'<rect width="100%" height="100%" fill="#fbfbfb"/>')
svg_parts.append(f'<text x="{W/2}" y="36" class="title" text-anchor="middle">Klavierstücke — Hirotoshi Uchida</text>')

staff_top = margin + plot_h*0.15
staff_spacing = (plot_h*0.5) / 8.0
for i in range(9):
    y = staff_top + i*staff_spacing
    stroke_w = 1 if i in (2,3,4,5,6) else 0.6
    svg_parts.append(f'<line x1="{margin}" y1="{y:.2f}" x2="{margin+plot_w}" y2="{y:.2f}" stroke="#cfcfcf" stroke-width="{stroke_w}"/>')

n_ticks = 8
for i in range(n_ticks+1):
    t = t_min + (t_max - t_min) * i / n_ticks
    x = time_to_x(t)
    svg_parts.append(f'<line x1="{x:.2f}" y1="{margin+plot_h+6}" x2="{x:.2f}" y2="{margin+plot_h+14}" stroke="#999" stroke-width="1"/>')
    svg_parts.append(f'<text x="{x:.2f}" y="{margin+plot_h+34}" class="small" text-anchor="middle">{t:.2f}s</text>')

svg_parts.append(f'<text x="{margin-60}" y="{margin+plot_h/2}" transform="rotate(-90 {margin-60} {margin+plot_h/2})" class="small" text-anchor="middle">Pitch (MIDI)</text>')

# Centered legend below time-axis ticks
legend_width = 640
legend_height = 220
legend_x = margin + (plot_w - legend_width) / 2.0
legend_y = margin + plot_h + 46
svg_parts.append(f'<rect x="{legend_x-8:.2f}" y="{legend_y-12:.2f}" width="{legend_width+16:.2f}" height="{legend_height+28:.2f}" rx="8" fill="#ffffff" stroke="#e0e0e0"/>')
svg_parts.append(f'<text x="{legend_x+legend_width/2:.2f}" y="{legend_y+8:.2f}" class="label" text-anchor="middle">Legend / Key</text>')

ly = legend_y + 28
lines = [
    ("Horizontal position (x)", "time (time) — left = start, right = later"),
    ("Horizontal length (width)", "duration ≈ sustain + release (sustain + release)"),
    ("Vertical position (y)", "pitch (note + pitch) — higher = higher"),
    ("Vertical size (height)", "ADSR combined intensity (attack+decay+sustain+release)"),
    ("Fill opacity", "amp — louder = more opaque"),
    ("Gradient bias", "pan (-1 left .. +1 right)"),
    ("Saturation", "cutoff (filter cutoff)"),
    ("Hue", "hard (0.0..1.0)"),
    ("Shape type", "fx (reverb/echo/flanger/distortion/slicer → rect/ellipse/diamond/triangle/star)"),
]
text_x_label = legend_x + 12
text_x_desc = legend_x + 260
for label, desc in lines:
    svg_parts.append(f'<text x="{text_x_label:.2f}" y="{ly:.2f}" class="small">{html.escape(label)}</text>')
    svg_parts.append(f'<text x="{text_x_desc:.2f}" y="{ly:.2f}" class="small" fill="#666">{html.escape(desc)}</text>')
    ly += 22

ex_y = ly + 6
svg_parts.append(f'<text x="{legend_x+12:.2f}" y="{ex_y:.2f}" class="small" font-weight="700">Example mappings:</text>')
ex_y += 18
example_fx = [("reverb","rect"),("echo","ellipse"),("flanger","diamond"),("distortion","triangle"),("slicer","star")]
ex_x = legend_x + 12
for fx_name, shape in example_fx:
    if shape=="rect":
        svg_parts.append(f'<rect x="{ex_x:.2f}" y="{ex_y:.2f}" width="28" height="16" rx="3" fill="#6699cc" />')
    elif shape=="ellipse":
        svg_parts.append(f'<ellipse cx="{ex_x+14:.2f}" cy="{ex_y+8:.2f}" rx="18" ry="8" fill="#66cc99"/>')
    elif shape=="diamond":
        pts = f"{ex_x+14},{ex_y} {ex_x+28},{ex_y+8} {ex_x+14},{ex_y+16} {ex_x},{ex_y+8}"
        svg_parts.append(f'<polygon points="{pts}" fill="#cc66cc"/>')
    elif shape=="triangle":
        pts = f"{ex_x},{ex_y+16} {ex_x+28},{ex_y+16} {ex_x+14},{ex_y}"
        svg_parts.append(f'<polygon points="{pts}" fill="#ff6666"/>')
    elif shape=="star":
        svg_parts.append(f'<path d="M{ex_x+14} {ex_y} L{ex_x+17} {ex_y+11} L{ex_x+28} {ex_y+11} L{ex_x+19} {ex_y+17} L{ex_x+22} {ex_y+28} L{ex_x+14} {ex_y+21} L{ex_x+6} {ex_y+28} L{ex_x+9} {ex_y+17} L{ex_x} {ex_y+11} L{ex_x+11} {ex_y+11} Z" fill="#ffcc66"/>')
    svg_parts.append(f'<text x="{ex_x+36:.2f}" y="{ex_y+12:.2f}" class="small">{fx_name}</text>')
    ex_x += 108

# lanes to avoid overlaps
n_lanes = 24
lane_pitches = [p_min + (p_max - p_min) * i/(n_lanes-1) for i in range(n_lanes)]
lane_centers = [pitch_to_y(p) for p in lane_pitches]
def nearest_lane(p):
    diffs = [abs(p - lp) for lp in lane_pitches]
    return diffs.index(min(diffs))

df['lane'] = df['pitch_total'].apply(nearest_lane)
lane_offsets = {i:0 for i in range(n_lanes)}

svg_defs = ['<defs>']
grad_id = 0
shape_elements = []

# sample if too many shapes
max_shapes = 1200
if len(df) > max_shapes:
    df_render = df.sort_values('time_rel').reset_index(drop=True)
    step = int(math.ceil(len(df_render)/max_shapes))
    df_render = df_render.iloc[::step].reset_index(drop=True)
else:
    df_render = df.copy().reset_index(drop=True)

for idx, row in df_render.iterrows():
    x = time_to_x(row["time_rel"])
    w = max(4.0, min(160.0, (row["duration"] / 6.0) * 160.0))
    lane = int(row['lane'])
    count_in_lane = lane_offsets[lane]
    lane_offsets[lane] += 1
    y_center = lane_centers[lane] + (count_in_lane % 5) * 6 - 12
    # compute ADSR combined scalar safely
    attack = float(row["attack"]) if not pd.isna(row["attack"]) else 0.0
    decay = float(row["decay"]) if not pd.isna(row["decay"]) else 0.0
    sustain_level = float(row["sustain_level"]) if not pd.isna(row["sustain_level"]) else 0.5
    release = float(row["release"]) if not pd.isna(row["release"]) else 0.1
    adsr_scalar = max(0.1, min(1.0, (attack*0.2 + decay*0.15 + sustain_level*0.5 + release*0.15)))
    h = max(6.0, min(48.0, adsr_scalar * 48.0))
    style = visual_style(row)
    hue, sat, light, opacity, pan_bias = style["hue"], style["sat"], style["light"], style["opacity"], style["pan_bias"]
    color_css = f"hsl({hue},{sat}%,{light}%)"
    gid = f"g{grad_id}"
    grad_id += 1
    stop1_pos = max(0, min(100, int((1.0 - pan_bias) * 100)))
    stop2_pos = max(0, min(100, int(pan_bias * 100)))
    svg_defs.append(f'<linearGradient id="{gid}" x1="0%" y1="0%" x2="100%" y2="0%"><stop offset="{stop1_pos}%" stop-color="white" stop-opacity="{max(0.03,1-opacity):.3f}"/><stop offset="{stop2_pos}%" stop-color="{color_css}" stop-opacity="{opacity:.3f}"/></linearGradient>')
    shape = fx_to_shape(row["fx_summary"])
    title_txt = f"time={row['time_rel']:.3f}s note={int(row['note'])} pitch_total={row['pitch_total']:.1f} amp={row['amp']:.3f} sustain={row['sustain']:.3f} release={row['release']:.3f} fx={html.escape(str(row['fx_summary']))}"
    x_draw = x - w/2.0  # center shapes at event time for clarity
    if shape == "rect":
        rx = 4
        el = f'<rect x="{x_draw:.2f}" y="{y_center - h/2:.2f}" width="{w:.2f}" height="{h:.2f}" rx="{rx}" fill="url(#{gid})" stroke="#333" stroke-opacity="0.06"/>'
    elif shape == "ellipse":
        el = f'<ellipse cx="{x_draw + w/2:.2f}" cy="{y_center:.2f}" rx="{w/2:.2f}" ry="{h/2:.2f}" fill="url(#{gid})" stroke="#333" stroke-opacity="0.06"/>'
    elif shape == "diamond":
        pts = f"{x_draw + w/2:.2f},{y_center - h/2:.2f} {x_draw + w:.2f},{y_center:.2f} {x_draw + w/2:.2f},{y_center + h/2:.2f} {x_draw:.2f},{y_center:.2f}"
        el = f'<polygon points="{pts}" fill="url(#{gid})" stroke="#333" stroke-opacity="0.06"/>'
    elif shape == "triangle":
        pts = f"{x_draw:.2f},{y_center + h/2:.2f} {x_draw + w:.2f},{y_center + h/2:.2f} {x_draw + w/2:.2f},{y_center - h/2:.2f}"
        el = f'<polygon points="{pts}" fill="url(#{gid})" stroke="#333" stroke-opacity="0.06"/>'
    else:
        cx = x_draw + w/2.0
        cy = y_center
        r_out = max(6, min(24, w/6.0 + h/4.0))
        r_in = r_out * 0.45
        pts = []
        for k in range(10):
            ang = math.pi*2 * k / 10.0 - math.pi/2.0
            r = r_out if k%2==0 else r_in
            pts.append(f"{cx + math.cos(ang)*r:.2f},{cy + math.sin(ang)*r:.2f}")
        pts_s = " ".join(pts)
        el = f'<polygon points="{pts_s}" fill="url(#{gid})" stroke="#333" stroke-opacity="0.06"/>'
    el = f'<g><title>{html.escape(title_txt)}</title>{el}</g>'
    shape_elements.append(el)

svg_defs.append('</defs>')
svg_parts.extend(svg_defs)

svg_parts.append(f'<g clip-path="url(#clipPlot)">')
svg_parts.append(f'<clipPath id="clipPlot"><rect x="{margin}" y="{margin}" width="{plot_w}" height="{plot_h}"/></clipPath>')
svg_parts.extend(shape_elements)
svg_parts.append('</g>')

svg_parts.append(f'<text x="{margin}" y="{margin-12}" class="small">Time →</text>')
svg_parts.append(f'<text x="{margin+plot_w+40}" y="{margin+20}" class="small">Legend moved below the time-axis ticks.</text>')

summary_txt = f"Events: {len(df)}  Rendered: {len(df_render)}  Time range: {t_max - t_min:.2f}s  Pitch range: {int(p_min)}–{int(p_max)}"
summary_y = legend_y + legend_height + 28
svg_parts.append(f'<text x="{margin}" y="{summary_y:.2f}" class="small">{html.escape(summary_txt)}</text>')

svg_parts.append('</svg>')
svg_text = "\n".join(svg_parts)

out_path = "/tmp/klavierstucke.svg"
with open(out_path, "w", encoding="utf-8") as f:
    f.write(svg_text)

print("SVG generated:", out_path)
print("Rendered events:", len(df_render))
print("Legend box at x,y:", (legend_x, legend_y))

