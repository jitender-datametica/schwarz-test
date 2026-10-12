CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_KUMULATION_4_KJWO
(
kjwo
,kjwo_kum
)
AS
   SELECT
   a.kjwo, b.kjwo kjwo_kum
   FROM dbp_view.v_woche a
   INNER JOIN dbp_view.v_woche b
   ON a.akt_wo BETWEEN b.akt_wo AND b.akt_wo +3
   ;