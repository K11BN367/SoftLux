@generated function apply(::v__MaxPool_Parametric_Wrapper{MaxPool_Wrapper}, Input, Parameter, State) where {MaxPool_Wrapper}
    ##println("apply MaxPool")
    ##println(size(Input))
    return :(apply($(MaxPool_Wrapper), Input, Parameter, State))
end