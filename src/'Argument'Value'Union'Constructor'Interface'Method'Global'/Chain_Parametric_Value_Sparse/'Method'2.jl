@generated function apply(::v__Chain_Parametric_Value_Sparse{Layer_Tuple}, Input, Parameter, State) where {Layer_Tuple}
    fields = keys(Layer_Tuple)
    Length = length(fields)
    Input_Symbol = vcat([:Input], [gensym() for _ in 1:Length])
    State_Symbol = [gensym() for _ in 1:Length]
    calls = [:(($(Input_Symbol[i + 1]), $(State_Symbol[i])) = Lux.apply(
                 Layer_Tuple.$(fields[i]), $(Input_Symbol[i]), Parameter.$(fields[i]), State.$(fields[i])))
             for i in 1:Length]
    push!(calls, :(State = NamedTuple{$fields}((($(Tuple(State_Symbol)...),)))))
    push!(calls, :(return $(Input_Symbol[Length + 1]), State))
    return Expr(:block, calls...)
end
