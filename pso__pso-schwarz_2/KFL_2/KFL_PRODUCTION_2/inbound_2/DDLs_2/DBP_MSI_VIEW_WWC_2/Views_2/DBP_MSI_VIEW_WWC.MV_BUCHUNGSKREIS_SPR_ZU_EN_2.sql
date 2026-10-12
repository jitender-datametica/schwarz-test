CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_BUCHUNGSKREIS_SPR_ZU_EN_2
(
mandant_id
,BUKRS
,buchungskreis_bez
,spr_id
)
AS
   SELECT
   v01.mandant_id, v01.buchungskreis_id AS BUKRS, COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN  v01.buchungskreis_bez END),
   MAX(CASE WHEN v01.spr_id = 22 THEN  v01.buchungskreis_bez END)
   ) AS buchungskreis_bez, MAX(v01.spr_id) AS spr_id
   FROM dbp_view.v_buchungskreis_spr_zu_2 v01

   WHERE v01.spr_id IN (22,24) -- deutsch, englisch

   GROUP BY v01.mandant_id
   ,v01.buchungskreis_id;