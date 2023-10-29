import png

r = png.Reader(filename='640px-BSOD_Windows_8.svg.1bit.2.png')
(width, height, rows, info) = r.read()
for row in rows:
    if (sum(row) != 0):
        for pixel in row:
            print("{}".format(pixel), end='')
        print()


