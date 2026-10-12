CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_DISPOMERKMAL_SPR_ZU_EN
(
mandant_id
,DISMM
,spr_id
,DIBEZ
)
AS
   SELECT
   mandant_id, dispomerkmal AS DISMM, MAX(spr_id) AS spr_id, COALESCE(MAX(CASE WHEN spr_id = 24 THEN  dispomerkmal_bez END),
   MAX(CASE WHEN spr_id = 22 THEN  dispomerkmal_bez END)
   ) AS DIBEZ
   FROM dbp_view.v_dispomerkmal_spr_zu
   WHERE spr_id IN (22,24) -- deutsch, englisch
   AND mandant_id <> 1
   GROUP BY mandant_id
   ,dispomerkmal
;