create or replace view DBP_MSI_VIEW_IMS_MATERIALIZED.MV_MANDANT(
	MANDANT_ID,
	MANDANT_BEZ,
	MANDANT_KBEZ,
	WRG_ID,
	MANDANT_SORT_ID
) as




   SELECT
   mandant_id,
   mandant_bez,
   mandant_kbez,
   CASE
  
  WHEN v04.wrg_typ_id = 1 THEN default_wrg
  ELSE 'EUR'
  END wrg_id,
   mandant_sort_id

   FROM dbp_view.v_mandant
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v04;