CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_VS
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
   FROM dbp_view.v_vs;