CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ARTIKELART_SPR_ZU_BG_1
(
mandant_id
,MTART
,spr_id
,artikelart_bez
)
AS
   SELECT
   v01.mandant_id, v01.artikelart_id  AS MTART, v01.spr_id, v01.artikelart_bez
   FROM dbp_view.v_artikelart_spr_zu_1 v01
   WHERE spr_id = 18
;