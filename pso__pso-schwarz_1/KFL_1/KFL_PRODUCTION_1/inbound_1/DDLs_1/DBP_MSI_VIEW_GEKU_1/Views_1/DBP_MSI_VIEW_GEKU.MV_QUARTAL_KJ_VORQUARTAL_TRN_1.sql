CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_QUARTAL_KJ_VORQUARTAL_TRN_1
(
kjqu,
kjqu_vqu,
kjqu_vvqu,
kjqu_vvvqu,
kjqu_vvvvqu
)
AS
   SELECT
   kjqu
   , MIN (kjqu) OVER (ORDER BY kjqu ASC ROWS 1 PRECEDING) AS kjqu_vqu
   , MIN (kjqu) OVER (ORDER BY kjqu ASC ROWS 2 PRECEDING) AS kjqu_vvqu
   , MIN (kjqu) OVER (ORDER BY kjqu ASC ROWS 3 PRECEDING) AS kjqu_vvvqu
   , MIN (kjqu) OVER (ORDER BY kjqu ASC ROWS 4 PRECEDING) AS kjqu_vvvvqu
   FROM dbp_view.v_quartal_kj_1
   WHERE kjqu > 200104;