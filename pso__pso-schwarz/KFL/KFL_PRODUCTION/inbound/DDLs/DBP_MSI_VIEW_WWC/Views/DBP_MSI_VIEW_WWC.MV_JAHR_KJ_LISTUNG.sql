CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_JAHR_KJ_LISTUNG
(
kj
,akt_kj
)
AS

   SELECT
   kj, akt_kj

   FROM dbp_view.v_jahr_kj
   WHERE akt_kj > -3

   UNION ALL

   (Select distinct
   CAST( 9999 as SMALLINT) AS kj,
   CAST( 9999 as SMALLINT) AS akt_kj
   from dbp_view.v_jahr_kj)

;