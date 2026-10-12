CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_VW_1
(vw_id, vw_bez, vk_id, mandant_id,vwvt_bez)
AS
   SELECT
  vw_id, vw_bez, vk_id, mandant_id, vwvt_bez
   FROM dbp_view.v_l_vw_1;