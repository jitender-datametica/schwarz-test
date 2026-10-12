create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_QUARTAL_GJ_VORQUARTAL_TRN_2(
	GJQU,
	GJQU_VQU,
	GJQU_VVQU,
	GJQU_VVVQU,
	GJQU_VVVVQU
) as
   SELECT
   gjqu
   , MIN (gjqu) OVER (ORDER BY gjqu ASC ROWS 1 PRECEDING) AS gjqu_vqu
   , MIN (gjqu) OVER (ORDER BY gjqu ASC ROWS 2 PRECEDING) AS gjqu_vvqu
   , MIN (gjqu) OVER (ORDER BY gjqu ASC ROWS 3 PRECEDING) AS gjqu_vvvqu
   , MIN (gjqu) OVER (ORDER BY gjqu ASC ROWS 4 PRECEDING) AS gjqu_vvvvqu
   FROM dbp_view.v_quartal_gj_2
   WHERE gjqu > 200104;