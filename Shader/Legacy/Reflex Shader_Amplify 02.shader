// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ReflexShader/ReflexShader_Amplify 02"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Diffuse("Diffuse", 2D) = "black" {}
		_DiffuseColor("Diffuse Color", Color) = (1,1,1,0)
		_Emission("Emission", 2D) = "black" {}
		_EmissionColor("Emission Color", Color) = (1,1,1,0)
		_Normal("Normal", 2D) = "bump" {}
		[Toggle]_MatCapToggle("MatCap Toggle", Float) = 1
		_Matcap("Matcap", 2D) = "black" {}
		_MatCapColor("MatCap Color", Color) = (1,1,1,0)
		[Toggle]_MatCapShadowToggle("MatCap Shadow Toggle", Float) = 1
		_MatCapShadow("MatCap Shadow", 2D) = "white" {}
		_MatCapShadowColor("MatCap Shadow Color", Color) = (0.1960784,0.1960784,0.1960784,0)
		[Toggle]_RimLightToggle("RimLight Toggle", Float) = 1
		_RimLightColor("RimLight Color", Color) = (1,1,1,0)
		_RimLightScale("RimLight Scale", Range( 0 , 20)) = 1
		_RimLightMask("RimLight Mask", 2D) = "white" {}
		[Toggle]_MatCapMaskToggle("MatCap Mask Toggle", Float) = 1
		_MatCapMask("MatCap Mask", 2D) = "black" {}
		[Toggle]_DisableOpacityCutout("Disable Opacity Cutout", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Off
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			INTERNAL_DATA
			float3 worldNormal;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform sampler2D _Emission;
		uniform float4 _Emission_ST;
		uniform float4 _EmissionColor;
		uniform float _DisableOpacityCutout;
		uniform sampler2D _Diffuse;
		uniform float4 _Diffuse_ST;
		uniform float _RimLightToggle;
		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform float _RimLightScale;
		uniform float4 _RimLightColor;
		uniform sampler2D _RimLightMask;
		uniform float4 _RimLightMask_ST;
		uniform float _MatCapToggle;
		uniform sampler2D _Matcap;
		uniform float4 _MatCapColor;
		uniform float _MatCapMaskToggle;
		uniform sampler2D _MatCapMask;
		uniform float4 _MatCapMask_ST;
		uniform float4 _DiffuseColor;
		uniform float _MatCapShadowToggle;
		uniform sampler2D _MatCapShadow;
		uniform float4 _MatCapShadowColor;
		uniform float _Cutoff = 0.5;


		float3 Function_ShadeSH9( float3 normal )
		{
			return ShadeSH9(half4(normal, 1.0));
		}


		float3 CubemapReflections6( float3 reflVect )
		{
			float4 val = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflVect, 7);
			float3 reflCol = DecodeHDR(val, unity_SpecCube0_HDR);
			return reflCol * 0.02;
		}


		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef UNITY_PASS_FORWARDBASE
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			#if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
			half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
			float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
			float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
			ase_lightAtten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
			#endif
			float2 uv_Diffuse = i.uv_texcoord * _Diffuse_ST.xy + _Diffuse_ST.zw;
			float4 tex2DNode13 = tex2D( _Diffuse, uv_Diffuse );
			float4 temp_cast_1 = (0.0).xxxx;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			float4 tex2DNode74 = tex2D( _Normal, uv_Normal );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV48 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode48 = ( 0.0 + _RimLightScale * pow( 1.0 - fresnelNdotV48, 5.0 ) );
			float4 temp_cast_3 = (0.0).xxxx;
			float2 uv_RimLightMask = i.uv_texcoord * _RimLightMask_ST.xy + _RimLightMask_ST.zw;
			float4 lerpResult70 = lerp( ( fresnelNode48 * _RimLightColor ) , temp_cast_3 , ( 1.0 - tex2D( _RimLightMask, uv_RimLightMask ) ).r);
			float4 temp_cast_5 = (0.0).xxxx;
			float4 blendOpSrc77 = tex2DNode74;
			float4 blendOpDest77 = float4( mul( UNITY_MATRIX_V, float4( ase_worldNormal , 0.0 ) ).xyz , 0.0 );
			float4 temp_output_33_0 = ( 0.5 + ( 0.5 * ((( blendOpDest77 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest77 - 0.5 ) ) * ( 1.0 - blendOpSrc77 ) ) : ( 2.0 * blendOpDest77 * blendOpSrc77 ) )).rgba ) );
			float4 blendOpSrc44 = lerp(temp_cast_5,tex2D( _Matcap, temp_output_33_0.rg ),_MatCapToggle);
			float4 blendOpDest44 = _MatCapColor;
			float4 temp_cast_10 = (0.0).xxxx;
			float4 temp_cast_11 = (0.0).xxxx;
			float2 uv_MatCapMask = i.uv_texcoord * _MatCapMask_ST.xy + _MatCapMask_ST.zw;
			float4 tex2DNode69 = tex2D( _MatCapMask, uv_MatCapMask );
			float4 lerpResult67 = lerp( ( saturate( ( blendOpSrc44 * blendOpDest44 ) )) , temp_cast_10 , lerp(temp_cast_11,( 1.0 - tex2DNode69 ),_MatCapMaskToggle).r);
			float4 temp_cast_13 = (0.0).xxxx;
			float4 lerpResult79 = lerp( ( tex2DNode13 * _DiffuseColor ) , temp_cast_13 , tex2DNode69.r);
			float4 temp_cast_15 = (1.0).xxxx;
			float4 blendOpSrc47 = lerp(temp_cast_15,tex2D( _MatCapShadow, temp_output_33_0.rg ),_MatCapShadowToggle);
			float4 blendOpDest47 = _MatCapShadowColor;
			float3 normal5 = float3(0,1,0);
			float3 localFunction_ShadeSH95 = Function_ShadeSH9( normal5 );
			float4 transform23 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float4 normalizeResult7 = normalize( ( float4( _WorldSpaceCameraPos , 0.0 ) - transform23 ) );
			float3 reflVect6 = normalizeResult7.xyz;
			float3 localCubemapReflections6 = CubemapReflections6( reflVect6 );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 clampResult26 = clamp( ( localFunction_ShadeSH95 + localCubemapReflections6 + ( ase_lightAtten * ase_lightColor.rgb ) ) , float3( 0,0,0 ) , float3( 1,1,1 ) );
			c.rgb = ( ( lerp(temp_cast_1,lerpResult70,_RimLightToggle) + lerpResult67 + lerpResult79 ) * ( saturate( ( blendOpSrc47 + blendOpDest47 ) )) * float4( clampResult26 , 0.0 ) ).rgb;
			c.a = 1;
			clip( lerp(tex2DNode13.a,1.0,_DisableOpacityCutout) - _Cutoff );
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			o.Emission = ( tex2D( _Emission, uv_Emission ) * _EmissionColor ).rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows noshadow exclude_path:deferred 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT( UnityGI, gi );
				o.Alpha = LightingStandardCustomLighting( o, worldViewDir, gi ).a;
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15401
0;518;1534;500;5363.716;1845.774;6.443602;True;False
Node;AmplifyShaderEditor.ViewMatrixNode;27;-1698.609,-755.0521;Float;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.WorldNormalVector;28;-1739.509,-640.223;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-1499.871,-676.3046;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;74;-2021.963,-927.5196;Float;True;Property;_Normal;Normal;5;0;Create;True;0;0;False;0;None;db00715d753db754ab0d027218e8de41;True;0;True;bump;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;77;-1314.943,-705.1626;Float;False;Overlay;False;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-1033.514,-842.9809;Float;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;30;-1047.015,-708.812;Float;False;True;True;True;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-796.5358,-728.801;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;33;-623.9456,-783.2463;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;81;-1059.776,-1340.517;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceCameraPos;24;483.6478,307.2328;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;80;-907.7506,-1109.421;Float;False;Property;_RimLightScale;RimLight Scale;14;0;Create;True;0;0;False;0;1;3;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;23;528.6767,475.5711;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;8;826.4625,373.847;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;72;-37.44014,-1141.639;Float;True;Property;_RimLightMask;RimLight Mask;15;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;69;284.5432,-531.2123;Float;True;Property;_MatCapMask;MatCap Mask;17;0;Create;True;0;0;False;0;None;c1a027060e0c06640a8f17097569ba7d;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;48;-562.5601,-1269.218;Float;False;Standard;TangentNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;34;-449.5687,-791.725;Float;True;Property;_Matcap;Matcap;7;0;Create;True;0;0;False;0;None;2c399b25f24769843b1110cf5fb9e53e;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;52;-344.3295,-1134.976;Float;False;Property;_RimLightColor;RimLight Color;13;0;Create;True;0;0;False;0;1,1,1,0;0.3676468,0.4243406,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;37;-320.605,-886.7936;Float;False;Constant;_Float1;Float 1;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;71;143.6331,-1228.988;Float;False;Constant;_Float5;Float 5;13;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;13;101.8535,-121.5731;Float;True;Property;_Diffuse;Diffuse;1;0;Create;True;0;0;False;0;None;59690daf8b41f034a86dfe80a05b4599;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;73;282.5685,-1143.266;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-27.41248,-1274.354;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightColorNode;16;970.1035,613.7318;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.NormalizeNode;7;1012.463,376.847;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ToggleSwitchNode;36;-43.24121,-717.2181;Float;False;Property;_MatCapToggle;MatCap Toggle;6;0;Create;True;0;0;False;0;1;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;93;419.8418,-198.9246;Float;False;Property;_DiffuseColor;Diffuse Color;2;0;Create;True;0;0;False;0;1,1,1,0;0.8156863,0.8705882,0.8745098,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;89;692.7901,-686.194;Float;False;Constant;_Float6;Float 6;17;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;78;679.5937,-606.6185;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;45;-34.01346,-600.0623;Float;False;Property;_MatCapColor;MatCap Color;8;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;4;848.7707,195.2885;Float;False;Constant;_Vector0;Vector 0;1;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LightAttenuation;15;943.689,519.0786;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;44;237.4265,-685.9493;Float;False;Multiply;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CustomExpressionNode;5;1073.381,202.3874;Float;False;return ShadeSH9(half4(normal, 1.0))@$;3;False;1;True;normal;FLOAT3;0,0,0;In;;Function_ShadeSH9;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;70;468.4327,-1281.879;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-315.0429,-573.5999;Float;False;Constant;_Float2;Float 2;5;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;474.0959,-1371.444;Float;False;Constant;_Float3;Float 3;10;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;39;-452.6353,-484.8851;Float;True;Property;_MatCapShadow;MatCap Shadow;10;0;Create;True;0;0;False;0;9550f7b83cc8802409435064904c9129;524e7d4ee9b105f4d89a395aaf6dabec;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;92;741.2592,-308.7112;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;68;456.3132,-611.0014;Float;False;Constant;_Float4;Float 4;12;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;88;928.7888,-624.2038;Float;False;Property;_MatCapMaskToggle;MatCap Mask Toggle;16;0;Create;True;0;0;False;0;1;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CustomExpressionNode;6;1179.463,374.8472;Float;False;float4 val = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, reflVect, 7)@$float3 reflCol = DecodeHDR(val, unity_SpecCube0_HDR)@$return reflCol * 0.02@;3;False;1;True;reflVect;FLOAT3;0,0,0;In;;Cubemap Reflections;True;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;1236.454,538.8895;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;67;1192.15,-677.1347;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;62;885.4397,-1311.547;Float;False;Property;_RimLightToggle;RimLight Toggle;12;0;Create;True;0;0;False;0;1;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;46;-31.62536,-296.4366;Float;False;Property;_MatCapShadowColor;MatCap Shadow Color;11;0;Create;True;0;0;False;0;0.1960784,0.1960784,0.1960784,0;0.5607843,0.2784311,0.3215683,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;79;925.1157,-377.0896;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;12;1465.725,355.1572;Float;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;40;-36.67926,-404.0242;Float;False;Property;_MatCapShadowToggle;MatCap Shadow Toggle;9;0;Create;True;0;0;False;0;1;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;85;545.6794,30.15043;Float;False;Constant;_Float7;Float 7;17;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;26;1634.431,357.8116;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;35;1519.78,-588.2934;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;47;276.0024,-322.7519;Float;False;LinearDodge;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;22;1712.103,-644.8495;Float;True;Property;_Emission;Emission;3;0;Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;95;1737.266,-416.0302;Float;False;Property;_EmissionColor;Emission Color;4;0;Create;True;0;0;False;0;1,1,1,0;0.8392157,0.8392157,0.8392157,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;2086.092,-88.24368;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;84;746.6127,-4.880692;Float;False;Property;_DisableOpacityCutout;Disable Opacity Cutout;18;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;2102.718,-491.5933;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;65;2331.572,-320.984;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;ReflexShader/ReflexShader_Amplify 02;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;False;0.0001;0.2463776,0.3602941,0.3478668,1;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;29;0;27;0
WireConnection;29;1;28;0
WireConnection;77;0;74;0
WireConnection;77;1;29;0
WireConnection;30;0;77;0
WireConnection;32;0;31;0
WireConnection;32;1;30;0
WireConnection;33;0;31;0
WireConnection;33;1;32;0
WireConnection;8;0;24;0
WireConnection;8;1;23;0
WireConnection;48;0;74;0
WireConnection;48;4;81;0
WireConnection;48;2;80;0
WireConnection;34;1;33;0
WireConnection;73;0;72;0
WireConnection;51;0;48;0
WireConnection;51;1;52;0
WireConnection;7;0;8;0
WireConnection;36;0;37;0
WireConnection;36;1;34;0
WireConnection;78;0;69;0
WireConnection;44;0;36;0
WireConnection;44;1;45;0
WireConnection;5;0;4;0
WireConnection;70;0;51;0
WireConnection;70;1;71;0
WireConnection;70;2;73;0
WireConnection;39;1;33;0
WireConnection;92;0;13;0
WireConnection;92;1;93;0
WireConnection;88;0;89;0
WireConnection;88;1;78;0
WireConnection;6;0;7;0
WireConnection;17;0;15;0
WireConnection;17;1;16;1
WireConnection;67;0;44;0
WireConnection;67;1;68;0
WireConnection;67;2;88;0
WireConnection;62;0;63;0
WireConnection;62;1;70;0
WireConnection;79;0;92;0
WireConnection;79;1;68;0
WireConnection;79;2;69;0
WireConnection;12;0;5;0
WireConnection;12;1;6;0
WireConnection;12;2;17;0
WireConnection;40;0;38;0
WireConnection;40;1;39;0
WireConnection;26;0;12;0
WireConnection;35;0;62;0
WireConnection;35;1;67;0
WireConnection;35;2;79;0
WireConnection;47;0;40;0
WireConnection;47;1;46;0
WireConnection;41;0;35;0
WireConnection;41;1;47;0
WireConnection;41;2;26;0
WireConnection;84;0;13;4
WireConnection;84;1;85;0
WireConnection;94;0;22;0
WireConnection;94;1;95;0
WireConnection;65;2;94;0
WireConnection;65;10;84;0
WireConnection;65;13;41;0
ASEEND*/
//CHKSM=4803893D7EF9197E506D59C4F57CB0D29D5FC96F