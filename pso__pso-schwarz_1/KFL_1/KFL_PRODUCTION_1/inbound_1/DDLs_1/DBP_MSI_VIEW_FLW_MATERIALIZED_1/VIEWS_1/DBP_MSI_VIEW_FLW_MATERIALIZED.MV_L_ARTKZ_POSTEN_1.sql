create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_ARTKZ_POSTEN_1(
	POSTEN_ID,
	POSTEN_BEZ,
	MANDANT_ID
) as

   SELECT

  posten_id, posten_bez, mandant_id

   FROM dbp_view.v_artkz_posten_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02

   ON v01.spr_id = v02.spr_id

   WHERE (posten_id IN ('PN', '')

   AND mandant_id = 1)

   OR

   (posten_id IN ('0','1')

   AND mandant_id = 2);