CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_JAHR_GJ
(
gj
,akt_gj
,akt_gj_komplett
)
AS
   SELECT
  gj
  , akt_gj
  , akt_gj_komplett
   FROM dbp_view.v_jahr_gj
   WHERE gj>2001;