"""生成站点图标：favicon.svg / favicon-16x16.png / favicon-32x32.png / apple-touch-icon.png / favicon.ico"""
from PIL import Image, ImageDraw, ImageFont
from pathlib import Path

out = Path(__file__).resolve().parent.parent / "static"
out.mkdir(parents=True, exist_ok=True)

BG = (46, 46, 51, 255)      # #2e2e33，与主题 theme_color 一致
FG = (245, 245, 247, 255)

SVG = """<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64">
  <rect width="64" height="64" rx="14" fill="#2e2e33"/>
  <text x="32" y="43" font-family="Segoe UI, Helvetica, Arial, sans-serif"
        font-size="30" font-weight="600" fill="#f5f5f7" text-anchor="middle">YL</text>
</svg>
"""
(out / "favicon.svg").write_text(SVG, encoding="utf-8")


def font(size):
    for name in ("segoeuib.ttf", "arialbd.ttf", "DejaVuSans-Bold.ttf"):
        try:
            return ImageFont.truetype(name, size)
        except OSError:
            continue
    return ImageFont.load_default()


def render(size):
    # 4x 超采样后缩小，边缘更干净
    s = size * 4
    img = Image.new("RGBA", (s, s), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    d.rounded_rectangle([0, 0, s - 1, s - 1], radius=int(s * 0.22), fill=BG)
    f = font(int(s * 0.46))
    d.text((s / 2, s / 2 + s * 0.02), "YL", font=f, fill=FG, anchor="mm")
    return img.resize((size, size), Image.LANCZOS)


for size in (16, 32, 180):
    name = "apple-touch-icon.png" if size == 180 else f"favicon-{size}x{size}.png"
    render(size).save(out / name)

render(64).save(out / "favicon.ico", sizes=[(16, 16), (32, 32), (48, 48), (64, 64)])
print("icons written to", out)
for p in sorted(out.iterdir()):
    print(" -", p.name, p.stat().st_size, "bytes")
