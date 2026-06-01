// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "YH/ParticleMaster"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.BlendMode)]_SRC("SRC", Float) = 0
		[Enum(UnityEngine.Rendering.BlendMode)]_DST("DST", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		_Opacity("Opacity", Float) = 0
		_Main_Texture("Main_Texture", 2D) = "white" {}
		_Main_UOffset("Main_UOffset", Float) = 0
		_Main_VOffset("Main_VOffset", Float) = 0
		_Main_UPanner("Main_UPanner", Float) = 0
		_Main_VPanner("Main_VPanner", Float) = 0
		[HDR]_Main_Color("Main_Color", Color) = (0,0,0,0)
		_Main_Ins("Main_Ins", Range( 1 , 20)) = 20.04
		_Main_Pow("Main_Pow", Range( 1 , 10)) = 6.04
		_Noise_Texture("Noise_Texture", 2D) = "bump" {}
		_Noise_Str("Noise_Str", Range( 0 , 5)) = 0.7
		_Noise_Upanner("Noise_Upanner", Float) = 0
		_Noise_VPanner("Noise_VPanner", Float) = 0
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		_Dissolve("Dissolve", Range( -1.2 , 1.2)) = 1
		_Diss_UPanner("Diss_UPanner", Float) = 0
		_Diss_VPanner("Diss_VPanner", Float) = 0
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		_Mask_Texture("Mask_Texture", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull [_CullMode]
		ZWrite Off
		Blend [_SRC] [_DST]
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _USE_CUSTOM_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float4 uv2_tex4coord2;
		};

		uniform float _DST;
		uniform float _CullMode;
		uniform float _SRC;
		uniform sampler2D _Main_Texture;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_Upanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_Str;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform float4 _Main_Texture_ST;
		uniform float _Main_UOffset;
		uniform float _Main_VOffset;
		uniform float _Main_Pow;
		uniform float _Main_Ins;
		uniform float4 _Main_Color;
		uniform float _Opacity;
		uniform sampler2D _Dissolve_Texture;
		uniform float _Diss_UPanner;
		uniform float _Diss_VPanner;
		uniform float4 _Dissolve_Texture_ST;
		uniform float _Dissolve;
		uniform sampler2D _Mask_Texture;
		uniform float4 _Mask_Texture_ST;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult53 = (float2(_Noise_Upanner , _Noise_VPanner));
			float2 uv_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 panner50 = ( 1.0 * _Time.y * appendResult53 + uv_Noise_Texture);
			float2 appendResult91 = (float2(_Main_UPanner , _Main_VPanner));
			float2 uv_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 panner90 = ( 1.0 * _Time.y * appendResult91 + uv_Main_Texture);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch80 = i.uv2_tex4coord2.x;
			#else
				float staticSwitch80 = _Main_VOffset;
			#endif
			float2 appendResult78 = (float2(_Main_UOffset , staticSwitch80));
			float4 tex2DNode3 = tex2D( _Main_Texture, ( ( (UnpackNormal( tex2D( _Noise_Texture, panner50 ) )).xy * _Noise_Str ) + (panner90*1.0 + appendResult78) ) );
			float4 temp_cast_0 = (_Main_Pow).xxxx;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch82 = i.uv2_tex4coord2.z;
			#else
				float staticSwitch82 = _Main_Ins;
			#endif
			o.Emission = ( i.vertexColor * ( ( pow( tex2DNode3 , temp_cast_0 ) * staticSwitch82 ) * _Main_Color ) ).rgb;
			float2 appendResult38 = (float2(_Diss_UPanner , _Diss_VPanner));
			float2 uv_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			float2 panner35 = ( 1.0 * _Time.y * appendResult38 + uv_Dissolve_Texture);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch81 = i.uv2_tex4coord2.y;
			#else
				float staticSwitch81 = _Dissolve;
			#endif
			float2 uv_Mask_Texture = i.uv_texcoord * _Mask_Texture_ST.xy + _Mask_Texture_ST.zw;
			o.Alpha = ( i.vertexColor.a * ( saturate( ( ( tex2DNode3.r * _Opacity ) * saturate( ( tex2D( _Dissolve_Texture, panner35 ).r + staticSwitch81 ) ) ) ) * tex2D( _Mask_Texture, uv_Mask_Texture ).r ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
2389;7;1450;1019;1578.471;224.8641;1.451465;True;False
Node;AmplifyShaderEditor.CommentaryNode;54;-2861.977,-277.3047;Inherit;False;1498.001;518.5465;Comment;12;46;47;41;40;50;53;52;51;49;48;27;90;;0.3726415,0.4157495,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-2811.977,-72.6743;Inherit;False;Property;_Noise_Upanner;Noise_Upanner;21;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;52;-2805.977,10.32562;Inherit;False;Property;_Noise_VPanner;Noise_VPanner;22;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;49;-2744.977,-227.3044;Inherit;False;0;40;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;53;-2639.977,-74.6743;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;77;-2432.345,444.0152;Inherit;False;Property;_Main_VOffset;Main_VOffset;7;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;79;-2737.421,479.4821;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;93;-2505.273,299.9232;Inherit;False;Property;_Main_VPanner;Main_VPanner;9;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;92;-2520.273,207.9232;Inherit;False;Property;_Main_UPanner;Main_UPanner;8;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;39;-1733.227,372.3475;Inherit;False;1316.659;405;Dissolve;9;31;29;30;19;35;34;36;37;38;;0.9339623,0.6187458,0.110137,1;0;0
Node;AmplifyShaderEditor.PannerNode;50;-2523.977,-176.674;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;76;-2224.344,361.1308;Inherit;False;Property;_Main_UOffset;Main_UOffset;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;80;-2201.38,489.0413;Inherit;False;Property;_Use_Custom;Use_Custom;27;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-1682.227,631.3474;Inherit;False;Property;_Diss_VPanner;Diss_VPanner;26;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;40;-2346.977,-171.674;Inherit;True;Property;_Noise_Texture;Noise_Texture;19;0;Create;True;0;0;0;False;0;False;-1;None;1dbf1177420b46f47b20959a7c02ae71;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;27;-2388.366,107.584;Inherit;False;0;3;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;36;-1683.227,557.3474;Inherit;False;Property;_Diss_UPanner;Diss_UPanner;25;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;91;-2281.273,252.9232;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;34;-1643.227,418.3475;Inherit;False;0;29;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;90;-2089.38,119.19;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-2135.24,12.63806;Inherit;False;Property;_Noise_Str;Noise_Str;20;0;Create;True;0;0;0;False;0;False;0.7;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;78;-1969.086,295.0148;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;38;-1500.227,560.3474;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;41;-2033.977,-161.674;Inherit;False;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;35;-1383.227,447.3474;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-1839.047,-154.837;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;75;-1798.992,137.2461;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-1337.822,695.905;Inherit;False;Property;_Dissolve;Dissolve;24;0;Create;True;0;0;0;False;0;False;1;1.2;-1.2;1.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;81;-1066.307,785.027;Inherit;False;Property;_Use_Custom;Use_Custom;26;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;29;-1118.227,455.3474;Inherit;True;Property;_Dissolve_Texture;Dissolve_Texture;23;0;Create;True;0;0;0;False;0;False;-1;None;145143eb93006454baed654b5669d0c3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;46;-1586.597,-153.2764;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;3;-1172.201,-529.553;Inherit;True;Property;_Main_Texture;Main_Texture;5;0;Create;True;0;0;0;False;0;False;-1;42e47b216c6a84a43a4c7015898d2ffe;42e47b216c6a84a43a4c7015898d2ffe;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;18;-867.5006,137.4;Inherit;False;Property;_Opacity;Opacity;4;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;-790.2271,459.3474;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-1236.627,-204.5005;Inherit;False;Property;_Main_Ins;Main_Ins;11;0;Create;True;0;0;0;False;0;False;20.04;1;1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1194.2,-327.7426;Inherit;False;Property;_Main_Pow;Main_Pow;12;0;Create;True;0;0;0;False;0;False;6.04;3;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-676.8003,121.4;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;19;-568.5682,468.1383;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;82;-895.4092,-190.6353;Inherit;False;Property;_Use_Custom;Use_Custom;26;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;95;-652.4347,901.473;Inherit;False;0;94;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-366.459,172.6091;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;9;-827.8097,-490.6094;Inherit;True;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-577.567,-491.147;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;14;-601.6447,-285.1299;Inherit;False;Property;_Main_Color;Main_Color;10;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;3.968627,2.101961,1.145098,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;33;-195.2138,184.862;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;94;-399.8806,833.2538;Inherit;True;Property;_Mask_Texture;Mask_Texture;28;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;23;372.4786,-338.2434;Inherit;False;174;279;Enum;3;22;21;20;;1,0,0,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;97;47.17079,299.1148;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-341.8756,-492.2065;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;24;-167.1883,-189.4232;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;31.71179,-331.8032;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;22;395.4786,-146.2434;Inherit;False;Property;_CullMode;CullMode;3;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;397.4786,-223.2434;Inherit;False;Property;_DST;DST;2;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;21.31171,-139.4033;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;88;-2272.201,-1285.395;Inherit;False;Property;_Sub_VOffset;Sub_VOffset;15;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;-1027.579,-1511.866;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;62;-1277.822,-1511.328;Inherit;True;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;67;-1552.438,-1267.906;Inherit;False;Property;_Sub_Pow;Sub_Pow;18;0;Create;True;0;0;0;False;0;False;1;0;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;83;-1186.969,-1224.117;Inherit;False;Property;_Use_Custom;Use_Custom;26;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;66;-969.9877,-1257.921;Inherit;False;Property;_Sub_Color;Sub_Color;16;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;61;-1647.822,-1534.928;Inherit;True;Property;_Sub_Texture;Sub_Texture;13;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;68;-1534.454,-1193.821;Inherit;False;Property;_Sub_Ins;Sub_Ins;17;0;Create;True;0;0;0;False;0;False;1;0;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;89;-2261.999,-1555.484;Inherit;False;0;61;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;20;395.4786,-296.2434;Inherit;False;Property;_SRC;SRC;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;85;-2069.512,-1343.052;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;86;-2277.771,-1376.936;Inherit;False;Property;_Sub_UOffset;Sub_UOffset;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;84;-1932.418,-1507.82;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-791.8881,-1512.925;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;155,-340;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;YH/ParticleMaster;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;True;20;10;True;21;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;True;22;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;53;0;51;0
WireConnection;53;1;52;0
WireConnection;50;0;49;0
WireConnection;50;2;53;0
WireConnection;80;1;77;0
WireConnection;80;0;79;1
WireConnection;40;1;50;0
WireConnection;91;0;92;0
WireConnection;91;1;93;0
WireConnection;90;0;27;0
WireConnection;90;2;91;0
WireConnection;78;0;76;0
WireConnection;78;1;80;0
WireConnection;38;0;36;0
WireConnection;38;1;37;0
WireConnection;41;0;40;0
WireConnection;35;0;34;0
WireConnection;35;2;38;0
WireConnection;47;0;41;0
WireConnection;47;1;48;0
WireConnection;75;0;90;0
WireConnection;75;2;78;0
WireConnection;81;1;31;0
WireConnection;81;0;79;2
WireConnection;29;1;35;0
WireConnection;46;0;47;0
WireConnection;46;1;75;0
WireConnection;3;1;46;0
WireConnection;30;0;29;1
WireConnection;30;1;81;0
WireConnection;17;0;3;1
WireConnection;17;1;18;0
WireConnection;19;0;30;0
WireConnection;82;1;11;0
WireConnection;82;0;79;3
WireConnection;32;0;17;0
WireConnection;32;1;19;0
WireConnection;9;0;3;0
WireConnection;9;1;6;0
WireConnection;5;0;9;0
WireConnection;5;1;82;0
WireConnection;33;0;32;0
WireConnection;94;1;95;0
WireConnection;97;0;33;0
WireConnection;97;1;94;1
WireConnection;12;0;5;0
WireConnection;12;1;14;0
WireConnection;25;0;24;0
WireConnection;25;1;12;0
WireConnection;26;0;24;4
WireConnection;26;1;97;0
WireConnection;63;0;62;0
WireConnection;63;1;83;0
WireConnection;62;0;61;0
WireConnection;62;1;67;0
WireConnection;83;1;68;0
WireConnection;83;0;79;4
WireConnection;61;1;84;0
WireConnection;85;0;86;0
WireConnection;85;1;88;0
WireConnection;84;0;89;0
WireConnection;84;2;85;0
WireConnection;64;0;63;0
WireConnection;64;1;66;0
WireConnection;0;2;25;0
WireConnection;0;9;26;0
ASEEND*/
//CHKSM=0A38C4A111B7994CBC52BA7D9C18B17CCAFD9565