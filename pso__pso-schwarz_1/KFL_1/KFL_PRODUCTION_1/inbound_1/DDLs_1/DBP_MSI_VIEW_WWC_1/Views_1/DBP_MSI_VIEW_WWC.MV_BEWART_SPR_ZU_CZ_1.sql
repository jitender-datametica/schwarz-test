CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_BEWART_SPR_ZU_CZ_1
(
mandant_id
,BWART
,lager_bewart_bez
,spr_id
)
AS
   SELECT
   v01.mandant_id, v01.lager_bewart_id AS BWART, v01.lager_bewart_bez, v01.spr_id

   FROM dbp_view.v_lager_bewart_spr_zu_1 v01
   where spr_id = 124
;