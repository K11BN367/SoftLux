struct v__Chain_Parametric_Value{Name, Layer_Tuple, Input_Tuple, Output_Tuple} <: v
    function v__Chain_Parametric_Value(Name, Layer_Tuple, Input_Tuple, Output_Tuple)
        Layer_Tuple = construct_layers(Layer_Tuple)
        return new{Name, Layer_Tuple, Input_Tuple, Output_Tuple}()
    end
end