create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_ARTKZ_DISCOUNT(
	DISCOUNT_ID,
	DISCOUNT_BEZ,
	MANDANT_ID
) as
   SELECT
   v01.discount_id,
   v01.discount_bez,
   v01.mandant_id

   FROM dbp_view.v_artkz_discount v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id

   WHERE v01.mandant_id = 1


   UNION ALL


   SELECT
   0 AS discount_id,
   '' AS discount_bez,
   mandant_id

   FROM dbp_view.v_mandant

   WHERE mandant_id = 2;