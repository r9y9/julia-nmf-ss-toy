### NMF ###

# NMF minimize ||Y-HU||₂
function nmf_euc(Y::AbstractMatrix, K::Int=4;
                        maxiter::Int=100)
    H = rand(size(Y, 1), K)
    U = rand(K, size(Y, 2))
    const ϵ = 1.0e-21
    for i=1:maxiter
        H = H .* (Y*U') ./ (H*U*U' + ϵ)
        U = U .* (H'*Y) ./ (H'*H*U + ϵ)
        U = U ./ maximum(U)
    end
    return H, U
end
