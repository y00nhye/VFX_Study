// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "YH/Orb_Plasma"
{
	Properties
	{
		[HDR]_Fresnel_InColor("Fresnel_InColor", Color) = (0.06627893,0,1,0)
		[HDR]_Fresnel_OutColor("Fresnel_OutColor", Color) = (1,0,0,0)
		_Fresnel_Scale("Fresnel_Scale", Range( 0 , 1)) = 1
		_Fresnel_Pow("Fresnel_Pow", Range( 1 , 10)) = 1
		_Main_Texure("Main_Texure", 2D) = "white" {}
		_Screw_Val("Screw_Val", Float) = 1
		_Main_VPanner("Main_VPanner", Float) = 0
		_Main_UPanner("Main_UPanner", Float) = 0
		_Fresnle_In_Scale("Fresnle_In_Scale", Range( -1 , 20)) = 1
		_Fresnel_In_Pow("Fresnel_In_Pow", Range( 0 , 10)) = 0
		[HDR]_Frensel_In_Color("Frensel_In_Color ", Color) = (0,0,0,0)
		_VertexNormal("VertexNormal", Float) = 1
		_Noise_Texture("Noise_Texture", 2D) = "bump" {}
		_Noise_VPanner("Noise_VPanner", Float) = 0
		_Noise_UPanner("Noise_UPanner", Float) = 1
		_Bubble_Speed("Bubble_Speed", Float) = 1
		_Noise_Str("Noise_Str", Float) = 0
		_Waver_Count("Waver_Count", Float) = 10
		_Dissove_Texture("Dissove_Texture", 2D) = "white" {}
		_Diss_UPanner("Diss_UPanner", Float) = 0
		_Diss_VPanner("Diss_VPanner", Float) = 0
		_Dissolve("Dissolve", Range( -1.25 , 2)) = 0
		_Smooth("Smooth", Range( 0 , 1)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float4 vertexColor : COLOR;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv_texcoord;
		};

		uniform float _Bubble_Speed;
		uniform float _Waver_Count;
		uniform float _VertexNormal;
		uniform float4 _Fresnel_InColor;
		uniform float4 _Fresnel_OutColor;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Screw_Val;
		uniform float _Noise_Str;
		uniform float _Fresnel_Scale;
		uniform float _Fresnel_Pow;
		uniform sampler2D _Main_Texure;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform float4 _Main_Texure_ST;
		uniform float4 _Frensel_In_Color;
		uniform float _Fresnle_In_Scale;
		uniform float _Fresnel_In_Pow;
		uniform float _Dissolve;
		uniform float _Smooth;
		uniform sampler2D _Dissove_Texture;
		uniform float _Diss_UPanner;
		uniform float _Diss_VPanner;
		uniform float4 _Dissove_Texture_ST;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertexNormal = v.normal.xyz;
			float temp_output_85_0 = (v.texcoord.xy).y;
			float mulTime91 = _Time.y * _Bubble_Speed;
			float temp_output_98_0 = sin( ( ( temp_output_85_0 + mulTime91 ) * _Waver_Count ) );
			v.vertex.xyz += ( ( ase_vertexNormal * ( saturate( pow( ( ( saturate( ( 1.0 - temp_output_85_0 ) ) * temp_output_85_0 ) * 4.0 ) , 2.0 ) ) * temp_output_98_0 ) ) * _VertexNormal );
			v.vertex.w = 1;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float2 appendResult43 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float temp_output_48_0 = (uv_Noise_Texture).y;
			float2 appendResult46 = (float2(( (uv_Noise_Texture).x + ( temp_output_48_0 * _Screw_Val ) ) , temp_output_48_0));
			float2 panner53 = ( 1.0 * _Time.y * appendResult43 + appendResult46);
			float3 newWorldNormal41 = (WorldNormalVector( i , UnpackScaleNormal( tex2D( _Noise_Texture, panner53 ), _Noise_Str ) ));
			float fresnelNdotV11 = dot( newWorldNormal41, ase_worldViewDir );
			float fresnelNode11 = ( 0.0 + _Fresnel_Scale * pow( 1.0 - fresnelNdotV11, _Fresnel_Pow ) );
			float temp_output_13_0 = saturate( fresnelNode11 );
			float2 appendResult26 = (float2(_Main_UPanner , _Main_VPanner));
			float2 uv_Main_Texure = i.uv_texcoord * _Main_Texure_ST.xy + _Main_Texure_ST.zw;
			float temp_output_21_0 = (uv_Main_Texure).y;
			float2 appendResult22 = (float2(( (uv_Main_Texure).x + ( temp_output_21_0 * _Screw_Val ) ) , temp_output_21_0));
			float2 panner23 = ( 1.0 * _Time.y * appendResult26 + appendResult22);
			float4 tex2DNode12 = tex2D( _Main_Texure, panner23 );
			float4 lerpResult18 = lerp( _Fresnel_InColor , _Fresnel_OutColor , ( temp_output_13_0 * ( temp_output_13_0 + tex2DNode12.r ) ));
			float fresnelNdotV30 = dot( newWorldNormal41, ase_worldViewDir );
			float fresnelNode30 = ( 0.0 + _Fresnle_In_Scale * pow( 1.0 - fresnelNdotV30, _Fresnel_In_Pow ) );
			o.Emission = ( i.vertexColor * ( lerpResult18 + ( _Frensel_In_Color * saturate( ( 1.0 - ( ( pow( tex2DNode12.r , 3.0 ) + fresnelNode30 ) * fresnelNode30 ) ) ) ) ) ).rgb;
			float temp_output_66_0 = ( 1.0 - _Dissolve );
			float2 appendResult62 = (float2(_Diss_UPanner , _Diss_VPanner));
			float2 uv_Dissove_Texture = i.uv_texcoord * _Dissove_Texture_ST.xy + _Dissove_Texture_ST.zw;
			float temp_output_73_0 = (uv_Dissove_Texture).y;
			float2 appendResult75 = (float2(( (uv_Dissove_Texture).x + ( temp_output_73_0 * _Screw_Val ) ) , temp_output_73_0));
			float2 panner65 = ( 1.0 * _Time.y * appendResult62 + appendResult75);
			float smoothstepResult71 = smoothstep( temp_output_66_0 , ( temp_output_66_0 + _Smooth ) , tex2D( _Dissove_Texture, panner65 ).r);
			o.Alpha = ( i.vertexColor.a * saturate( smoothstepResult71 ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
11;472;1157;405;2656.41;-252.4445;1;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;47;-4231.446,-674.0859;Inherit;True;0;42;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;49;-4128.484,-85.57209;Inherit;False;Property;_Screw_Val;Screw_Val;5;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;48;-3946.061,-515.2571;Inherit;True;False;True;True;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;19;-3533.64,-54.58448;Inherit;True;0;12;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;21;-3155.702,98.88806;Inherit;True;False;True;True;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-3549.354,-430.9294;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;50;-3944.185,-729.4285;Inherit;True;True;False;True;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-3362.481,-312.9642;Inherit;False;Property;_Noise_VPanner;Noise_VPanner;13;0;Create;True;0;0;0;False;0;False;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-3374.481,-422.9642;Inherit;False;Property;_Noise_UPanner;Noise_UPanner;14;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-3013.346,-30.58593;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;52;-3552.012,-697.4286;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;20;-3285.64,-123.5844;Inherit;True;True;False;True;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;43;-3173.02,-398.9642;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-2663.85,218.0025;Inherit;False;Property;_Main_UPanner;Main_UPanner;7;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;27;-2829.001,-87.19032;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-2651.85,328.0025;Inherit;False;Property;_Main_VPanner;Main_VPanner;6;0;Create;True;0;0;0;False;0;False;0;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;46;-3333.481,-684.9642;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;53;-2994.481,-594.9642;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;26;-2462.389,242.0025;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;22;-2622.85,-43.99752;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-2982.782,-412.8658;Inherit;False;Property;_Noise_Str;Noise_Str;16;0;Create;True;0;0;0;False;0;False;0;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;84;-2991.565,1836.47;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;42;-2790.138,-621.9626;Inherit;True;Property;_Noise_Texture;Noise_Texture;12;0;Create;True;0;0;0;False;0;False;-1;None;6ec0406191b202f41867835c163bf9c6;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;85;-2728.725,1833.545;Inherit;True;False;True;True;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;60;-3746.271,694.7314;Inherit;False;0;69;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;23;-2418.85,93.00248;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;12;-2250.124,57.87527;Inherit;True;Property;_Main_Texure;Main_Texure;4;0;Create;True;0;0;0;False;0;False;-1;145143eb93006454baed654b5669d0c3;77a0060064d668e4aadac7671a4cffff;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;41;-2456.138,-587.9626;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;83;-2161.384,362.5928;Inherit;False;Constant;_Float0;Float 0;20;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-2400.949,558.9386;Inherit;False;Property;_Fresnle_In_Scale;Fresnle_In_Scale;8;0;Create;True;0;0;0;False;0;False;1;20;-1;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;86;-2656.603,1698.789;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;73;-3280.283,709.3959;Inherit;True;False;True;True;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-2393.949,631.9386;Inherit;False;Property;_Fresnel_In_Pow;Fresnel_In_Pow;9;0;Create;True;0;0;0;False;0;False;0;1.01;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;82;-2005.688,309.7917;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;74;-3409.758,451.6527;Inherit;True;True;False;True;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-2574.006,-225.226;Inherit;False;Property;_Fresnel_Pow;Fresnel_Pow;3;0;Create;True;0;0;0;False;0;False;1;1;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;87;-2842.725,2117.546;Inherit;False;Property;_Bubble_Speed;Bubble_Speed;15;0;Create;True;0;0;0;False;0;False;1;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-2583.545,-307.226;Inherit;False;Property;_Fresnel_Scale;Fresnel_Scale;2;0;Create;True;0;0;0;False;0;False;1;0.786;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;88;-2512.603,1514.789;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;-3086.5,580.5243;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;30;-2128.989,495.6183;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-2423.659,1000.872;Inherit;False;Property;_Diss_VPanner;Diss_VPanner;20;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;11;-2237.375,-527.9158;Inherit;True;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-2433.786,899.1213;Inherit;False;Property;_Diss_UPanner;Diss_UPanner;19;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;81;-1721.373,285.4218;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;91;-2670.726,2042.545;Inherit;True;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;77;-2842.421,444.0497;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;89;-2208.603,1788.788;Inherit;False;Constant;_Float1;Float 1;15;0;Create;True;0;0;0;False;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;90;-2325.603,1610.789;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;93;-1943.447,1803.591;Inherit;False;Constant;_Float2;Float 2;15;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;62;-2206.777,943.3041;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-2177.215,1179.949;Inherit;False;Property;_Dissolve;Dissolve;21;0;Create;True;0;0;0;False;0;False;0;2;-1.25;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;92;-2417.726,1840.545;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;13;-1920.803,-144.0451;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;75;-2628.523,668.4453;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-1138.956,458.2765;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;-1998.604,1553.789;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-2347.726,2128.546;Inherit;False;Property;_Waver_Count;Waver_Count;17;0;Create;True;0;0;0;False;0;False;10;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;66;-1672.87,1111.483;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;34;-1494.983,462.6306;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;15;-1728.442,9.024085;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;68;-1742.255,1240.308;Inherit;False;Property;_Smooth;Smooth;22;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;96;-1792.447,1565.591;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;97;-2170.726,1905.545;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;65;-1982.777,856.3031;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SinOpNode;98;-1637.727,1870.545;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;69;-1777.379,829.2131;Inherit;True;Property;_Dissove_Texture;Dissove_Texture;18;0;Create;True;0;0;0;False;0;False;-1;None;145143eb93006454baed654b5669d0c3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-1526.877,-147.0383;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;17;-1719.307,-398.773;Inherit;False;Property;_Fresnel_OutColor;Fresnel_OutColor;1;1;[HDR];Create;True;0;0;0;False;0;False;1,0,0,0;1,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;99;-1614.38,1478.091;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;39;-903.8798,277.7696;Inherit;False;Property;_Frensel_In_Color;Frensel_In_Color ;10;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0.2075472,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;16;-1707.256,-609.5076;Inherit;False;Property;_Fresnel_InColor;Fresnel_InColor;0;1;[HDR];Create;True;0;0;0;False;0;False;0.06627893,0,1,0;0.01960784,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;37;-1286.906,484.2925;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;70;-1447.125,1160.801;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;18;-1107.307,-366.773;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-1033.949,-51.0614;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.NormalVertexDataNode;103;-1056.574,1679.307;Inherit;True;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;71;-1460.32,833.121;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;100;-1419.319,1433.281;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;78;-648.1459,-435.9839;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;72;-424.2676,306.5669;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;104;-559.9238,1685.609;Inherit;True;Property;_VertexNormal;VertexNormal;11;0;Create;True;0;0;0;False;0;False;1;0.02;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;40;-733.9495,-177.0614;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;101;-863.1811,1345.63;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;105;-30.47952,830.9234;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;102;-1221.933,1654.409;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;80;-246.0167,95.15582;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;-361.3029,-408.535;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;4,-292;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;YH/Orb_Plasma;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;48;0;47;0
WireConnection;21;0;19;0
WireConnection;51;0;48;0
WireConnection;51;1;49;0
WireConnection;50;0;47;0
WireConnection;28;0;21;0
WireConnection;28;1;49;0
WireConnection;52;0;50;0
WireConnection;52;1;51;0
WireConnection;20;0;19;0
WireConnection;43;0;45;0
WireConnection;43;1;44;0
WireConnection;27;0;20;0
WireConnection;27;1;28;0
WireConnection;46;0;52;0
WireConnection;46;1;48;0
WireConnection;53;0;46;0
WireConnection;53;2;43;0
WireConnection;26;0;25;0
WireConnection;26;1;24;0
WireConnection;22;0;27;0
WireConnection;22;1;21;0
WireConnection;42;1;53;0
WireConnection;42;5;54;0
WireConnection;85;0;84;0
WireConnection;23;0;22;0
WireConnection;23;2;26;0
WireConnection;12;1;23;0
WireConnection;41;0;42;0
WireConnection;86;0;85;0
WireConnection;73;0;60;0
WireConnection;82;0;12;1
WireConnection;82;1;83;0
WireConnection;74;0;60;0
WireConnection;88;0;86;0
WireConnection;76;0;73;0
WireConnection;76;1;49;0
WireConnection;30;0;41;0
WireConnection;30;2;35;0
WireConnection;30;3;36;0
WireConnection;11;0;41;0
WireConnection;11;2;10;0
WireConnection;11;3;9;0
WireConnection;81;0;82;0
WireConnection;81;1;30;0
WireConnection;91;0;87;0
WireConnection;77;0;74;0
WireConnection;77;1;76;0
WireConnection;90;0;88;0
WireConnection;90;1;85;0
WireConnection;62;0;57;0
WireConnection;62;1;55;0
WireConnection;92;0;85;0
WireConnection;92;1;91;0
WireConnection;13;0;11;0
WireConnection;75;0;77;0
WireConnection;75;1;73;0
WireConnection;33;0;81;0
WireConnection;33;1;30;0
WireConnection;94;0;90;0
WireConnection;94;1;89;0
WireConnection;66;0;58;0
WireConnection;34;0;33;0
WireConnection;15;0;13;0
WireConnection;15;1;12;1
WireConnection;96;0;94;0
WireConnection;96;1;93;0
WireConnection;97;0;92;0
WireConnection;97;1;95;0
WireConnection;65;0;75;0
WireConnection;65;2;62;0
WireConnection;98;0;97;0
WireConnection;69;1;65;0
WireConnection;14;0;13;0
WireConnection;14;1;15;0
WireConnection;99;0;96;0
WireConnection;37;0;34;0
WireConnection;70;0;66;0
WireConnection;70;1;68;0
WireConnection;18;0;16;0
WireConnection;18;1;17;0
WireConnection;18;2;14;0
WireConnection;38;0;39;0
WireConnection;38;1;37;0
WireConnection;71;0;69;1
WireConnection;71;1;66;0
WireConnection;71;2;70;0
WireConnection;100;0;99;0
WireConnection;100;1;98;0
WireConnection;72;0;71;0
WireConnection;40;0;18;0
WireConnection;40;1;38;0
WireConnection;101;0;103;0
WireConnection;101;1;100;0
WireConnection;105;0;101;0
WireConnection;105;1;104;0
WireConnection;102;0;98;0
WireConnection;80;0;78;4
WireConnection;80;1;72;0
WireConnection;79;0;78;0
WireConnection;79;1;40;0
WireConnection;0;2;79;0
WireConnection;0;9;80;0
WireConnection;0;11;105;0
ASEEND*/
//CHKSM=61F88FAA96BC0621C43B7251576269A44F07D5EE