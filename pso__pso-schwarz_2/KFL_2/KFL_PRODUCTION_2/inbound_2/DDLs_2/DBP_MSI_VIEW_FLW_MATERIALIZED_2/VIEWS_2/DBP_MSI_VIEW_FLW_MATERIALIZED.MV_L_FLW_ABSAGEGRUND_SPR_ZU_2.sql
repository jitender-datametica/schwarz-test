create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_FLW_ABSAGEGRUND_SPR_ZU_2(
	MANDANT_ID,
	ABSAGEGRUND_ID,
	ABSAGEGRUND_BEZ
) as
   SELECT

   v01.mandant_id, v01.absagegrund_id, v01.absagegrund_bez

   FROM dbp_view.v_flw_absagegrund_spr_zu_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id

   UNION

   SELECT

   v02.mandant_id, '-1' AS absagegrund_id, '' AS absagegrund_bez

   FROM dbp_view.v_mandant_2 v02
   WHERE v02.mandant_id IN (1,2);