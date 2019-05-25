# beállítások beállítása
do for [atildesqindex = 0:100] {
reset
set encoding utf8

# az ábrázolandó függvény beállítása
A=1
D=1
B=-1
T(x,y) = 4*pi * x**2 * y**2 / (x**2 + y**2)**2
TDC(x,y,atildesq) = 4*pi * x**2 * y**2/((x**2 + y**2)**2 + atildesq * (x**2 + y**2)**3)
λ(x,y) = - ((A + D) * x**2 + T(x,y)) / 2 + sqrt(((A + D) * x**2 + T(x,y))**2 - 4 * x**2 * (B + A * (D * x**2 + T(x,y)))) / 2
λDC(x,y,atildesq) = - ((A + D) * x**2 + TDC(x,y,atildesq)) / 2 + sqrt(((A + D) * x**2 + TDC(x,y,atildesq))**2 - 4 * x**2 * (B + A * (D * x**2 + TDC(x,y,atildesq)))) / 2

#formázási beállítások
set size sq
# set xrange [-pi/2:pi/2]
set xrange [-1.2:1.2]
# set yrange [-pi/2:pi/2]
set yrange [-1.2:1.2]
# set xtics ('-π/2' -pi/2, '-π/4'  -pi/4, "0" 0, 'π/4'  pi/4, 'π/2'  pi/2)
set xtics -1,0.5,1
# set ytics ('-π/2' -pi/2, '-π/4'  -pi/4, "0" 0, 'π/4'  pi/4, 'π/2'  pi/2)
set ytics -1,0.5,1
set sample 500
set isosample 500
set cbrange [-0.3:0.3]
load "diverging_palette.plt"
atildesq = 0.1*1.1**atildesqindex + atildesqindex * 0.1 - 0.1
print sprintf("atildesq = %f",atildesq)
set title sprintf("{/:Italic λ}_+ oldott atom nélkül, ã^2=%.2f",atildesq)

# az xy térkép beállítása
set table "function.tmp"
splot λDC(x,y,atildesq)
unset table

# a kontúrvonalak beállítása
set contour
set cntrparam points 10 levels discrete 0	
unset surface
set table "contour.tmp"
splot λDC(x,y,atildesq)
unset table

# a térkép és kontúrvonal együttes ábrázolása
unset key

# terminál és file beállítása
set term wxt

obn = "lambda_dc_k_surface"
set term pngcairo size 800,650 font "DejaVu Sans"

# set term pdfcairo size 8cm,6.5cm font "DejaVu Sans"
set o obn . sprintf("_atsqi=%d.png",atildesqindex)

p "function.tmp" w image, "contour.tmp" w l lt -1
}
set o
set term wxt
