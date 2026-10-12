CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_SAISON_SPR_ZU_EN_2
(
mandant_id
,SAISO
,saison_bez
,spr_id
)
AS

   SELECT
   v01.mandant_id, v01.saison_id AS SAISO, COALESCE(MAX(CASE WHEN v01.spr_id = 24 THEN  v01.saison_bez END),
   MAX(CASE WHEN v01.spr_id = 22 THEN  v01.saison_bez END)
   ) AS saison_bez, MAX(v01.spr_id) AS spr_id
   FROM dbp_view.v_saison_spr_zu_2 v01

   WHERE v01.spr_id IN (22,24) -- deutsch, englisch

   GROUP BY  v01.mandant_id
   ,v01.saison_id;