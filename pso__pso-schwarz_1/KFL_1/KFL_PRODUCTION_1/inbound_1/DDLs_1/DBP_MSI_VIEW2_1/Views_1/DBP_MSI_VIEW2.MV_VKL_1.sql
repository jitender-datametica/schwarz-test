CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_VKL_1 (vkl_id,gf_id,vkl_name,mandant_id)
AS
   SELECT vkl_id, gf_id, vkl_name, mandant_id from dbp_view.v_vkl_1 where mandant_id=1;