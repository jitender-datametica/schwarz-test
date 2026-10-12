CREATE OR REPLACE VIEW DBP_MSI_VIEW_SHR.MV_JAHR_GJ
(
gj
, akt_gj
, akt_gj_komplett
)
AS
   SELECT
   v01.gj, v01.akt_gj, v01.akt_gj_komplett

   FROM dbp_view.v_jahr_gj v01;