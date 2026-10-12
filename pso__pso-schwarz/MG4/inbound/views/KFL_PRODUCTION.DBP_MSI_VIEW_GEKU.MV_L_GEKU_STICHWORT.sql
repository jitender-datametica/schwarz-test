create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_L_GEKU_STICHWORT(
	GEKU_STICHWORT_UID
) as
--17.09.2013 twie: Anlage Lookup Stichwort

   SELECT
   geku_stichwort_uid
   FROM dbp_view.v_l_geku_stichwort;