@__function(
    SoftBase.get_property,
    (
        ::v__Chain_Parametric_Value_Sparse{Layer_Tuple},
        Property::v__Symbol
    ),
    {Layer_Tuple},
    (
    if Property == c__Symbol("Layer_Tuple")
        return Layer_Tuple
    end
    )
)