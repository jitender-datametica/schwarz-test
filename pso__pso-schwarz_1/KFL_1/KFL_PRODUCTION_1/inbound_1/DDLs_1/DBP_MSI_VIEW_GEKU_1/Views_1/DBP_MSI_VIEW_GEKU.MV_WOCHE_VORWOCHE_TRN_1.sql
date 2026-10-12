CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_WOCHE_VORWOCHE_TRN_1
(
kjwo,
gjwo,
gjwo_vwo,
gjwo_vvwo,
gjwo_vvvwo,
gjwo_vvvvwo,
kjwo_vwo,
kjwo_vvwo,
kjwo_vvvwo,
kjwo_vvvvwo
)
AS
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
   FROM dbp_view.v_woche_1
   WHERE kjwo > 200152;