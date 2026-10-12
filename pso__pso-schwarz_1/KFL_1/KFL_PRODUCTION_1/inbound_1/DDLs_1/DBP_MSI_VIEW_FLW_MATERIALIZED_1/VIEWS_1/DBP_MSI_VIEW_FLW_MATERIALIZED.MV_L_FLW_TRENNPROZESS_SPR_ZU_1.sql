create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_FLW_TRENNPROZESS_SPR_ZU_1(
	TRENNPROZESS_ID,
	TRENNPROZESS_BEZ
) as

   SELECT


   trennprozess_id, trennprozess_bez

   FROM dbp_view.v_flw_trennprozess_spr_zu_1   v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id
   GROUP BY
   trennprozess_id
   ,trennprozess_bez;