CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_WOCHE_TRN_1
(
gjwo
,gjwo_vj
,kjwo
,kjwo_vj
,wo_dat_von
,wo_dat_bis
,kjwo_vwo
,kjwo_vwo2
,kjwo_vwo3
,kjwo_vwo4
)
AS
   SELECT
   gjwo, gjwo_vj, kjwo, kjwo_vj, wo_dat_von, wo_dat_bis, MIN (kjwo) OVER (ORDER BY kjwo ASC ROWS 1 PRECEDING) AS kjwo_vwo, MIN (kjwo) OVER (ORDER BY kjwo ASC ROWS 2 PRECEDING) AS kjwo_vwo2, MIN (kjwo) OVER (ORDER BY kjwo ASC ROWS 3 PRECEDING) AS kjwo_vwo3, MIN (kjwo) OVER (ORDER BY kjwo ASC ROWS 4 PRECEDING) AS kjwo_vwo4
   FROM dbp_view.v_woche_1
   WHERE  kjwo > 200152;