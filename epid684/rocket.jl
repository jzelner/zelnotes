using JuMP
import Ipopt
import Plots

sir = Model(Ipopt.Optimizer)
set_silent(sir)

p1 = 0.75
p2 = 1 - p1
ρ = 0.5
w12 = (1 - ρ) * p2
w11 = 1 - w12

ratio = [1.0, 2.0]


w = [w11 w12
    1-ρ ρ]

I_0 = 0.01
S_0 = 1 - I_0
R_0 = 0
gamma = 0.5
#beta = 2
Δt = 0.1
n = 800    # Time step

@variables(sir, begin
    # Time step 
    # State variables
    x[1:n, 1:2, 1:3] ≥ 0
    beta >= 0.1
end);

for i in 1:2
    fix(x[1, i, 1], (1 - I_0), force=true)
    fix(x[1, i, 2], I_0, force=true)
    fix(x[1, i, 3], 0, force=true)
end


@NLconstraint(sir,(p1*x[n, 1, 3] + p2*x[n,2,3]) >= 0.1)

for j in 2:n
    for i in 1:2
        @NLconstraint(sir, x[j, i, 2] == x[j-1, i, 2] + Δt * ((-x[j-1, i, 2] * gamma) + (beta * ratio[i] * x[j-1, i, 1] * (w[i, 1] * x[j-1, 1, 2] + w[i, 2] * x[j-1, 2, 2]))))

        @NLconstraint(sir, x[j, i, 1] == x[j-1, i, 1] + Δt * (-beta * ratio[i] * x[j-1, i, 1] * (w[i, 1] * x[j-1, 1, 2] + w[i, 2] * x[j-1, 2, 2])))

        @NLconstraint(sir, x[j, i, 3] == x[j-1, i, 3] + Δt * (x[j-1, i, 2] * gamma))
    end
end

## Set the objective to maximimze inequity as measured by the difference in total infections between two groups at the end of the run
@NLobjective(sir, Max, x[n, 2, 3]/x[n, 1, 3])

println("Solving...")
optimize!(sir)
solution_summary(sir)

function my_plot(y, ylabel)
    return Plots.plot(
        (1:n) * value.(Δt),
        value.(y)[:];
        xlabel="Time (s)",
        ylabel=ylabel
    )
end


#my_plot(x[:, 2, 2], "Group 2 infections")