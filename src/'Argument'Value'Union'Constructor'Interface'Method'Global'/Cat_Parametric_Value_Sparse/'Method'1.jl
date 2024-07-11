@__function(SoftBase.get_property, (::v__Cat_Parametric_Value_Sparse{Layer_Tuple, Dimension}, Property::v__Symbol), {Layer_Tuple, Dimension}, (
    if Property == c__Symbol("Layer_Tuple");
        return Layer_Tuple;
    elseif Property == c__Symbol("Dimension");
        return Dimension;
    end;
));
