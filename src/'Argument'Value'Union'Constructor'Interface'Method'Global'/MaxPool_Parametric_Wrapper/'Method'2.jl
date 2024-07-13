@generated function apply(::v__MaxPool_Parametric_Wrapper{MaxPool_Wrapper}, Input, Parameter, State) where {MaxPool_Wrapper}
    return :(apply($(MaxPool_Wrapper), Input, Parameter, State))
end