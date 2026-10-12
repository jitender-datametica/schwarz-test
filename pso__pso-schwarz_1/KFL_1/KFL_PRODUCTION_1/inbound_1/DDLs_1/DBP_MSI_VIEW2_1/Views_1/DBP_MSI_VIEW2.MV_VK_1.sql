CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_VK_1 (vk_id ,vk_bez ,mandant_id)
AS
   SELECT vk_id, vk_bez, mandant_id from dbp_view.v_vk_1 where mandant_id=1and vk_id NOT IN (0);