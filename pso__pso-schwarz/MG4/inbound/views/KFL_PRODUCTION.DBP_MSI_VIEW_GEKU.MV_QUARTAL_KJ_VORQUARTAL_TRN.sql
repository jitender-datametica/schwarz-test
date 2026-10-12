create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_QUARTAL_KJ_VORQUARTAL_TRN(
	KJQU,
	KJQU_VQU,
	KJQU_VVQU,
	KJQU_VVVQU,
	KJQU_VVVVQU
) as
   SELECT
   kjqu
   , MIN (kjqu) OVER (ORDER BY kjqu ASC ROWS 1 PRECEDING) AS kjqu_vqu
   , MIN (kjqu) OVER (ORDER BY kjqu ASC ROWS 2 PRECEDING) AS kjqu_vvqu
   , MIN (kjqu) OVER (ORDER BY kjqu ASC ROWS 3 PRECEDING) AS kjqu_vvvqu
   , MIN (kjqu) OVER (ORDER BY kjqu ASC ROWS 4 PRECEDING) AS kjqu_vvvvqu
   FROM dbp_view.v_quartal_kj
   WHERE kjqu > 200104;