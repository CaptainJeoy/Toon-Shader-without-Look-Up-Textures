Shader "ShaderProjects/TexturedColour"
{
    Properties
    {
        _BaseTex ("Base (RGB)", 2D) = "white" {}
    }

    SubShader
    {
        Pass
        {
            HLSLPROGRAM

            #pragma vertex texturedVert
            #pragma fragment texturedFrag

            #include "UnityCG.cginc"

            sampler2D _BaseTex;
            float4 _BaseTex_ST;

            struct app2Vert
            {
                float4 positionOS:POSITION;
                float2 uv:TEXCOORD0;
            };

            struct vert2Frag
            {
                float4 sv:SV_POSITION;
                float2 uv:TEXCOORD0;
            };

            vert2Frag texturedVert(app2Vert input)
            {
                vert2Frag outPut;

                float4 positionWS = mul(unity_ObjectToWorld, input.positionOS);
                outPut.sv = mul(unity_MatrixVP, positionWS);
                outPut.uv =  TRANSFORM_TEX(input.uv, _BaseTex);

                return outPut;
            }

            float4 texturedFrag(vert2Frag input) : COLOR
            {
                return(tex2D(_BaseTex, input.uv));
            }

            ENDHLSL
        }
    }
}