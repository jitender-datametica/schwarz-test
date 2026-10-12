CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_L_VW_1
(
vw_id
,mandant_id
,spr_id
,vk_id
,vw_bez
,vwvt_bez
,vwart_id
,sap_vw_id
)
AS
   SELECT
  vw_id, mandant_id, spr_id, vk_id, vw_bez, vwvt_bez, vwart_id, sap_vw_id
   FROM dbp_view.v_l_vw_1;