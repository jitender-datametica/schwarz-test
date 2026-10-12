CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_BELEGART_SPR_ZU_EN_1
(

mandant_id
,system_id
,spr_id
,BLART
,belegart_bez
)
AS
   SELECT
   v01.mandant_id, v01.system_id, MAX(v01.spr_id) AS spr_id, v01.belegart_id AS BLART, COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN  v01.belegart_bez END),
   MAX(CASE WHEN v01.spr_id = 22 THEN  v01.belegart_bez END)
   ) AS belegart_bez

   FROM dbp_view.v_belegart_spr_zu_1 v01
   WHERE v01.spr_id IN (22,24) -- deutsch, englisch

   GROUP BY v01.mandant_id
   ,v01.system_id
   ,v01.belegart_id
;