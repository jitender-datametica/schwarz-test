create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_MONAT_VORMONAT_TRN_2(
	KJMO,
	GJMO,
	GJMO_VMO,
	GJMO_VVMO,
	GJMO_VVVMO,
	GJMO_VVVVMO,
	KJMO_VMO,
	KJMO_VVMO,
	KJMO_VVVMO,
	KJMO_VVVVMO
) as
   SELECT
   kjmo
   , gjmo
   , MIN (gjmo) OVER (ORDER BY gjmo ASC ROWS 1 PRECEDING) AS gjmo_vmo
   , MIN (gjmo) OVER (ORDER BY gjmo ASC ROWS 2 PRECEDING) AS gjmo_vvmo
   , MIN (gjmo) OVER (ORDER BY gjmo ASC ROWS 3 PRECEDING) AS gjmo_vvvmo
   , MIN (gjmo) OVER (ORDER BY gjmo ASC ROWS 4 PRECEDING) AS gjmo_vvvvmo
   , MIN (kjmo) OVER (ORDER BY kjmo ASC ROWS 1 PRECEDING) AS kjmo_vmo
   , MIN (kjmo) OVER (ORDER BY kjmo ASC ROWS 2 PRECEDING) AS kjmo_vvmo
   , MIN (kjmo) OVER (ORDER BY kjmo ASC ROWS 3 PRECEDING) AS kjmo_vvvmo
   , MIN (kjmo) OVER (ORDER BY kjmo ASC ROWS 4 PRECEDING) AS kjmo_vvvvmo
   FROM dbp_view.v_monat_2
   WHERE kjmo>=200201;