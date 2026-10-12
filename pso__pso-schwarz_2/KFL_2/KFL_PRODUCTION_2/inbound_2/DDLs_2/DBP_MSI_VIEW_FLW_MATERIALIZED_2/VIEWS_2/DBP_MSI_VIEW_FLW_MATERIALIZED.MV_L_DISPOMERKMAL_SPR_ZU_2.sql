create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_DISPOMERKMAL_SPR_ZU_2(
	MANDANT_ID,
	DISPOMERKMAL,
	SPR_ID,
	DISPOMERKMAL_BEZ
) as
   SELECT

  v01.mandant_id, v01.dispomerkmal, v01.spr_id, v01.dispomerkmal_bez

   FROM dbp_view.v_dispomerkmal_spr_zu_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id;