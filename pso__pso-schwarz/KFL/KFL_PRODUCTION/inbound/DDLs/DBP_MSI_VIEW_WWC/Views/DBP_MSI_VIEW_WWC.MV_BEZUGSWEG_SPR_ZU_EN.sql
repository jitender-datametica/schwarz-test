CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_BEZUGSWEG_SPR_ZU_EN
(
mandant_id
,BWSCL
,spr_id
,bezugsweg_bez
)
AS
   SELECT
   mandant_id, bezugsweg_id AS BWSCL, MAX(spr_id) AS spr_id, COALESCE(MAX(CASE WHEN spr_id = 24 THEN  bezugsweg_bez END),
   MAX(CASE WHEN spr_id = 22 THEN  bezugsweg_bez END)
   ) AS bezugsweg_bez
   FROM dbp_view.v_bezugsweg_spr_zu
   WHERE spr_id IN (22,24) -- deutsch, englisch
   AND mandant_id <> 1
   GROUP BY mandant_id
   ,bezugsweg_id
;