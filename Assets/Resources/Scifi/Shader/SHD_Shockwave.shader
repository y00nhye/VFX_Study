// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "YH/Shockwave"
{
	Properties
	{
		[Enum(UnityEngine.Rendering.BlendMode)]_SRC("SRC", Float) = 0
		[Enum(UnityEngine.Rendering.BlendMode)]_DST("DST", Float) = 0
		[Enum(UnityEngine.Rendering.CullMode)]_CullMode("CullMode", Float) = 0
		_ShokeOffset("ShokeOffset", Range( -1.5 , 1.5)) = 0.54
		_Gra_Texture("Gra_Texture", 2D) = "white" {}
		_Chromatic_Val("Chromatic_Val", Range( 0 , 0.25)) = 0
		[HDR]_Gra_Color("Gra_Color", Color) = (0,0,0,0)
		_Gra_Ins("Gra_Ins", Float) = 1
		_Gra_Pow("Gra_Pow", Float) = 1
		_Opacity("Opacity", Float) = 1
		_Mask_Texture("Mask_Texture", 2D) = "white" {}
		_Mask_Range("Mask_Range", Float) = 1
		_Nose_Texture("Nose_Texture", 2D) = "bump" {}
		_Noise_Str("Noise_Str", Float) = 0
		_Noise_UPanner("Noise_UPanner", Float) = 0
		_Noise_VPanner("Noise_VPanner", Float) = 0
		_Noise_VPower("Noise_VPower", Float) = 0.38
		_Dissove_Texture("Dissove_Texture", 2D) = "white" {}
		_Diss_UPanner("Diss_UPanner", Float) = 0
		_Diss_VPanner("Diss_VPanner", Float) = 0
		_Dissolve("Dissolve", Range( -1.25 , 2)) = 0
		_Smooth("Smooth", Range( 0 , 1)) = 1
		_Diss_VOffset("Diss_VOffset", Float) = 0
		_Sub_Texture("Sub_Texture", 2D) = "white" {}
		_SubTex_UPanner("SubTex_UPanner", Float) = 0
		_SubTex_VPanner("SubTex_VPanner", Float) = 0
		_SubTex_Ins("SubTex_Ins", Float) = 0
		_SubTex_Pow("SubTex_Pow", Float) = 1
		[HDR]_SubTex_Color("SubTex_Color", Color) = (0,0,0,0)
		[Toggle(_USE_CUSTOM_ON)] _Use_Custom("Use_Custom", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
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

		uniform float _SRC;
		uniform float _DST;
		uniform float _CullMode;
		uniform sampler2D _Sub_Texture;
		uniform float _SubTex_UPanner;
		uniform float _SubTex_VPanner;
		uniform float4 _Sub_Texture_ST;
		uniform float _SubTex_Pow;
		uniform float _SubTex_Ins;
		uniform float4 _SubTex_Color;
		uniform sampler2D _Gra_Texture;
		uniform sampler2D _Nose_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Nose_Texture_ST;
		uniform float _Noise_VPower;
		uniform float _Noise_Str;
		uniform float4 _Gra_Texture_ST;
		uniform float _ShokeOffset;
		uniform float _Chromatic_Val;
		uniform float _Gra_Pow;
		uniform float _Gra_Ins;
		uniform float4 _Gra_Color;
		uniform float _Opacity;
		uniform float _Dissolve;
		uniform float _Smooth;
		uniform sampler2D _Dissove_Texture;
		uniform float _Diss_UPanner;
		uniform float _Diss_VPanner;
		uniform float4 _Dissove_Texture_ST;
		uniform float _Diss_VOffset;
		uniform sampler2D _Mask_Texture;
		uniform float _Mask_Range;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult60 = (float2(_SubTex_UPanner , _SubTex_VPanner));
			float2 uv_Sub_Texture = i.uv_texcoord * _Sub_Texture_ST.xy + _Sub_Texture_ST.zw;
			float2 panner56 = ( 1.0 * _Time.y * appendResult60 + uv_Sub_Texture);
			float4 appendResult46 = (float4(_Noise_UPanner , _Noise_VPanner , 0.0 , 0.0));
			float2 uv_Nose_Texture = i.uv_texcoord * _Nose_Texture_ST.xy + _Nose_Texture_ST.zw;
			float2 appendResult50 = (float2(pow( uv_Nose_Texture.x , 1.0 ) , pow( uv_Nose_Texture.y , _Noise_VPower )));
			float2 panner43 = ( 1.0 * _Time.y * appendResult46.xy + (appendResult50*1.0 + 0.0));
			float2 uv_Gra_Texture = i.uv_texcoord * _Gra_Texture_ST.xy + _Gra_Texture_ST.zw;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch92 = i.uv2_tex4coord2.x;
			#else
				float staticSwitch92 = _ShokeOffset;
			#endif
			float2 appendResult10 = (float2(0.0 , staticSwitch92));
			float2 temp_output_7_0 = (( ( (UnpackNormal( tex2D( _Nose_Texture, panner43 ) )).xy * _Noise_Str ) + uv_Gra_Texture )*1.0 + appendResult10);
			float4 tex2DNode5 = tex2D( _Gra_Texture, temp_output_7_0 );
			float2 temp_cast_1 = (_Chromatic_Val).xx;
			float3 appendResult14 = (float3(tex2D( _Gra_Texture, ( temp_output_7_0 + _Chromatic_Val ) ).r , tex2DNode5.g , tex2D( _Gra_Texture, ( temp_output_7_0 - temp_cast_1 ) ).b));
			float3 temp_cast_2 = (_Gra_Pow).xxx;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch93 = i.uv2_tex4coord2.y;
			#else
				float staticSwitch93 = _Gra_Ins;
			#endif
			o.Emission = ( i.vertexColor * ( ( ( pow( tex2D( _Sub_Texture, panner56 ).r , _SubTex_Pow ) * _SubTex_Ins ) * _SubTex_Color ) + ( float4( ( pow( appendResult14 , temp_cast_2 ) * staticSwitch93 ) , 0.0 ) * _Gra_Color ) ) ).rgb;
			#ifdef _USE_CUSTOM_ON
				float staticSwitch94 = i.uv2_tex4coord2.z;
			#else
				float staticSwitch94 = _Dissolve;
			#endif
			float temp_output_75_0 = ( 1.0 - staticSwitch94 );
			float2 appendResult83 = (float2(_Diss_UPanner , _Diss_VPanner));
			float2 uv_Dissove_Texture = i.uv_texcoord * _Dissove_Texture_ST.xy + _Dissove_Texture_ST.zw;
			float2 panner80 = ( 1.0 * _Time.y * appendResult83 + uv_Dissove_Texture);
			#ifdef _USE_CUSTOM_ON
				float staticSwitch95 = i.uv2_tex4coord2.w;
			#else
				float staticSwitch95 = _Diss_VOffset;
			#endif
			float2 appendResult87 = (float2(0.0 , staticSwitch95));
			float smoothstepResult77 = smoothstep( temp_output_75_0 , ( temp_output_75_0 + _Smooth ) , tex2D( _Dissove_Texture, (panner80*1.0 + appendResult87) ).r);
			o.Alpha = ( i.vertexColor.a * saturate( ( ( ( tex2DNode5.g * _Opacity ) * saturate( smoothstepResult77 ) ) * pow( tex2D( _Mask_Texture, i.uv_texcoord ).r , _Mask_Range ) ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
1920;118;1309;897;3765.5;-342.1885;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;69;-4457.422,-1120.693;Inherit;False;1766.787;756.317;Comment;12;40;38;39;37;49;47;44;45;46;50;43;101;;0.06132078,0.4303458,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;42;-4662.422,-1020.795;Inherit;False;0;37;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;51;-4596.128,-847.5983;Inherit;False;Property;_Noise_VPower;Noise_VPower;17;0;Create;True;0;0;0;False;0;False;0.38;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;49;-4382.847,-855.1626;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;47;-4351.334,-1062.693;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-4171.97,-491.3755;Inherit;False;Property;_Noise_VPanner;Noise_VPanner;16;0;Create;True;0;0;0;False;0;False;0;0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;50;-4071.464,-990.7943;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-4181.97,-596.3755;Inherit;False;Property;_Noise_UPanner;Noise_UPanner;15;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;46;-4007.97,-547.3755;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;101;-3783.389,-907.7444;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;43;-3717.442,-715.6376;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;37;-3522.954,-744.1392;Inherit;True;Property;_Nose_Texture;Nose_Texture;13;0;Create;True;0;0;0;False;0;False;-1;None;1dbf1177420b46f47b20959a7c02ae71;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;9;-3037.342,-15.26865;Inherit;False;Property;_ShokeOffset;ShokeOffset;4;0;Create;True;0;0;0;False;0;False;0.54;-0.01;-1.5;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;89;-2999.534,673.0201;Inherit;False;1550.959;663.4766;Dissolve;18;72;78;77;75;74;76;71;83;80;81;82;84;87;85;86;94;95;79;;1,0.4906856,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-3147.635,-482.6699;Inherit;False;Property;_Noise_Str;Noise_Str;14;0;Create;True;0;0;0;False;0;False;0;0.02;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;90;-3051.914,65.87505;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;38;-3200.635,-735.6699;Inherit;True;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;82;-2931.534,1014.111;Inherit;False;Property;_Diss_VPanner;Diss_VPanner;20;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;-2722.019,962.26;Inherit;False;Property;_Diss_VOffset;Diss_VOffset;23;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-2938.669,-329.0255;Inherit;True;0;13;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;8;-2686.669,-72.02547;Inherit;False;Constant;_Float0;Float 0;5;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-2949.534,907.1107;Inherit;False;Property;_Diss_UPanner;Diss_UPanner;19;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;-2925.635,-733.6699;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;92;-2748.635,-15.97705;Inherit;False;Property;_Use_Custom;Use_Custom;30;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;95;-2569.141,954.4272;Inherit;False;Property;_Use_Custom;Use_Custom;30;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;41;-2700.635,-410.6699;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;83;-2769.534,901.1107;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;68;-1988.238,-1202.554;Inherit;False;1511.943;532.9999;Sub;12;57;58;56;60;15;55;61;62;64;66;65;63;;1,0.6717818,0.0990566,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-2593.972,1073.756;Inherit;False;Property;_Dissolve;Dissolve;21;0;Create;True;0;0;0;False;0;False;0;1.82;-1.25;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;85;-2561.534,863.1107;Inherit;False;Constant;_Float1;Float 1;29;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;10;-2462.669,-85.02547;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;79;-2944.771,751.902;Inherit;False;0;71;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;7;-2465.669,-339.0255;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-1911.295,-858.5544;Inherit;False;Property;_SubTex_UPanner;SubTex_UPanner;25;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-2361.322,-180.2318;Inherit;False;Property;_Chromatic_Val;Chromatic_Val;6;0;Create;True;0;0;0;False;0;False;0;0;0;0.25;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;94;-2315.846,1049.723;Inherit;False;Property;_Use_Custom;Use_Custom;30;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;87;-2408.534,906.1107;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;80;-2673.534,757.1106;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-1903.295,-785.5544;Inherit;False;Property;_SubTex_VPanner;SubTex_VPanner;26;0;Create;True;0;0;0;False;0;False;0;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;-2159.011,1134.115;Inherit;False;Property;_Smooth;Smooth;22;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;13;-1841.448,-374.7603;Inherit;True;Property;_Gra_Texture;Gra_Texture;5;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-1855.452,-593.4686;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;60;-1712.295,-977.5544;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;15;-1938.238,-1137.905;Inherit;True;0;55;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;20;-1687.31,-151.1792;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;75;-2089.627,1005.29;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;84;-2393.348,751.6262;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;5;-1616.536,-402.628;Inherit;True;Property;_FXT_Gra01;FXT_Gra01;4;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;12;-1628.536,-645.6282;Inherit;True;Property;_TextureSample1;Texture Sample 1;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;76;-1863.881,1082.497;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;71;-2194.135,723.0201;Inherit;True;Property;_Dissove_Texture;Dissove_Texture;18;0;Create;True;0;0;0;False;0;False;-1;None;145143eb93006454baed654b5669d0c3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;70;-2479.22,172.5572;Inherit;False;944.9995;418.9999;Mask;4;32;35;33;34;;0.4987088,1,0.1273585,1;0;0
Node;AmplifyShaderEditor.PannerNode;56;-1638.295,-1127.554;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;11;-1587.536,-75.62805;Inherit;True;Property;_TextureSample0;Texture Sample 0;5;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;25;-1289.099,-383.2064;Inherit;False;Property;_Gra_Pow;Gra_Pow;9;0;Create;True;0;0;0;False;0;False;1;1.34;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;32;-2429.22,234.5571;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;77;-1877.076,726.928;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;55;-1446.295,-1152.554;Inherit;True;Property;_Sub_Texture;Sub_Texture;24;0;Create;True;0;0;0;False;0;False;-1;None;c2f573b1c34af114386170fd1fa13036;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;30;-1482.571,239.2583;Inherit;False;Property;_Opacity;Opacity;10;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;64;-1266.295,-876.5544;Inherit;False;Property;_SubTex_Pow;SubTex_Pow;28;0;Create;True;0;0;0;False;0;False;1;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-1158.716,-273.5713;Inherit;False;Property;_Gra_Ins;Gra_Ins;8;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;14;-1272.923,-597.2798;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;22;-1013.984,-502.9563;Inherit;False;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;33;-2168.22,222.5571;Inherit;True;Property;_Mask_Texture;Mask_Texture;11;0;Create;True;0;0;0;False;0;False;-1;None;a0c320c805bd28241ae8955f75a8e5c0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;93;-997.1373,-258.2867;Inherit;False;Property;_Use_Custom;Use_Custom;30;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;78;-1646.576,728.7295;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;61;-1150.295,-1124.554;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-999.2946,-899.5544;Inherit;False;Property;_SubTex_Ins;SubTex_Ins;27;0;Create;True;0;0;0;False;0;False;0;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-1243.57,183.2584;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-2057.222,475.5571;Inherit;False;Property;_Mask_Range;Mask_Range;12;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;28;-943.58,-91.07086;Inherit;False;Property;_Gra_Color;Gra_Color;7;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;1.720618,0.7490279,0.1638683,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-862.0607,-455.0137;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;66;-749.2945,-882.5544;Inherit;False;Property;_SubTex_Color;SubTex_Color;29;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;10.45984,4.272394,1.233472,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;88;-989.5557,205.6872;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;34;-1794.223,237.5572;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;-914.2946,-1122.554;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-677.0945,-367.8187;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;-711.2945,-1145.554;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-715.3107,317.6931;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;31;-521.5708,271.6975;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1;290.25,-236.25;Inherit;False;174;279;Enum;3;4;3;2;;1,0,0,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;67;-372.2723,-865.9131;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;52;-444.7055,-523.4131;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;96;-4888.685,-604.2006;Inherit;False;Property;_Use_Custom;Use_Custom;30;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;98;-4533.281,1024.196;Inherit;False;Property;_Use_Custom;Use_Custom;30;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;107;-4307.195,1022.301;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;104;-4588.55,-564.7869;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;3;313.25,-44.25;Inherit;False;Property;_CullMode;CullMode;3;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;-324.9277,79.84363;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;91;-5097.867,822.621;Inherit;False;2;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;315.25,-121.25;Inherit;False;Property;_DST;DST;2;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;313.25,-194.25;Inherit;False;Property;_SRC;SRC;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;102;-5131.381,-553.4474;Inherit;False;Constant;_Float2;Float 2;38;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;106;-4754.25,1067.854;Inherit;False;Constant;_Float3;Float 3;38;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;97;-4874.435,-491.7753;Inherit;False;Property;_Use_Custom;Use_Custom;30;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;-166.3889,-445.3141;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;99;-4542.781,1134.697;Inherit;False;Property;_Use_Custom;Use_Custom;30;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-162.381,-230.9001;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;YH/Shockwave;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Back;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;True;2;10;True;4;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;True;3;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;49;0;42;2
WireConnection;49;1;51;0
WireConnection;47;0;42;1
WireConnection;50;0;47;0
WireConnection;50;1;49;0
WireConnection;46;0;44;0
WireConnection;46;1;45;0
WireConnection;101;0;50;0
WireConnection;43;0;101;0
WireConnection;43;2;46;0
WireConnection;37;1;43;0
WireConnection;38;0;37;0
WireConnection;39;0;38;0
WireConnection;39;1;40;0
WireConnection;92;1;9;0
WireConnection;92;0;90;1
WireConnection;95;1;86;0
WireConnection;95;0;90;4
WireConnection;41;0;39;0
WireConnection;41;1;6;0
WireConnection;83;0;81;0
WireConnection;83;1;82;0
WireConnection;10;0;8;0
WireConnection;10;1;92;0
WireConnection;7;0;41;0
WireConnection;7;2;10;0
WireConnection;94;1;72;0
WireConnection;94;0;90;3
WireConnection;87;0;85;0
WireConnection;87;1;95;0
WireConnection;80;0;79;0
WireConnection;80;2;83;0
WireConnection;19;0;7;0
WireConnection;19;1;21;0
WireConnection;60;0;57;0
WireConnection;60;1;58;0
WireConnection;20;0;7;0
WireConnection;20;1;21;0
WireConnection;75;0;94;0
WireConnection;84;0;80;0
WireConnection;84;2;87;0
WireConnection;5;0;13;0
WireConnection;5;1;7;0
WireConnection;12;0;13;0
WireConnection;12;1;19;0
WireConnection;76;0;75;0
WireConnection;76;1;74;0
WireConnection;71;1;84;0
WireConnection;56;0;15;0
WireConnection;56;2;60;0
WireConnection;11;0;13;0
WireConnection;11;1;20;0
WireConnection;77;0;71;1
WireConnection;77;1;75;0
WireConnection;77;2;76;0
WireConnection;55;1;56;0
WireConnection;14;0;12;1
WireConnection;14;1;5;2
WireConnection;14;2;11;3
WireConnection;22;0;14;0
WireConnection;22;1;25;0
WireConnection;33;1;32;0
WireConnection;93;1;26;0
WireConnection;93;0;90;2
WireConnection;78;0;77;0
WireConnection;61;0;55;1
WireConnection;61;1;64;0
WireConnection;29;0;5;2
WireConnection;29;1;30;0
WireConnection;23;0;22;0
WireConnection;23;1;93;0
WireConnection;88;0;29;0
WireConnection;88;1;78;0
WireConnection;34;0;33;1
WireConnection;34;1;35;0
WireConnection;62;0;61;0
WireConnection;62;1;65;0
WireConnection;24;0;23;0
WireConnection;24;1;28;0
WireConnection;63;0;62;0
WireConnection;63;1;66;0
WireConnection;36;0;88;0
WireConnection;36;1;34;0
WireConnection;31;0;36;0
WireConnection;67;0;63;0
WireConnection;67;1;24;0
WireConnection;96;1;102;0
WireConnection;96;0;91;1
WireConnection;98;1;106;0
WireConnection;98;0;91;3
WireConnection;107;0;98;0
WireConnection;107;1;99;0
WireConnection;104;0;96;0
WireConnection;104;1;97;0
WireConnection;54;0;52;4
WireConnection;54;1;31;0
WireConnection;97;1;102;0
WireConnection;97;0;91;2
WireConnection;53;0;52;0
WireConnection;53;1;67;0
WireConnection;99;1;106;0
WireConnection;99;0;91;4
WireConnection;0;2;53;0
WireConnection;0;9;54;0
ASEEND*/
//CHKSM=B0F386894268C860025CA5E85B76AD5C1ED5D127