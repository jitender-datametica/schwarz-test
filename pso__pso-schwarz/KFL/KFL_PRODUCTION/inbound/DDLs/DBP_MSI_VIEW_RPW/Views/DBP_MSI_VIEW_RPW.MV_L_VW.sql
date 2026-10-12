CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_VW
 (
   vw_id
   ,mandant_id
   ,spr_id
   ,vk_id
   ,vw_bez
   ,vwvt_bez
   ,vwart_id
   ,sap_vw_id
   ,system_id
 )
 AS
    SELECT
       vw_id,
    mandant_id,
    spr_id,
    vk_id,
    vw_bez,
    vwvt_bez,
    vwart_id,
    sap_vw_id,
    7
    FROM dbp_view.v_l_vw
    WHERE mandant_id = 1
      AND spr_id = 22
 ;