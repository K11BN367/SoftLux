@generated function apply(::v__Cat_Parametric_Value_Sparse{Layer_Tuple, Dimension}, Input, Parameter, State) where {Layer_Tuple, Dimension}
    fields = keys(Layer_Tuple)
    Length = length(fields)
    Output_Symbol = [gensym() for _ in 1:(Length + 1)]
    State_Symbol = [gensym() for _ in 1:Length]
    getinput(Index) = Type <: Tuple ? :(Input[$Index]) : :Input
    calls = []
    append!(calls,
        [:(($(Output_Symbol[Index]), $(State_Symbol[Index])) = Lux.apply(
             Layer_Tuple.$(fields[Index]), $(getinput(Index)), Parameter.$(fields[Index]), State.$(fields[Index])))
         for Index in 1:Length])
    push!(calls, :(State = NamedTuple{$fields}((($(Tuple(State_Symbol)...),)))))
    push!(calls, :($(Output_Symbol[Length + 1]) = cat($(Tuple(Output_Symbol[1:Length])...), dims=$(Val(Dimension)))))
    push!(calls, :(return $(Output_Symbol[Length + 1]), State))
    return Expr(:block, calls...)
end