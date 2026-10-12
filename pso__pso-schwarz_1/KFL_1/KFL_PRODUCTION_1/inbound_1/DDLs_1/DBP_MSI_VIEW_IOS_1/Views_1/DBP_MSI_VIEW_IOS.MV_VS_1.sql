CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_VS_1
(
vs_id
,vs_bez
,vk_id
,mandant_id
,vsvt_bez
)
AS
   SELECT
  vs_id, vs_bez, vk_id, mandant_id, vsvt_bez
   FROM dbp_view.v_vs_1;