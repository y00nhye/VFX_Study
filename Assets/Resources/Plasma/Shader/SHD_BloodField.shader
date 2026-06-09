// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "YH/BloodField"
{
	Properties
	{
		_Main_Texture("Main_Texture", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (1,1,1,0)
		_Main_Pow("Main_Pow", Float) = 1
		_Main_Ins("Main_Ins", Float) = 1
		_Main_UPanner("Main_UPanner", Float) = 0
		_Main_VPanner("Main_VPanner", Float) = 0
		_Hole_Range("Hole_Range", Float) = 4
		_Noise_Texture("Noise_Texture", 2D) = "bump" {}
		_Noise_Str("Noise_Str", Float) = 0
		_Noise_UPanner("Noise_UPanner", Float) = 0
		_Noise_VPanner("Noise_VPanner", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform sampler2D _Main_Texture;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Str;
		uniform float4 _Main_Texture_ST;
		uniform float _Main_Pow;
		uniform float _Main_Ins;
		uniform float4 _Main_Color;
		uniform float _Hole_Range;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult19 = (float2(_Main_UPanner , _Main_VPanner));
			float2 appendResult26 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner25 = ( 1.0 * _Time.y * appendResult26 + uv_Noise_Texture);
			float2 uv_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 panner18 = ( 1.0 * _Time.y * appendResult19 + ( ( (UnpackNormal( tex2D( _Noise_Texture, panner25 ) )).xy * _Noise_Str ) + uv_Main_Texture ));
			float4 temp_cast_0 = (_Main_Pow).xxxx;
			o.Emission = ( i.vertexColor * ( ( ( pow( tex2D( _Main_Texture, panner18 ) , temp_cast_0 ) * _Main_Ins ) * _Main_Color ) * pow( saturate( ( 1.0 - i.uv_texcoord.y ) ) , _Hole_Range ) ) ).rgb;
			o.Alpha = i.vertexColor.a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
2024;93;1348;897;1935.764;513.6747;1.519781;True;False
Node;AmplifyShaderEditor.CommentaryNode;33;-3590.459,-274.0273;Inherit;False;1367.912;431.6599;Noise;9;26;25;24;30;28;27;32;31;29;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-3535.751,-74.92355;Inherit;False;Property;_Noise_UPanner;Noise_UPanner;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-3540.459,36.51188;Inherit;False;Property;_Noise_VPanner;Noise_VPanner;11;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;24;-3424.317,-224.0274;Inherit;False;0;29;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;26;-3341.131,-30.97718;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;25;-3168.485,-170.6639;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;29;-2975.438,-197.3458;Inherit;True;Property;_Noise_Texture;Noise_Texture;8;0;Create;True;0;0;0;False;0;False;-1;82d7a1f26ef85f048b76b9dcc08c906b;82d7a1f26ef85f048b76b9dcc08c906b;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;32;-2655.224,40.22049;Inherit;False;Property;_Noise_Str;Noise_Str;9;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;30;-2686.276,-188.1262;Inherit;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-2381.315,208.5375;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;21;-2294.612,450.6523;Inherit;False;Property;_Main_VPanner;Main_VPanner;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-2426.332,-146.8488;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-2296.781,377.1763;Inherit;False;Property;_Main_UPanner;Main_UPanner;5;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;19;-2025.779,395.8763;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;23;-2113.016,71.72822;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;18;-1892.304,231.7991;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;8;-1368.633,778.287;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1659.088,201.3154;Inherit;True;Property;_Main_Texture;Main_Texture;1;0;Create;True;0;0;0;False;0;False;-1;145143eb93006454baed654b5669d0c3;145143eb93006454baed654b5669d0c3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-1483.04,458.7563;Inherit;False;Property;_Main_Pow;Main_Pow;3;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;9;-1127.973,820.1412;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1144.404,484.5965;Inherit;False;Property;_Main_Ins;Main_Ins;4;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2;-1300.391,203.9366;Inherit;True;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-1018.396,210.5043;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;11;-958.8134,827.1164;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;6;-950.6577,509.2332;Inherit;False;Property;_Main_Color;Main_Color;2;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;13;-968.8447,1058.039;Inherit;False;Property;_Hole_Range;Hole_Range;7;0;Create;True;0;0;0;False;0;False;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;12;-766.9835,823.629;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-737.8359,230.6862;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-432.1869,474.0948;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;15;-451.21,49.05033;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-189.9814,52.93908;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;YH/BloodField;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;26;0;28;0
WireConnection;26;1;27;0
WireConnection;25;0;24;0
WireConnection;25;2;26;0
WireConnection;29;1;25;0
WireConnection;30;0;29;0
WireConnection;31;0;30;0
WireConnection;31;1;32;0
WireConnection;19;0;20;0
WireConnection;19;1;21;0
WireConnection;23;0;31;0
WireConnection;23;1;22;0
WireConnection;18;0;23;0
WireConnection;18;2;19;0
WireConnection;1;1;18;0
WireConnection;9;0;8;2
WireConnection;2;0;1;0
WireConnection;2;1;4;0
WireConnection;3;0;2;0
WireConnection;3;1;5;0
WireConnection;11;0;9;0
WireConnection;12;0;11;0
WireConnection;12;1;13;0
WireConnection;7;0;3;0
WireConnection;7;1;6;0
WireConnection;14;0;7;0
WireConnection;14;1;12;0
WireConnection;16;0;15;0
WireConnection;16;1;14;0
WireConnection;0;2;16;0
WireConnection;0;9;15;4
ASEEND*/
//CHKSM=CAF807E14E8C787EB5287A07E8DAC529B6222251