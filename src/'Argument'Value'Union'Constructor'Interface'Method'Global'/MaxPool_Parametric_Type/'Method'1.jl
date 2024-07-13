function apply(Layer::v__MaxPool_Parametric_Type, Input, Parameter, State)
    return apply(Layer.MaxPool_Wrapper, Input, Parameter, State)
end
