```julia
include("../yaoimport.jl");
```

# create a maximally entangled Bell state


```julia
Φcircuit = chain(2, 
    put(1=>H), 
    control(1, 2=>X)
)
Φ = zero_state(2) |> Φcircuit
state(Φ)
```




    4×1 Matrix{ComplexF64}:
     0.7071067811865475 + 0.0im
                    0.0 + 0.0im
                    0.0 + 0.0im
     0.7071067811865475 + 0.0im




```julia
svgplot(Φcircuit)
```


    
![svg](output_3_0.svg)
    


# define the teleportation circuit


```julia
tele = chain(3,
    control(1, 2=>X),
    put(1=>H),
    control(2,3=>X),
    control(1,3=>Z),
)
svgplot(tele)
```


    
![svg](output_5_0.svg)
    


 total circuit


```julia
chain(3, put(2:3 => Φcircuit), tele) |> svgplot
```


    
![svg](output_7_0.svg)
    


# run teleportation


```julia
ψ = rand_state(1)
state(ψ)
```




    2×1 Matrix{ComplexF64}:
     0.06792629615178038 + 0.4137280604342298im
     0.03792192079546314 - 0.9070705806185169im




```julia
out = join(ψ,Φ) |> tele
state(out)
```




    8×1 Matrix{ComplexF64}:
     0.06792629615178036 + 0.4137280604342297im
                     0.0 + 0.0im
                     0.0 + 0.0im
                     0.0 + 0.0im
     0.03792192079546313 - 0.9070705806185168im
                    -0.0 - 0.0im
                     0.0 + 0.0im
                    -0.0 - 0.0im



discard qubits 1,2


```julia
measure!(RemoveMeasured(), out, 1:2) 
state(out)
```




    2×1 Matrix{ComplexF64}:
     0.06792629615178038 + 0.4137280604342298im
     0.03792192079546314 - 0.907070580618517im




```julia

```
