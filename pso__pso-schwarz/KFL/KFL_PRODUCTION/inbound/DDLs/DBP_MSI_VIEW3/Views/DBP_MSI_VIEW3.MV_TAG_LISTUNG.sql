CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TAG_LISTUNG
(
dat
,kjmo
,kjwo
,kj
,akt_kj
,dat_von
,dat_bis
)
AS
   SELECT
   v01.dat,
   v01.kjmo,
   v01.kjwo,
   v01.kj,
   v01.akt_kj,
   v01.dat,
   v01.dat


   FROM dbp_view.v_tag v01

   WHERE v01.akt_kj > -3


   UNION ALL

   (Select distinct
   CAST( '9999-12-31' AS VARCHAR ) AS dat,
   CAST( 999912 AS INTEGER) AS kjmo,
   CAST( 999952 AS INTEGER) AS kjwo,
   CAST( 9999 AS SMALLINT) AS kj,
   CAST( 9999 AS SMALLINT) AS akt_kj,
   CAST( '9999-12-31' AS VARCHAR ) AS dat_von,
   CAST( '9999-12-31' AS VARCHAR ) AS dat_bis
   from dbp_view.v_tag)

;