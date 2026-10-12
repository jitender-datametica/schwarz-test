CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_VKL_1
(
gf_id,
mandant_id,
vkl_id,
vkl_name
)
AS
   SELECT
  gf_id,
   mandant_id,
   vkl_id,
   vkl_name
   FROM dbp_view.v_vkl_1;