Shader "ShaderProjects/QuantizedToonShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _BaseVal ("Base Val", float) = 0.1
    }
    SubShader
    {
        Tags {"LightMode" = "ForwardBase"}  

        Pass
        {
            HLSLPROGRAM

            #pragma vertex vertex
            #pragma fragment pixel

            #include "UnityCG.cginc"

            struct app2Vert
            {
                float4 positionOS : POSITION;
                float2 uv : TEXCOORD0;
                float3 normalOS : NORMAL;
            };

            struct vert2Pixel
            {
                float2 uv : TEXCOORD0;
                float4 sv : SV_POSITION;
                float3 positionWS : TEXCOORD1;
                float3 normalWS : TEXCOORD2;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            float _BaseVal;

            float4 _LightColor0;

            vert2Pixel vertex (app2Vert input)
            {
                vert2Pixel output;
               
                float4 positionWS = mul(unity_ObjectToWorld, float4(input.positionOS.xyz, 1));
                float4 positionSV = mul(unity_MatrixVP, positionWS);
                float3 normalWS = normalize(mul(input.normalOS, (float3x3)unity_WorldToObject));

                output.sv = positionSV;
                output.uv = TRANSFORM_TEX(input.uv, _MainTex);
                output.positionWS = positionWS.xyz;
                output.normalWS = normalWS;
    
                return output;
            }

            float quantizeVal(float x, float baseVal)
            {
                if (x % baseVal != 0) 
                {
                    float mod = x % baseVal;
                    return (mod < (baseVal - 0.5)) ? x - mod : (x - mod) + baseVal;
                }

                return x;
            }

            float4 pixel (vert2Pixel input) : COLOR
            {
                float3 lightDir = _WorldSpaceLightPos0.xyz - input.positionWS * _WorldSpaceLightPos0.w;
                float3 lightDirNormalized = normalize(lightDir);

                float3 normal = normalize(input.normalWS);

                float nDotl = dot(normal, lightDirNormalized);

                float3 QLC = _LightColor0.rgb * quantizeVal(nDotl, _BaseVal);

                float4 col = tex2D(_MainTex, input.uv);
                float3 output = col.rgb * QLC;

                return float4(output, 1);
            }
            
            ENDHLSL
        }
    }
}
