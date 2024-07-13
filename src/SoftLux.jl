
module SoftLux
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
    using SoftRandom
    using SoftOptimisers

    import Base
    import NNlib
    import Optimisers
    import Lux
    import LuxCUDA
    import Zygote

	import InteractiveUtils.@code_warntype
	import InteractiveUtils.@code_native
	import InteractiveUtils.@which
	import InteractiveUtils.@less

    #'Argument'Dependency'Function'Trait'1
    include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("'Argument'Value'Union'Constructor'Interface'Method'Global'/'Argument'1.jl")))
    include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("'Global'Function'Trait'Method'Proxy'/'Function'Trait'1.jl")))
    #'Value'1
    include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("'Argument'Value'Union'Constructor'Interface'Method'Global'/'Value'1.jl")))
    #'Union'1
    include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("'Argument'Value'Union'Constructor'Interface'Method'Global'/'Union'1.jl")))
    #'Constructor'Interface'Macro'Method'Proxy'1
    #'Global'1
    include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("'Global'Function'Trait'Method'Proxy'/'Global'1.jl")))
    include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("'Argument'Value'Union'Constructor'Interface'Method'Global'/'Global'1.jl")))

    #'Argument'Dependency'Function'Trait'2
    #'Value'2
    #'Union'2
    #'Constructor'Interface'Macro'Method'Proxy'2
    include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("'Global'Function'Trait'Method'Proxy'/'Method'Proxy'1.jl")))
    include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("'Argument'Value'Union'Constructor'Interface'Method'Global'/'Contstructor'Inferface'Method'1.jl")))
    #'Global'2

    #'Argument'Dependency'Function'Trait'3
    #'Value'3
    #'Union'3
    #'Constructor'Interface'Macro'Method'Proxy'3
    include!(SoftLux, @c__URI(SoftBase.Directory, a__Path("'Argument'Value'Union'Constructor'Interface'Method'Global'/'Method'2.jl")))
    #'Global'3
end