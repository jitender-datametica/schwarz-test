CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_JAHR_GJ_2
(
gj
,akt_gj
,akt_gj_komplett)
AS
   SELECT
  gj, akt_gj, akt_gj_komplett
   FROM dbp_view.v_jahr_gj_2


   UNION ALL

   (Select distinct
   CAST( 9999 as SMALLINT) AS gj,
   CAST( 9999 as SMALLINT) AS akt_gj, CAST( 9999 as SMALLINT) AS akt_gj_komplett
   from dbp_view.v_jahr_gj_2);