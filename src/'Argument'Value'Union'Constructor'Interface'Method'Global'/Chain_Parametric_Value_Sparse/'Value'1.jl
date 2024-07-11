struct v__Chain_Parametric_Value_Sparse{Layer_Tuple} <: v
    function v__Chain_Parametric_Value_Sparse(Layer_Tuple)
        Layer_Tuple = construct_layers(Layer_Tuple)
        return new{Layer_Tuple}()
    end
end