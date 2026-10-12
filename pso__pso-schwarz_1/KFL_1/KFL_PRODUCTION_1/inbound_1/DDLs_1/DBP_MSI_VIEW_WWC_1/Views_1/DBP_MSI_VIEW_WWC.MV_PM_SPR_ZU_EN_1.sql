CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_PM_SPR_ZU_EN_1
-- AP0032822, SPEC0041631 - 29.10.2108, mkub1811 neue View
(
pm_id
,pm_bez
,mandant_id
,spr_id
)
AS
   SELECT
   pm_id, COALESCE(MAX(CASE WHEN spr_id = 24 THEN  pm_bez END),
   MAX(CASE WHEN spr_id = 22 THEN pm_bez END)
   ) AS pm_bez, mandant_id, spr_id
   FROM dbp_view.v_pm_1
   WHERE spr_id IN (22,24)
   GROUP BY
   mandant_id
   ,pm_id
   ,spr_id;