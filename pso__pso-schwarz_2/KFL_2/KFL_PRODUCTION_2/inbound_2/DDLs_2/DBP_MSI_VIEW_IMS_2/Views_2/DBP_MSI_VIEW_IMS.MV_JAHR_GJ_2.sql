CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_JAHR_GJ_2
--15.04.2013 AL  initial
--24.06.2013 twie: Dummyjahr 1900 und bez hinzu
(
gj
, akt_gj
, akt_gj_komplett
, gj_bez
)
AS
   SELECT
   gj,
   akt_gj,
   akt_gj_komplett,
   CAST(gj AS VARCHAR(4)) gj_bez

   FROM dbp_view.v_jahr_gj_2

   UNION

   SELECT
   1900 AS gj,
   -9999 AS akt_gj,
   -9999 AS akt_gj_komplett,
   '' AS  gj_bez
   FROM dbp_view.v_jahr_gj_2
   WHERE akt_gj = 0
   ;