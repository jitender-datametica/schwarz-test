CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_LOHNART_SPR_ZU_BG
(
mandant_id
,lohnart_id
,spr_id
,lohnart_bez
)
AS
   SELECT
   v01.mandant_id, v01.lohnart_id, v01.spr_id, v01.lohnart_bez

   FROM dbp_view.v_lohnart_spr_zu v01
   WHERE spr_id = 18;