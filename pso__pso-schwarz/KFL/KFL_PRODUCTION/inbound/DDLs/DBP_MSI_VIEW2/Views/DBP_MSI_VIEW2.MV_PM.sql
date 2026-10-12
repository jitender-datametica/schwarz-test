CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_PM
(
pm_id
,pm_bez
,mandant_id
,spr_id
)
AS
   SELECT
  pm_id, pm_bez, mandant_id, spr_id

   FROM dbp_view.v_pm
   WHERE mandant_id = 1;