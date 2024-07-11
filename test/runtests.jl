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
    Scale = 1 + rand()*0.2
    Kernel = a__Kernel(3, 3, Skip)
    Pad = a__Pad(1)
    Factor = 0
    Feature_Map = 6

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
            c__Upsample(a__Name(:Upsample_3), a__Mode(:bilinear), a__Scale(1/Scale, 1/Scale, Skip)),
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
    
    plso(show_layer(Chain))
    Chain = c__Chain(Chain.Layer_Tuple..., a__Reduce_Structure(true))

    Parameters, State = setup(SoftRandom.Default_Random, Chain) |> Device

    Optimizer = setup(c__Optimiser_Chain(c__Gradient_Accumulation(1), c__Descent(10^-9)), Parameters) |> Device

    return Chain, Parameters, State, Optimizer
end
function neuralnetwork_training(Device, Input_Model_Array_Size_Tuple, Chain, Parameters, State, Optimizer)
    Index = 1
    while true
        #@time ()->begin
            Input_Array = rand(Float32, (Input_Model_Array_Size_Tuple..., 1)) |> Device
            Output_Array = rand(Float32, (Input_Model_Array_Size_Tuple..., 1)) |> Device
            #println(size(Chain(Input_Array, Parameters, State)[1]))
            Loss, Pullback = let Input_Array = Input_Array, Output_Array = Output_Array, Chain = Chain, State = State, Parameters = Parameters
                Zygote.pullback(
                    function (Parameters)
                        return sum((Chain(Input_Array, Parameters, State)[1] - Output_Array) .^ 2)
                    end,
                    Parameters
                )
            end
            Gradients = only(Pullback(Loss))
            
            #=
            Gradients = let Input_Array = Input_Array, Output_Array = Output_Array, Chain = Chain, State = State, Parameters = Parameters
                Zygote.gradient((Parameters)->begin
                        return sum((Chain(Input_Array, Parameters, State)[1] - Output_Array) .^ 2)
            end, Parameters)[1] end
            =#

            Optimisers.update!(Optimizer, Parameters, Gradients)
        #end()
        if Index == 10
            break
        else
            Index += 1
        end
    end
end
function test()
    Input_Model_Array_Size_Tuple = (100, 100, 1)
    #model_array_size_type = Tuple{Input_Model_Array_Size_Tuple...}
    #Device = gpu_device()
    Device = Lux.cpu_device()
    #@time neuralnetwork_setup(Device, Input_Model_Array_Size_Tuple)
    #while true
    Chain, Parameters, State, Optimizer = neuralnetwork_setup(Device, Input_Model_Array_Size_Tuple)
    #@time neuralnetwork_setup(Device, Input_Model_Array_Size_Tuple)
    #@code_warntype neuralnetwork_setup(Device, Input_Model_Array_Size_Tuple)
    #@code_native(debuginfo=:none, binary=true, neuralnetwork_setup(Device, Input_Model_Array_Size_Tuple))
    
    @time neuralnetwork_training(Device, Input_Model_Array_Size_Tuple, Chain, Parameters, State, Optimizer)
    for _ in 1:2 @time neuralnetwork_training(Device, Input_Model_Array_Size_Tuple, Chain, Parameters, State, Optimizer) end

    #@code_warntype neuralnetwork_training(Device, Input_Model_Array_Size_Tuple, Chain, Parameters, State, Optimizer)
    #while true @time neuralnetwork_training(Device, Input_Model_Array_Size_Tuple, Chain, Parameters, State, Optimizer) end
    #end
    
    #@code_native(debuginfo=:none, binary=true, neuralnetwork_setup(Input_Model_Array_Size_Tuple))
    #@code_native(debuginfo=:none, binary=true, neuralnetwork_setup(Input_Model_Array_Size_Tuple))
    #@time neuralnetwork_setup(gpu_device(), Input_Model_Array_Size_Tuple)
    #@allocated neuralnetwork_setup(gpu_device(), Input_Model_Array_Size_Tuple)
    return
end
test()