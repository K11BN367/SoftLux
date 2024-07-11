@generated function apply_cat(Layer_Tuple::NamedTuple{fields}, Dimension, Input::Type, Parameter, State::NamedTuple) where {Type, fields}

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
    push!(calls, :($(Output_Symbol[Length + 1]) = cat($(Tuple(Output_Symbol[1:Length])...), dims=Val(Dimension))))
    push!(calls, :(return $(Output_Symbol[Length + 1]), State))
    return Expr(:block, calls...)
end
function apply(Layer::v__Cat_Parametric_Type, Input, Parameter, State)
    return apply_cat(Layer.Layer_Tuple, Layer.Dimension, Input, Parameter, State)
end