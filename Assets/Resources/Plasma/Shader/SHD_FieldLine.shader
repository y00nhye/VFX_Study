// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "YH/FieldLine"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.BlendMode)]_SRC("SRC", Float) = 0
		[Enum(UnityEngine.Rendering.BlendMode)]_DST("DST", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		_Main_Texture("Main_Texture", 2D) = "white" {}
		_Main_VPanner("Main_VPanner", Float) = 0
		_Main_UPanner("Main_UPanner", Float) = 0
		_Main_Pow("Main_Pow", Range( 1 , 10)) = 1
		_Main_Ins("Main_Ins", Range( 1 , 10)) = 1
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,0)
		_Mask_Pow("Mask_Pow", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull [_CullMode]
		Blend [_SRC] [_DST]
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float _SRC;
		uniform float _CullMode;
		uniform float _DST;
		uniform sampler2D _Main_Texture;
		uniform float _Main_VPanner;
		uniform float _Main_UPanner;
		uniform float4 _Main_Texture_ST;
		uniform float _Main_Pow;
		uniform float _Main_Ins;
		uniform float4 _Main_Color;
		uniform float _Mask_Pow;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult39 = (float2(_Main_VPanner , _Main_UPanner));
			float2 uv_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 panner38 = ( 1.0 * _Time.y * appendResult39 + uv_Main_Texture);
			float4 temp_cast_0 = (_Main_Pow).xxxx;
			float temp_output_22_0 = saturate( i.uv_texcoord.y );
			float temp_output_34_0 = pow( ( ( temp_output_22_0 * ( 1.0 - temp_output_22_0 ) ) * 4.0 ) , _Mask_Pow );
			o.Emission = ( ( ( ( pow( tex2D( _Main_Texture, panner38 ) , temp_cast_0 ) * _Main_Ins ) * _Main_Color ) * temp_output_34_0 ) * i.vertexColor ).rgb;
			o.Alpha = ( i.vertexColor * temp_output_34_0 ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
2011;146;1348;753;2008.396;-286.8585;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;41;-1969.234,-34.87534;Inherit;False;Property;_Main_UPanner;Main_UPanner;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-1971.634,-115.2754;Inherit;False;Property;_Main_VPanner;Main_VPanner;5;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;39;-1773.234,-116.8751;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1898.855,-309.3241;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-1753.602,322.7154;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;22;-1537.946,361.5991;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;38;-1634.035,-292.8754;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;30;-1394.967,568.403;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1398.651,-328.0164;Inherit;True;Property;_Main_Texture;Main_Texture;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;6;-1316.045,-75.64552;Inherit;False;Property;_Main_Pow;Main_Pow;7;0;Create;True;0;0;0;False;0;False;1;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;3;-961.4515,-301.0163;Inherit;True;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1039.045,-63.64552;Inherit;False;Property;_Main_Ins;Main_Ins;8;0;Create;True;0;0;0;False;0;False;1;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-1111.567,650.3035;Inherit;False;Constant;_Float3;Float 3;10;0;Create;True;0;0;0;False;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-1203.867,357.8034;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;8;-743.3367,-57.59697;Inherit;False;Property;_Main_Color;Main_Color;9;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;35;-925.6674,649.0037;Inherit;False;Property;_Mask_Pow;Mask_Pow;10;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-714.0453,-302.6455;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-952.9667,361.7036;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;34;-751.4671,374.7036;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-485.2452,-267.2454;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-234.1284,-134.1701;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;9;-462.6106,122.0995;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;23;229.2046,9.148929;Inherit;False;174;279;Enum;3;26;25;24;;1,0,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;24;252.2046,201.1489;Inherit;False;Property;_CullMode;CullMode;3;1;[Enum];Create;False;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-240.4288,462.9297;Inherit;False;Constant;_Float0;Float 0;10;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;254.2046,124.1489;Inherit;False;Property;_DST;DST;2;1;[Enum];Create;False;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-190.2436,197.6298;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-196.2895,4.065768;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;26;252.2046,51.14892;Inherit;False;Property;_SRC;SRC;0;1;[Enum];Create;False;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;YH/FieldLine;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;True;26;10;True;25;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;1;-1;-1;-1;0;False;0;0;True;24;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;39;0;40;0
WireConnection;39;1;41;0
WireConnection;22;0;12;2
WireConnection;38;0;2;0
WireConnection;38;2;39;0
WireConnection;30;0;22;0
WireConnection;1;1;38;0
WireConnection;3;0;1;0
WireConnection;3;1;6;0
WireConnection;31;0;22;0
WireConnection;31;1;30;0
WireConnection;4;0;3;0
WireConnection;4;1;7;0
WireConnection;32;0;31;0
WireConnection;32;1;33;0
WireConnection;34;0;32;0
WireConnection;34;1;35;0
WireConnection;5;0;4;0
WireConnection;5;1;8;0
WireConnection;27;0;5;0
WireConnection;27;1;34;0
WireConnection;11;0;9;0
WireConnection;11;1;34;0
WireConnection;10;0;27;0
WireConnection;10;1;9;0
WireConnection;0;2;10;0
WireConnection;0;9;11;0
ASEEND*/
//CHKSM=382A0CDC5108CAAE6301AE462E37115F88C13D97