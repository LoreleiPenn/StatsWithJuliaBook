using Plots, LaTeXStrings, Measures

# Activate the PyPlot backend for Plots.
# pyplot()

f(x, y) = x^2 + y^2
f0(x) = f(x, 0)
f2(x) = f(x, 2)

xVals, yVals = -5:0.1:5 , -5:0.1:5
plot(xVals, [f0.(xVals), f2.(xVals)],
     color=[:blue :red], xlims=(-5, 5), legends=:top,
     ylims=(-5, 25), ylabel=L"f(x, \cdot)", label=[L"f(x, 0)" L"f(x, 2)"])
p1 = annotate!(0, -0.2, text("(0, 0) The minimum\n of f(x,0)", :left, :top, 10))

z = [f(x, y) for y ∈ yVals, x ∈ xVals]
p2 = surface(xVals, yVals, z, color=cgrad([:blue, :red]), legend=:none,
             ylabel="y", zlabel=L"f(x,y")

M = z[1:10, 1:10]
p3 = heatmap(M, color=cgrad([:blue, :red]), yflip=true, ylabel="y",
             xticks=([1:10;], xVals), yticks=([1:10;], yVals))
            
plot(p1, p2, p3, layout=(1, 3), size=(1200, 400), xlabel="x", margin=5mm)