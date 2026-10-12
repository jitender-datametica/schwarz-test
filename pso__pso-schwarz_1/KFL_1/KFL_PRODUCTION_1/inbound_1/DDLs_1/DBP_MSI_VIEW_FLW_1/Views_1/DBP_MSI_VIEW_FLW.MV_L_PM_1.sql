CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_PM_1
--11.06.2014 twie: Filter um Mdt 2 erweitert
(
pm_id
,pm_bez
,mandant_id
,spr_id
)
AS
   SELECT
  v01.pm_id, v01.pm_bez, v01.mandant_id, v01.spr_id

   FROM dbp_view.v_pm_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id

   WHERE v01.mandant_id IN (1,2);