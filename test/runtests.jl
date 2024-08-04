#using SoftLux
using SoftBase
import SoftBase.:(+)
import SoftBase.:(-)
import SoftBase.:(*)
import SoftBase.:(/)
import SoftBase.:(^)
import SoftBase.:(==)
import SoftBase.:(!=)
import SoftBase.:(>)
import SoftBase.:(<)
import SoftBase.:(>=)
import SoftBase.:(<=)
using SoftLux
using SoftRandom
using SoftOptimisers

import Lux
import Optimisers
import Zygote

const Skip = SoftLux.Skip
const Infer = SoftLux.Infer
function neuralnetwork_setup(Device, Model_Array_Size_Tuple)
    #Scale = 1 + rand()*0.2
    Scale = 1.5
    Kernel = a__Kernel(3, 3, Skip)
    Pad = a__Pad(1)
    Factor = 3
    Feature_Map = 6

    #=
    function first_feature_map(Factor)::v__Int64
        return 12 + Feature_Map * Factor
    end
    function second_feature_map(Factor)::v__Int64
        return 18 + Feature_Map * Factor
    end
    function third_feature_map(Factor)::v__Int64
        return second_feature_map(Factor) / 2
    end
    Cat = c__Cat(
        c__Chain(
            c__MaxPool(a__Name(:Downsample_3), a__Window(2, 2, Skip), a__Stride(1, 1)),
            c__Upsample(a__Name(:Upsample_3), a__Mode(:bilinear), a__Scale(1 / Scale, 1 / Scale, Skip)),
            c__Convolution(Kernel, a__Output(Infer, Infer, first_feature_map(Factor)), a__Activation_Function(relu), Pad),
            c__Convolution(Kernel, a__Output(Infer, Infer, first_feature_map(Factor)), a__Activation_Function(relu), Pad),
            c__Upsample(a__Name(:Upsample_3), a__Mode(:bilinear), a__Scale(Infer, Infer, Skip)),
        ),
        c__Nop(a__Name(:Skip_3)),
        a__Dimension(3)
    )
    for Factor = Factor:-1:1
        Cat = c__Cat(
            c__Chain(
                c__MaxPool(a__Name(:Downsample_2), a__Window(2, 2, Skip), a__Stride(1, 1)),
                c__Upsample(a__Name(:Upsample_2), a__Mode(:bilinear), a__Scale(1 / Scale, 1 / Scale, Skip)),
                c__Convolution(Kernel, a__Output(Infer, Infer, first_feature_map(Factor)), a__Activation_Function(relu), Pad),
                c__Convolution(Kernel, a__Output(Infer, Infer, first_feature_map(Factor)), a__Activation_Function(relu), Pad),
                Cat,
                c__Convolution(Kernel, a__Output(Infer, Infer, second_feature_map(Factor)), a__Activation_Function(relu), Pad),
                c__Convolution(Kernel, a__Output(Infer, Infer, third_feature_map(Factor)), a__Activation_Function(relu), Pad),
                c__Upsample(a__Name(:Upsample_2), a__Mode(:bilinear), a__Scale(Infer, Infer, Skip)),
            ),
            c__Nop(a__Name(:Skip_2)),
            a__Dimension(3)
        )
    end
    Chain = c__Chain(
        c__Convolution(Kernel, a__Input(Model_Array_Size_Tuple...), a__Output(Infer, Infer, first_feature_map(0)), a__Activation_Function(relu), Pad),
        c__Convolution(Kernel, a__Output(Infer, Infer, first_feature_map(0)), a__Activation_Function(relu), Pad),
        Cat,
        c__Convolution(Kernel, a__Output(Infer, Infer, second_feature_map(0)), a__Activation_Function(relu), Pad),
        c__Convolution(Kernel, a__Output(Infer, Infer, third_feature_map(0)), a__Activation_Function(relu), Pad),
        c__Convolution(Kernel, a__Output(Model_Array_Size_Tuple...), a__Activation_Function(sigmoid), Pad),
        a__Reduce_Structure(false),
    )
    
    #plso(show_layer(Chain))
    Chain = c__Chain(Chain.Layer_Tuple..., a__Reduce_Structure(true))
    =#

    #plso("neuralnetwork_definition")
    #=
    Kernel = a__Kernel(3, 3, Skip)
    Pad = a__Pad(1)
    return c__Chain(
        a__Reduce_Structure(true),
        c__Convolution(Kernel, a__Input(input_model_array_size_tuple...), a__Output(Infer, Infer, 12), a__Activation_Function(relu), Pad),
        c__Convolution(Kernel, a__Output(Infer, Infer, 12), a__Activation_Function(relu), Pad),
        c__Cat(
            c__Chain(
                c__MaxPool(a__Name(:Downsample_1), a__Window(2, 2, Skip), a__Stride(1, 1)),
                c__Upsample(a__Name(:Upsample_1), a__Mode(:bilinear), a__Scale(0.5, 0.5, Skip)),
                c__Convolution(Kernel, a__Output(Infer, Infer, 18), a__Activation_Function(relu), Pad),
                c__Convolution(Kernel, a__Output(Infer, Infer, 18), a__Activation_Function(relu), Pad),
                c__Cat(
                    c__Chain(
                        c__MaxPool(a__Name(:Downsample_2), a__Window(2, 2, Skip), a__Stride(1, 1)),
                        c__Upsample(a__Name(:Upsample_2), a__Mode(:bilinear), a__Scale(0.5, 0.5, Skip)),
                        c__Convolution(Kernel, a__Output(Infer, Infer, 24), a__Activation_Function(relu), Pad),
                        c__Convolution(Kernel, a__Output(Infer, Infer, 24), a__Activation_Function(relu), Pad),
                        c__Cat(
                            c__Chain(
                                c__MaxPool(a__Name(:Downsample_3), a__Window(2, 2, Skip), a__Stride(1, 1)),
                                c__Upsample(a__Name(:Upsample_3), a__Mode(:bilinear), a__Scale(0.5, 0.5, Skip)),
                                c__Convolution(Kernel, a__Output(Infer, Infer, 24), a__Activation_Function(relu), Pad),
                                c__Convolution(Kernel, a__Output(Infer, Infer, 24), a__Activation_Function(relu), Pad),
                                c__Upsample(a__Name(:Upsample_3), a__Mode(:bilinear), a__Scale(2, 2, Skip)),
                            ),
                            c__Upsample(a__Name(:Skip_3), a__Mode(:bilinear), a__Scale(Infer, Infer, Skip)),
                            a__Dimension(3)
                        ),
                        c__Convolution(Kernel, a__Output(Infer, Infer, 36), a__Activation_Function(relu), Pad),
                        c__Convolution(Kernel, a__Output(Infer, Infer, 18), a__Activation_Function(relu), Pad),
                        c__Upsample(a__Name(:Upsample_2), a__Mode(:bilinear), a__Scale(2, 2, Skip)),
                    ),
                    c__Upsample(a__Name(:Skip_2), a__Mode(:bilinear), a__Scale(Infer, Infer, Skip)),
                    a__Dimension(3)
                ),
                c__Convolution(Kernel, a__Output(Infer, Infer, 24), a__Activation_Function(relu), Pad),
                c__Convolution(Kernel, a__Output(Infer, Infer, 12), a__Activation_Function(relu), Pad),
                c__Upsample(a__Name(:Upsample_1), a__Mode(:bilinear), a__Scale(2, 2, Skip)),
            ),
            c__Upsample(a__Name(:Skip_1), a__Mode(:bilinear), a__Scale(Infer, Infer, Skip)),
            a__Dimension(3)
        ),
        c__Convolution(Kernel, a__Output(Infer, Infer, 18), a__Activation_Function(relu), Pad),
        c__Convolution(Kernel, a__Output(Infer, Infer, 9), a__Activation_Function(relu), Pad),
        c__Convolution(Kernel, a__Output(output_model_array_size_tuple...), a__Activation_Function(sigmoid), Pad)
    )
    =#
    #=
    Kernel = a__Kernel(5, 5, Skip)
    Pad = a__Pad(2)
    return c__Chain(
        a__Reduce_Structure(true),
        c__Convolution(Kernel, a__Input(input_model_array_size_tuple...), a__Output(Infer, Infer, 12), a__Activation_Function(relu), Pad),
        c__Convolution(Kernel, a__Output(Infer, Infer, 12), a__Activation_Function(relu), Pad),
        c__Cat(
            c__Chain(
                c__MaxPool(a__Name(:Downsample_1), a__Window(2, 2, Skip)),
                c__Convolution(Kernel, a__Output(Infer, Infer, 18), a__Activation_Function(relu), Pad),
                c__Convolution(Kernel, a__Output(Infer, Infer, 18), a__Activation_Function(relu), Pad),
                c__Cat(
                    c__Chain(
                        c__MaxPool(a__Name(:Downsample_2), a__Window(2, 2, Skip)),
                        c__Convolution(Kernel, a__Output(Infer, Infer, 24), a__Activation_Function(relu), Pad),
                        c__Convolution(Kernel, a__Output(Infer, Infer, 24), a__Activation_Function(relu), Pad),
                        c__Cat(
                            c__Chain(
                                c__MaxPool(a__Name(:Downsample_3), a__Window(2, 2, Skip)),
                                c__Convolution(Kernel, a__Output(Infer, Infer, 24), a__Activation_Function(relu), Pad),
                                c__Convolution(Kernel, a__Output(Infer, Infer, 24), a__Activation_Function(relu), Pad),
                                c__Upsample(a__Name(:Upsample_3), a__Mode(:bilinear), a__Scale(2, 2, Skip)),
                            ),
                            c__Upsample(a__Name(:Skip_3), a__Mode(:bilinear), a__Scale(Infer, Infer, Skip)),
                            a__Dimension(3)
                        ),
                        c__Convolution(Kernel, a__Output(Infer, Infer, 36), a__Activation_Function(relu), Pad),
                        c__Convolution(Kernel, a__Output(Infer, Infer, 18), a__Activation_Function(relu), Pad),
                        c__Upsample(a__Name(:Upsample_2), a__Mode(:bilinear), a__Scale(2, 2, Skip)),
                    ),
                    c__Upsample(a__Name(:Skip_2), a__Mode(:bilinear), a__Scale(Infer, Infer, Skip)),
                    a__Dimension(3)
                ),
                c__Convolution(Kernel, a__Output(Infer, Infer, 24), a__Activation_Function(relu), Pad),
                c__Convolution(Kernel, a__Output(Infer, Infer, 12), a__Activation_Function(relu), Pad),
                c__Upsample(a__Name(:Upsample_1), a__Mode(:bilinear), a__Scale(2, 2, Skip)),
            ),
            c__Upsample(a__Name(:Skip_1), a__Mode(:bilinear), a__Scale(Infer, Infer, Skip)),
            a__Dimension(3)
        ),
        c__Convolution(Kernel, a__Output(Infer, Infer, 18), a__Activation_Function(relu), Pad),
        c__Convolution(Kernel, a__Output(Infer, Infer, 9), a__Activation_Function(relu), Pad),
        c__Convolution(Kernel, a__Output(output_model_array_size_tuple...), a__Activation_Function(sigmoid), Pad)
    )
    =#
    #Scale = 1 + rand()

    #Pad = a__Pad(v__Int64((Kernel - 1) / 2))
    #plso(Pad)
    #Kernel = a__Kernel(Kernel, Kernel, Skip)
    #plso(Kernel)
    
    #Factor = 4
    Feature_Map = 6
    function first_feature_map(Factor)::Int
        return 12 + Feature_Map * Factor
    end
    function second_feature_map(Factor)::Int
        return 18 + Feature_Map * Factor
    end
    function third_feature_map(Factor)::Int
        return second_feature_map(Factor) / 2
    end
    #plso("feature_map")
    Cat = c__Cat(
        c__Chain(
            c__MaxPool(a__Name(:Downsample_3), a__Window(2, 2, Skip), a__Stride(1, 1)),
            c__Upsample(a__Name(:Upsample_3), a__Mode(:bilinear), a__Scale(1 / Scale, 1 / Scale, Skip)),
            c__Convolution(Kernel, a__Output(Infer, Infer, first_feature_map(Factor)), a__Activation_Function(relu), Pad),
            c__Convolution(Kernel, a__Output(Infer, Infer, first_feature_map(Factor)), a__Activation_Function(relu), Pad),
            c__Upsample(a__Name(:Upsample_3), a__Mode(:bilinear), a__Scale(Infer, Infer, Skip)),
        ),
        c__Nop(a__Name(:Skip_3)),
        a__Dimension(3)
    )
    for Factor = Factor:-1:1
        Cat = c__Cat(
            c__Chain(
                c__MaxPool(a__Name(:Downsample_2), a__Window(2, 2, Skip), a__Stride(1, 1)),
                c__Upsample(a__Name(:Upsample_2), a__Mode(:bilinear), a__Scale(1 / Scale, 1 / Scale, Skip)),
                c__Convolution(Kernel, a__Output(Infer, Infer, first_feature_map(Factor)), a__Activation_Function(relu), Pad),
                c__Convolution(Kernel, a__Output(Infer, Infer, first_feature_map(Factor)), a__Activation_Function(relu), Pad),
                Cat,
                c__Convolution(Kernel, a__Output(Infer, Infer, second_feature_map(Factor)), a__Activation_Function(relu), Pad),
                c__Convolution(Kernel, a__Output(Infer, Infer, third_feature_map(Factor)), a__Activation_Function(relu), Pad),
                c__Upsample(a__Name(:Upsample_2), a__Mode(:bilinear), a__Scale(Infer, Infer, Skip)),
            ),
            c__Nop(a__Name(:Skip_2)),
            a__Dimension(3)
        )
    end
    Chain =  c__Chain(
        a__Reduce_Structure(false),
        c__Convolution(Kernel, a__Input(Model_Array_Size_Tuple...), a__Output(Infer, Infer, first_feature_map(0)), a__Activation_Function(relu), Pad),
        c__Convolution(Kernel, a__Output(Infer, Infer, first_feature_map(0)), a__Activation_Function(relu), Pad),
        Cat,
        c__Convolution(Kernel, a__Output(Infer, Infer, second_feature_map(0)), a__Activation_Function(relu), Pad),
        c__Convolution(Kernel, a__Output(Infer, Infer, third_feature_map(0)), a__Activation_Function(relu), Pad),
        c__Convolution(Kernel, a__Output(Model_Array_Size_Tuple...), a__Activation_Function(sigmoid), Pad)
    )
    println(show_layer(Chain))
    Chain = c__Chain(Chain.Layer_Tuple..., a__Reduce_Structure(true))
    #plso(Chain)
    Parameters, State = setup(SoftRandom.Default_Random, Chain) |> Device

    Optimizer = setup(c__Optimiser_Chain(c__Gradient_Accumulation(1), c__Descent(10^-9)), Parameters) |> Device

    return Chain, Parameters, State, Optimizer
end
function neuralnetwork_training(Index_Stop, Device, Input_Model_Array_Size_Tuple, Chain, Parameters, State, Optimizer)
    Index = 1
    while true

        Input_Array = rand(Float32, (Input_Model_Array_Size_Tuple..., 1)) |> Device;
        Output_Array = rand(Float32, (Input_Model_Array_Size_Tuple..., 1)) |> Device;

        Loss, Pullback = let Input_Array = Input_Array, Output_Array = Output_Array, Chain = Chain, State = State, Parameters = Parameters
            pullback(
                (Parameters)->(sum((Chain(Input_Array, Parameters, State)[1] - Output_Array) .^ 2)),
                Parameters
            )
        end
        Gradients = only(Pullback(Loss))

        update!(Optimizer, Parameters, Gradients)

        if Index == Index_Stop
            break
        else
            Index += 1
        end
    end
end
function test()
    Input_Model_Array_Size_Tuple = (256, 256, 1)

    Device = gpu_device()

    Chain, Parameters, State, Optimizer = neuralnetwork_setup(Device, Input_Model_Array_Size_Tuple)

    @time neuralnetwork_training(1, Device, Input_Model_Array_Size_Tuple, Chain, Parameters, State, Optimizer)
    #@code_warntype neuralnetwork_training(1, Device, Input_Model_Array_Size_Tuple, Chain, Parameters, State, Optimizer)
    for _ in 1:5 @time neuralnetwork_training(100, Device, Input_Model_Array_Size_Tuple, Chain, Parameters, State, Optimizer) end

    return
end
test()