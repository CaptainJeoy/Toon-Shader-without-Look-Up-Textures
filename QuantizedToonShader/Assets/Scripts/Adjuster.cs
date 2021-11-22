using UnityEngine;
using UnityEngine.UI;

public class Adjuster : MonoBehaviour
{
    [SerializeField] private Slider sliderLUT;
   
    private MeshRenderer meshRenderer;

    private Material mat;

    private void Start()
    {
        meshRenderer = GetComponent<MeshRenderer>();
        mat = meshRenderer.material;
    }

    private void Update()
    {
        mat.SetFloat("_BaseVal", sliderLUT.value);
    }
}
