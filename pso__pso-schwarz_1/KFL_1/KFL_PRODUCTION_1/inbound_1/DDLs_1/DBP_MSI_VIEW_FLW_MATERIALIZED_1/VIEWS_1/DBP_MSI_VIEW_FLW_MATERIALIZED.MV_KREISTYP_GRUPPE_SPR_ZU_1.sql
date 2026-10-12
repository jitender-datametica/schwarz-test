create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_KREISTYP_GRUPPE_SPR_ZU_1(
	MANDANT_ID,
	KREISTYP_GRUPPE_ID,
	KREISTYP_GRUPPE_BEZ
) as
   SELECT

   mandant_id, kreistyp_gruppe_id, kreistyp_gruppe_bez

   FROM dbp_view.v_kreistyp_gruppe_spr_zu_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id

   WHERE mandant_id in (1,2)

   UNION ALL

   SELECT
   mandant_id, '-1' as kreistyp_gruppe_id, '-' as kreistyp_gruppe_bez
   FROM dbp_view.v_mandant_1
   where mandant_id in (1,2);