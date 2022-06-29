using Plots, Images

img = load("data/stars.png")
gImg = red.(img) * 0.299 + green.(img) * 0.587 + blue.(img) * 0.114
rows, cols = size(img)

println("Highest intensity pixel: ", findmax(gImg))

function boxBlur(image, x, y, d)
    if x ≤ d || y ≤ d || x ≥ cols - d || y ≥ rows - d
        return image[x, y]
    else
        total = 0.0
        for xᵢ = x-d:x+d
            for yᵢ = y-d:y+d
                total += image[xᵢ, yᵢ]
            end
        end
        return total/((2d+1)^2)
    end
end

blurImg = [boxBlur(gImg, x, y, 5) for x ∈ 1:cols, y ∈ 1:rows]

π
yOriginal, xOriginal = argmax(gImg).I
yBoxBlur, xBoxBlur = argmax(blurImg).I

p1 = heatmap(gImg, color=:Greys, yflip=true)
p1 = scatter!((xOriginal, yOriginal), ms=60, ma=0, msw=4, msc=:red)
p2 = heatmap(blurImg, color=:Greys, yflip=true)
p2 = scatter!((xBoxBlur, yBoxBlur), ms=60, ma=0, msw=4, msc=:red)

plot(p1, p2, size=(800, 400), ratio=:equal, xlims=(0, cols), ylims=(0, rows),
     colorbar_entry=false, border=:none, legend=:none)