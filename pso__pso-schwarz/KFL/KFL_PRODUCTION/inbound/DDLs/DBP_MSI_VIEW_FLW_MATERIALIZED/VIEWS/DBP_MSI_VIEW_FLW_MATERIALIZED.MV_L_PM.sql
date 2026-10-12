create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_PM(
	PM_ID,
	PM_BEZ,
	MANDANT_ID,
	SPR_ID
) as
   SELECT
  v01.pm_id, v01.pm_bez, v01.mandant_id, v01.spr_id

   FROM dbp_view.v_pm v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id

   WHERE v01.mandant_id IN (1,2);