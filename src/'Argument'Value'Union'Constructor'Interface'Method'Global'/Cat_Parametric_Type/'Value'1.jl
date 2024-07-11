struct v__Cat_Parametric_Type{Name_Type, Layer_Tuple_Type, Dimension_Type, Input_Tuple_Type, Output_Tuple_Type} <: v
    Name::Name_Type
    Layer_Tuple::Layer_Tuple_Type
    Dimension::Dimension_Type
    Input_Tuple::Input_Tuple_Type
    Output_Tuple::Output_Tuple_Type
    function v__Cat_Parametric_Type(Name, Layer_Tuple, Dimension, Input_Tuple, Output_Tuple)
        Layer_Tuple = construct_layers(Layer_Tuple)
        return new{
            v__(Name),
            v__(Layer_Tuple),
            v__(Dimension),
            v__(Input_Tuple),
            v__(Output_Tuple)
        }(Name, Layer_Tuple, Dimension, Input_Tuple, Output_Tuple)
    end
end