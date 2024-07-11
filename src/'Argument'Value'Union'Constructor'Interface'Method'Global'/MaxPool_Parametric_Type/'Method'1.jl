function apply(Layer::v__MaxPool_Parametric_Type, Input, Parameter, State)
    ##println("apply MaxPool")
    ##println(size(Input))
    return apply(Layer.MaxPool_Wrapper, Input, Parameter, State)
end
