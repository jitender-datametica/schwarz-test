CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_VS
(
vs_id
,vs_bez
,vk_id
,mandant_id
,vsvt_bez
)
AS
   SELECT v01.vs_id, v01.vs_bez, v01.vk_id, v01.mandant_id, v01.vsvt_bez
   FROM dbp_view.v_vs v01
;