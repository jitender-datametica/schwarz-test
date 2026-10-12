create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_FLW_KALK_PLAN_SPR_ZU(
	MANDANT_ID,
	PLAN_KALK_ID,
	SPR_ID,
	PLAN_KALK_BEZ
) as
   SELECT
   v01.mandant_id, v01.plan_kalk_id, v01.spr_id, v01.plan_kalk_bez

   FROM dbp_view.v_flw_kalk_plan_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id;