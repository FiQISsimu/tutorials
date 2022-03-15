# install Yao/YaoPlots via 
#     using Pkg
#     Pkg.add("Yao")
#     Pkg.add("YaoBase")
#     Pkg.add("YaoPlots")
#     Pkg.add("Compose")

using Yao,YaoPlots,YaoBase,LinearAlgebra,Compose,Base.Filesystem

YaoPlots.CircuitStyles.linecolor[] = "#3283a8"
YaoPlots.CircuitStyles.textcolor[] = "#3283a8"

function svgplot(args...)
    file = tempname() * ".svg"
    draw(SVG(file, 24cm, 8cm),plot(args...))
    open(file) do f
        display("image/svg+xml", read(f, String))
    end
end;

#svgplot(args...) = plot(args...)

# fix adjoint bug
# Base.adjoint(blk::ChainBlock{D}) where {D} = ChainBlock(blk.n, map(x->convert(AbstractBlock{D},adjoint(x)), reverse(subblocks(blk))))
