#=
test:
- Julia version: 1.8.3
- Author: stefa
- Date: 2022-12-14
=#

A = [1 2 3; 4 5 6; 7 8 9]
println(A)
A[1,2] = 5
println(A[1,2])

if A[1,2] == 5
    println("This true")
else
    println("This is false")
end

println(transpose(A))

import Pkg;
Pkg.add("DataFrames")
Pkg.add("CSV")
Pkg.add("Plots")
using DataFrames
using CSV

#a = DataFraCSV.File("trees.csv");
df = CSV.read("D:\\FH_Hagenberg\\Bachelor\\OneDrive - FH OOe\\Semester_05\\ALP\\workspace\\hagenberg-alp-2022\\ALP-Ex05-Julia-S2020237051\\src\\trees.csv", DataFrame)


Pkg.add("RDatasets")
Pkg.add("StatsPlots")
Pkg.add("PyPlot")
using Plots
using RDatasets, StatsPlots

@df df boxplot(:"Height (ft)")

#@df df plot(cols())
#plot(Matrix(df), labels=permutedims(names(df)), legend=:topleft)
#describe(df, :all, cols = 4)