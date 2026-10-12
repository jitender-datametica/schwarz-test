create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_WOCHE_VORWOCHE_TRN_2(
	KJWO,
	GJWO,
	GJWO_VWO,
	GJWO_VVWO,
	GJWO_VVVWO,
	GJWO_VVVVWO,
	KJWO_VWO,
	KJWO_VVWO,
	KJWO_VVVWO,
	KJWO_VVVVWO
) as
   SELECT
   kjwo
   , gjwo
   , MIN (gjwo) OVER (ORDER BY gjwo ASC ROWS 1 PRECEDING) AS gjwo_vwo
   , MIN (gjwo) OVER (ORDER BY gjwo ASC ROWS 2 PRECEDING) AS gjwo_vvwo
   , MIN (gjwo) OVER (ORDER BY gjwo ASC ROWS 3 PRECEDING) AS gjwo_vvvwo
   , MIN (gjwo) OVER (ORDER BY gjwo ASC ROWS 4 PRECEDING) AS gjwo_vvvvwo
   , MIN (kjwo) OVER (ORDER BY kjwo ASC ROWS 1 PRECEDING) AS kjwo_vwo
   , MIN (kjwo) OVER (ORDER BY kjwo ASC ROWS 2 PRECEDING) AS kjwo_vvwo
   , MIN (kjwo) OVER (ORDER BY kjwo ASC ROWS 3 PRECEDING) AS kjwo_vvvwo
   , MIN (kjwo) OVER (ORDER BY kjwo ASC ROWS 4 PRECEDING) AS kjwo_vvvvwo
   FROM dbp_view.v_woche_2
   WHERE kjwo > 200152;