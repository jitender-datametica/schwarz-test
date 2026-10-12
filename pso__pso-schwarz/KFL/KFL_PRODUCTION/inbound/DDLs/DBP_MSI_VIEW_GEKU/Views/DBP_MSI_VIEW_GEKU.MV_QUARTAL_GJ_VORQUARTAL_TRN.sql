CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_QUARTAL_GJ_VORQUARTAL_TRN
(
gjqu,
gjqu_vqu,
gjqu_vvqu,
gjqu_vvvqu,
gjqu_vvvvqu
)
AS
   SELECT
   gjqu
   , MIN (gjqu) OVER (ORDER BY gjqu ASC ROWS 1 PRECEDING) AS gjqu_vqu
   , MIN (gjqu) OVER (ORDER BY gjqu ASC ROWS 2 PRECEDING) AS gjqu_vvqu
   , MIN (gjqu) OVER (ORDER BY gjqu ASC ROWS 3 PRECEDING) AS gjqu_vvvqu
   , MIN (gjqu) OVER (ORDER BY gjqu ASC ROWS 4 PRECEDING) AS gjqu_vvvvqu
   FROM dbp_view.v_quartal_gj
   WHERE gjqu > 200104;