CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_WOCHE_LISTUNG_2
(
kjwo
,akt_wo
)
AS
   SELECT
   kjwo, akt_wo
   FROM dbp_view.v_woche_2
   WHERE  kjwo > 200152

   UNION ALL

   (Select distinct
   CAST( 999952 AS INTEGER) AS kjwo,
   CAST( 9999 AS SMALLINT) AS akt_wo
   from dbp_view.v_woche_2)
;