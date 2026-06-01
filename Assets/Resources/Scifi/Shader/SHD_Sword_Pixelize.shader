// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "YH/Sword_Picxelize"
{
	Properties
	{
		_Sword_Texture("Sword_Texture", 2D) = "white" {}
		_Sword_UOffset("Sword_UOffset", Range( -1.5 , 1.5)) = 0
		_Sword_VOffset("Sword_VOffset", Float) = 0
		_Mask_Range("Mask_Range", Float) = 3
		_Opacity("Opacity", Float) = 1
		_Main_Texture("Main_Texture", 2D) = "white" {}
		[HDR]_Main_Color("Main_Color", Color) = (1,0,0,0)
		_Main_Ins("Main_Ins", Float) = 1
		_Main_Pow("Main_Pow", Float) = 1
		_Main_UPanner("Main_UPanner", Float) = 0
		_Main_VPanner("Main_VPanner", Float) = 0
		[HDR]_Edge_Color("Edge_Color", Color) = (0,0,0,0)
		_Edge_Range("Edge_Range", Range( -1.5 , 1)) = 0
		_Edge_Range_Pow("Edge_Range_Pow", Range( 1 , 10)) = 1
		_Edge_Range_Ins("Edge_Range_Ins", Range( 0 , 10)) = 1.258754
		_Emi_Offset("Emi_Offset", Range( -1.5 , 1.5)) = 0
		_Emi_Ins("Emi_Ins", Range( 1 , 50)) = 1
		[HDR]_Emi_Color("Emi_Color", Color) = (1,0.03301889,0.03301889,0)
		_Noise_Texture("Noise_Texture", 2D) = "bump" {}
		_Noise_str("Noise_str", Range( 0 , 1)) = 0
		_Noise_UPanner("Noise_UPanner", Float) = 0
		_Noise_VPanner("Noise_VPanner", Float) = 0
		_Dissolve("Dissolve", Range( -1.2 , 1.2)) = 0
		_Dissolve_UPanner("Dissolve_UPanner", Float) = 0
		_Dissolve_VPanner("Dissolve_VPanner", Float) = 0
		[Toggle(_USE_COSTOM_ON)] _USE_COSTOM("USE_COSTOM", Float) = 0
		_Dissolve_Texture("Dissolve_Texture", 2D) = "white" {}
		[HideInInspector] _tex4coord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _USE_COSTOM_ON
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float2 uv_texcoord;
			float4 uv2_tex4coord2;
			float4 vertexColor : COLOR;
		};

		uniform float4 _Main_Color;
		uniform sampler2D _Main_Texture;
		uniform float _Main_UPanner;
		uniform float _Main_VPanner;
		uniform sampler2D _Noise_Texture;
		uniform float _Noise_UPanner;
		uniform float _Noise_VPanner;
		uniform float4 _Noise_Texture_ST;
		uniform float _Noise_str;
		uniform float4 _Main_Texture_ST;
		uniform float _Main_Pow;
		uniform float _Main_Ins;
		uniform sampler2D _Sword_Texture;
		uniform float _Sword_UOffset;
		uniform float _Sword_VOffset;
		uniform float _Edge_Range;
		uniform float _Edge_Range_Pow;
		uniform float _Edge_Range_Ins;
		uniform float4 _Edge_Color;
		uniform float _Emi_Offset;
		uniform float _Emi_Ins;
		uniform float4 _Emi_Color;
		uniform float _Opacity;
		uniform sampler2D _Dissolve_Texture;
		uniform float _Dissolve_UPanner;
		uniform float _Dissolve_VPanner;
		uniform float4 _Dissolve_Texture_ST;
		uniform float _Dissolve;
		uniform float _Mask_Range;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult15 = (float2(_Main_UPanner , _Main_VPanner));
			float2 appendResult28 = (float2(_Noise_UPanner , _Noise_VPanner));
			float2 uv_Noise_Texture = i.uv_texcoord * _Noise_Texture_ST.xy + _Noise_Texture_ST.zw;
			float2 temp_cast_0 = (uv_Noise_Texture.x).xx;
			float2 panner27 = ( 1.0 * _Time.y * appendResult28 + temp_cast_0);
			float2 uv_Main_Texture = i.uv_texcoord * _Main_Texture_ST.xy + _Main_Texture_ST.zw;
			float2 panner38 = ( 1.0 * _Time.y * appendResult15 + ( ( (UnpackNormal( tex2D( _Noise_Texture, panner27 ) )).xy * _Noise_str ) + uv_Main_Texture ));
			float pixelWidth102 =  1.0f / 40.0;
			float pixelHeight102 = 1.0f / 20.0;
			half2 pixelateduv102 = half2((int)(i.uv_texcoord.x / pixelWidth102) * pixelWidth102, (int)(i.uv_texcoord.y / pixelHeight102) * pixelHeight102);
			#ifdef _USE_COSTOM_ON
				float staticSwitch88 = i.uv2_tex4coord2.x;
			#else
				float staticSwitch88 = _Sword_UOffset;
			#endif
			float2 appendResult53 = (float2(staticSwitch88 , _Sword_VOffset));
			float4 tex2DNode51 = tex2D( _Sword_Texture, (pixelateduv102*1.0 + appendResult53) );
			#ifdef _USE_COSTOM_ON
				float staticSwitch89 = i.uv2_tex4coord2.y;
			#else
				float staticSwitch89 = _Emi_Offset;
			#endif
			#ifdef _USE_COSTOM_ON
				float staticSwitch90 = i.uv2_tex4coord2.z;
			#else
				float staticSwitch90 = _Emi_Ins;
			#endif
			o.Emission = ( ( ( _Main_Color * ( ( ( pow( tex2D( _Main_Texture, panner38 ).r , _Main_Pow ) * _Main_Ins ) + ( ( pow( saturate( ( tex2DNode51.b + _Edge_Range ) ) , _Edge_Range_Pow ) * _Edge_Range_Ins ) * _Edge_Color ) ) + tex2DNode51.g ) ) + ( ( saturate( ( saturate( ( 1.0 - i.uv_texcoord.x ) ) + staticSwitch89 ) ) * staticSwitch90 ) * _Emi_Color ) ) * i.vertexColor ).rgb;
			float2 appendResult41 = (float2(_Dissolve_UPanner , _Dissolve_VPanner));
			float2 uv_Dissolve_Texture = i.uv_texcoord * _Dissolve_Texture_ST.xy + _Dissolve_Texture_ST.zw;
			float pixelWidth98 =  1.0f / 20.0;
			float pixelHeight98 = 1.0f / 10.0;
			half2 pixelateduv98 = half2((int)(uv_Dissolve_Texture.x / pixelWidth98) * pixelWidth98, (int)(uv_Dissolve_Texture.y / pixelHeight98) * pixelHeight98);
			float2 panner40 = ( 1.0 * _Time.y * appendResult41 + pixelateduv98);
			#ifdef _USE_COSTOM_ON
				float staticSwitch91 = i.uv2_tex4coord2.w;
			#else
				float staticSwitch91 = _Dissolve;
			#endif
			o.Alpha = ( i.vertexColor.a * saturate( ( ( ( tex2DNode51.r * _Opacity ) * saturate( ( tex2D( _Dissolve_Texture, panner40 ).r + staticSwitch91 ) ) ) * saturate( pow( ( saturate( ( i.uv_texcoord.x * saturate( ( 1.0 - i.uv_texcoord.x ) ) ) ) * 4.0 ) , _Mask_Range ) ) ) ) );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18712
1920;118;1309;897;4108.591;557.3976;3.508974;True;False
Node;AmplifyShaderEditor.RangedFloatNode;29;-3097.818,-172.9929;Inherit;False;Property;_Noise_UPanner;Noise_UPanner;20;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-3097.818,-92.99296;Inherit;False;Property;_Noise_VPanner;Noise_VPanner;21;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;28;-2921.818,-188.9929;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;26;-3001.818,-316.993;Inherit;False;0;25;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;87;-2425.54,966.2186;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;54;-1884.164,956.1414;Inherit;False;Property;_Sword_UOffset;Sword_UOffset;1;0;Create;True;0;0;0;False;0;False;0;-0.16;-1.5;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;88;-1621.651,956.3645;Inherit;False;Property;_USE_COSTOM;USE_COSTOM;25;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;50;-1924.773,806.8688;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;103;-1757.505,687.9485;Inherit;False;Constant;_Float3;Float 3;29;0;Create;True;0;0;0;False;0;False;40;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-1581.804,1061.79;Inherit;False;Property;_Sword_VOffset;Sword_VOffset;2;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;104;-1893.554,721.9962;Inherit;False;Constant;_Float4;Float 4;29;0;Create;True;0;0;0;False;0;False;20;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;27;-2777.818,-268.993;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;53;-1398.778,1013.004;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;25;-2601.818,-300.993;Inherit;True;Property;_Noise_Texture;Noise_Texture;18;0;Create;True;0;0;0;False;0;False;-1;None;82d7a1f26ef85f048b76b9dcc08c906b;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCPixelate;102;-1534.531,814.9727;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-2313.818,-220.9929;Inherit;False;Property;_Noise_str;Noise_str;19;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;52;-1250.779,870.7018;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;31;-2313.818,-300.993;Inherit;False;True;True;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;37;-2122.818,-137.993;Inherit;False;0;6;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;17;-2041.818,99.00713;Inherit;False;Property;_Main_VPanner;Main_VPanner;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-2043.818,-295.993;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;56;-1770.77,1516.671;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;51;-1061.181,839.2389;Inherit;True;Property;_Sword_Texture;Sword_Texture;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;70;-1849.812,599.2573;Inherit;False;Property;_Edge_Range;Edge_Range;12;0;Create;True;0;0;0;False;0;False;0;0;-1.5;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-2041.818,19.00713;Inherit;False;Property;_Main_UPanner;Main_UPanner;9;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;15;-1865.818,19.00713;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;69;-1576.812,527.2573;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;44;-1953.456,1123.671;Inherit;False;0;97;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;99;-1999.61,1252.122;Inherit;False;Constant;_Float1;Float 1;29;0;Create;True;0;0;0;False;0;False;20;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-1814.321,1355.925;Inherit;False;Property;_Dissolve_VPanner;Dissolve_VPanner;24;0;Create;True;0;0;0;False;0;False;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;36;-1865.818,-156.9929;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;57;-1509.931,1522.361;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-1814.646,1272.025;Inherit;False;Property;_Dissolve_UPanner;Dissolve_UPanner;23;0;Create;True;0;0;0;False;0;False;0;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;101;-1978.359,1348.57;Inherit;False;Constant;_Float2;Float 2;29;0;Create;True;0;0;0;False;0;False;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;38;-1721.818,-60.99294;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;74;-1575.812,742.2573;Inherit;False;Property;_Edge_Range_Pow;Edge_Range_Pow;13;0;Create;True;0;0;0;False;0;False;1;2.5;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;41;-1616.617,1276.276;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;58;-1369.092,1522.047;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCPixelate;98;-1687.872,1131.035;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;68;-1841.912,479.2572;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;71;-1380.812,527.2573;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;40;-1476.26,1227.152;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;94;-2088.703,1407.695;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;77;-1593.199,199.4513;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;75;-1251.812,743.2573;Inherit;False;Property;_Edge_Range_Ins;Edge_Range_Ins;14;0;Create;True;0;0;0;False;0;False;1.258754;4.62;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-1404.682,-183.3324;Inherit;False;Property;_Main_Pow;Main_Pow;8;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;95;-2101.018,466.3575;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-1408.774,1412.96;Inherit;False;Property;_Dissolve;Dissolve;22;0;Create;True;0;0;0;False;0;False;0;0.83;-1.2;1.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;72;-1251.812,527.2573;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;80;-1807.841,275.8929;Inherit;False;Property;_Emi_Offset;Emi_Offset;15;0;Create;True;0;0;0;False;0;False;0;-0.47;-1.5;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;6;-1545.818,-92.99296;Inherit;True;Property;_Main_Texture;Main_Texture;5;0;Create;True;0;0;0;False;0;False;-1;145143eb93006454baed654b5669d0c3;145143eb93006454baed654b5669d0c3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;-1242.529,1521.82;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;97;-1223.263,1203.057;Inherit;True;Property;_Dissolve_Texture;Dissolve_Texture;26;0;Create;True;0;0;0;False;0;False;-1;None;e3c24bd69ca2d4a42933ef11dbb112c5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;-943.8117,527.2573;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1144.304,-185.3931;Inherit;False;Property;_Main_Ins;Main_Ins;7;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;21;-1226.151,-91.37713;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;106;-842.747,697.7416;Inherit;False;Property;_Edge_Color;Edge_Color;11;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0.7993579,0,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;89;-1532.94,275.6422;Inherit;False;Property;_USE_COSTOM;USE_COSTOM;25;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;60;-1119.947,1522.255;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;78;-1452.943,200.0343;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-1117.947,1592.256;Inherit;False;Constant;_Float0;Float 0;18;0;Create;True;0;0;0;False;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;91;-1132.721,1412.611;Inherit;False;Property;_USE_COSTOM;USE_COSTOM;25;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-907.5853,1036.893;Inherit;False;Property;_Opacity;Opacity;4;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;64;-1053.447,1664.394;Inherit;False;Property;_Mask_Range;Mask_Range;3;0;Create;True;0;0;0;False;0;False;3;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-952.9435,-91.42811;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;46;-885.9882,1270.331;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;-988.9468,1522.255;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;83;-1593.008,420.0277;Inherit;False;Property;_Emi_Ins;Emi_Ins;16;0;Create;True;0;0;0;False;0;False;1;1;1;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;96;-2056.778,627.2742;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;105;-694.5078,551.1868;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;79;-1309.943,200.0343;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;76;-539.4788,285.8947;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-729.5855,881.8933;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;63;-849.8672,1521.942;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;47;-753.648,1321.093;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;90;-1319.176,419.0828;Inherit;False;Property;_USE_COSTOM;USE_COSTOM;25;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;81;-1112.834,199.9913;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;85;-1094.76,322.9321;Inherit;False;Property;_Emi_Color;Emi_Color;17;1;[HDR];Create;True;0;0;0;False;0;False;1,0.03301889,0.03301889,0;7.207932,0.9859908,6.212422,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;82;-987.8344,199.9913;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-594.4462,882.8156;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;107;-256.2945,452.6441;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;65;-626.0694,1522.453;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;-492.9644,-36.92796;Inherit;False;Property;_Main_Color;Main_Color;6;1;[HDR];Create;True;0;0;0;False;0;False;1,0,0,0;0.1625025,0.6656647,1.497848,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;-458.6378,882.9124;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;-855.8638,200.5924;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-198.8605,88.19441;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;67;-323.1756,882.338;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;2;112.2542,174.5683;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;86;-28.82161,117.3177;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;281.3218,363.4301;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;278.3082,88.4455;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;439.8362,42.29194;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;YH/Sword_Picxelize;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;28;0;29;0
WireConnection;28;1;30;0
WireConnection;88;1;54;0
WireConnection;88;0;87;1
WireConnection;27;0;26;1
WireConnection;27;2;28;0
WireConnection;53;0;88;0
WireConnection;53;1;55;0
WireConnection;25;1;27;0
WireConnection;102;0;50;0
WireConnection;102;1;103;0
WireConnection;102;2;104;0
WireConnection;52;0;102;0
WireConnection;52;2;53;0
WireConnection;31;0;25;0
WireConnection;32;0;31;0
WireConnection;32;1;33;0
WireConnection;51;1;52;0
WireConnection;15;0;16;0
WireConnection;15;1;17;0
WireConnection;69;0;51;3
WireConnection;69;1;70;0
WireConnection;36;0;32;0
WireConnection;36;1;37;0
WireConnection;57;0;56;1
WireConnection;38;0;36;0
WireConnection;38;2;15;0
WireConnection;41;0;42;0
WireConnection;41;1;43;0
WireConnection;58;0;57;0
WireConnection;98;0;44;0
WireConnection;98;1;99;0
WireConnection;98;2;101;0
WireConnection;71;0;69;0
WireConnection;40;0;98;0
WireConnection;40;2;41;0
WireConnection;94;0;87;4
WireConnection;77;0;68;1
WireConnection;95;0;87;2
WireConnection;72;0;71;0
WireConnection;72;1;74;0
WireConnection;6;1;38;0
WireConnection;59;0;56;1
WireConnection;59;1;58;0
WireConnection;97;1;40;0
WireConnection;73;0;72;0
WireConnection;73;1;75;0
WireConnection;21;0;6;1
WireConnection;21;1;22;0
WireConnection;89;1;80;0
WireConnection;89;0;95;0
WireConnection;60;0;59;0
WireConnection;78;0;77;0
WireConnection;91;1;45;0
WireConnection;91;0;94;0
WireConnection;19;0;21;0
WireConnection;19;1;20;0
WireConnection;46;0;97;1
WireConnection;46;1;91;0
WireConnection;61;0;60;0
WireConnection;61;1;62;0
WireConnection;96;0;87;3
WireConnection;105;0;73;0
WireConnection;105;1;106;0
WireConnection;79;0;78;0
WireConnection;79;1;89;0
WireConnection;76;0;19;0
WireConnection;76;1;105;0
WireConnection;23;0;51;1
WireConnection;23;1;24;0
WireConnection;63;0;61;0
WireConnection;63;1;64;0
WireConnection;47;0;46;0
WireConnection;90;1;83;0
WireConnection;90;0;96;0
WireConnection;81;0;79;0
WireConnection;82;0;81;0
WireConnection;82;1;90;0
WireConnection;48;0;23;0
WireConnection;48;1;47;0
WireConnection;107;0;76;0
WireConnection;107;1;51;2
WireConnection;65;0;63;0
WireConnection;66;0;48;0
WireConnection;66;1;65;0
WireConnection;84;0;82;0
WireConnection;84;1;85;0
WireConnection;7;0;1;0
WireConnection;7;1;107;0
WireConnection;67;0;66;0
WireConnection;86;0;7;0
WireConnection;86;1;84;0
WireConnection;14;0;2;4
WireConnection;14;1;67;0
WireConnection;3;0;86;0
WireConnection;3;1;2;0
WireConnection;0;2;3;0
WireConnection;0;9;14;0
ASEEND*/
//CHKSM=EDFA22187E60F63EE22A0269982D299DDE75FF79