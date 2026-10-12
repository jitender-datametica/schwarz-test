CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_PM_1
-- AP0032822, SPEC0041631 - 26.10.2108, mkub1811 neue View
(
pm_id
,pm_bez
,mandant_id
,spr_id
)
AS
   SELECT
   pm_id, pm_bez, mandant_id, spr_id
   FROM dbp_view.v_pm_1
   WHERE mandant_id=1;