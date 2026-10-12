create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_MONAT_SPR_ZU_1(
	MO_GJ,
	MO_BEZ
) as
   SELECT
   CASE WHEN mo_id >= 3 THEN mo_id -2 ELSE mo_id + 10 END AS mo_gj, mo_bez

   FROM dbp_view.v_monat_spr_zu_1  v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id;