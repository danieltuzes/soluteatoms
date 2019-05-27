# beállítások beállítása
do for [Aindex = 0:100] {
reset
set encoding utf8

# az ábrázolandó függvény beállítása
A = Aindex * 0.1
D = 1
B = -1
T(x,y) = 4*pi * x**2 * y**2 / (x**2 + y**2)**2
λ(x,y) = - ((A + D) * x**2 + T(x,y)) / 2 + sqrt(((A + D) * x**2 + T(x,y))**2 - 4 * x**2 * (B + A * (D * x**2 + T(x,y)))) / 2

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
print sprintf("A = %f",A)
set title sprintf("{/:Italic λ}_+ különböző A korreláció, A=%.2f",A)

# az xy térkép beállítása
set table "function.tmp"
splot λ(x,y)
unset table

# a kontúrvonalak beállítása
set contour
set cntrparam points 10 levels discrete 0
unset surface
set table "contour.tmp"
splot λ(x,y)
unset table

# a térkép és kontúrvonal együttes ábrázolása
unset key

# terminál és file beállítása
set term wxt

obn = "lambda_A_k_surface"
set term pngcairo size 800,650 font "DejaVu Sans"

# set term pdfcairo size 8cm,6.5cm font "DejaVu Sans"
set o obn . sprintf("_Ai=%d.png",Aindex)

p "function.tmp" w image, "contour.tmp" w l lt -1
}
set o
set term wxt
