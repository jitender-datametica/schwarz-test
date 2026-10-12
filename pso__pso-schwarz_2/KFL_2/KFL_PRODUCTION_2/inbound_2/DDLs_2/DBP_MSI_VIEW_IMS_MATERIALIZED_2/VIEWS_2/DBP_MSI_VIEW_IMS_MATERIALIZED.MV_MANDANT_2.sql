create or replace view DBP_MSI_VIEW_IMS_MATERIALIZED.MV_MANDANT_2(
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

   FROM dbp_view.v_mandant_2
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v04;