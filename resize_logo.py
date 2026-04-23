from PIL import Image

# Open the original logo
img = Image.open("assets/app/logo.png")

# Calculate new size (e.g. 50% of the original size)
new_width = int(img.width * 0.5)
new_height = int(img.height * 0.5)
resized_img = img.resize((new_width, new_height), Image.Resampling.LANCZOS)

# Create a new transparent image with the SAME original size (or wider)
# Android 12 splash screen trims the edges into a circle.
# So we make the base canvas large enough so the resized logo sits safely inside the circle.
canvas_size = max(img.width, img.height) * 2
new_img = Image.new("RGBA", (canvas_size, canvas_size), (255, 255, 255, 0))

# Paste the resized image into the center
paste_x = (canvas_size - new_width) // 2
paste_y = (canvas_size - new_height) // 2
new_img.paste(resized_img, (paste_x, paste_y))

new_img.save("assets/app/splash_logo.png")
print("Saved splash_logo.png")
