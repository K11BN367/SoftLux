
struct v__Cat_Parametric_Value_Sparse{Layer_Tuple, Dimension} <: v
    function v__Cat_Parametric_Value_Sparse(Layer_Tuple, Dimension)
        Layer_Tuple = construct_layers(Layer_Tuple)
        return new{Layer_Tuple, Dimension}()
    end
end