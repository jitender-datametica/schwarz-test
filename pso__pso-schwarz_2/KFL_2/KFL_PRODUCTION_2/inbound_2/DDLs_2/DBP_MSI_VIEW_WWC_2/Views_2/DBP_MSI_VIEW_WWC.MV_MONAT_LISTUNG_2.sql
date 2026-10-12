CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_MONAT_LISTUNG_2
(
kjmo
, kj
, akt_kj
)
AS
   SELECT
   v01.kjmo, v01.kj, v01.akt_kj

   FROM dbp_view.v_monat_2  v01
   WHERE v01.akt_kj > -3


   UNION ALL

   (Select distinct
   CAST( 999912 AS INTEGER) AS kjmo,
   CAST( 9999 AS SMALLINT) AS kj,
   CAST( 9999 AS SMALLINT) AS akt_kj
   from dbp_view.v_monat_2)

;