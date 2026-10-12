CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_JAHR_GJ_1
-- 20130822 - K.Kaiser Erweiterung um akt_gj_help, um im März unter akt_gj = 0 das gesamte VJ-GJ abbilden zu können
(
gj,
akt_gj,
akt_gj_komplett
,akt_gj_help
)
AS
   SELECT
  gj,
   akt_gj,
   akt_gj_komplett,
   CASE WHEN EXTRACT (MONTH FROM(CURRENT_DATE))=3 THEN akt_gj+1 ELSE akt_gj END AS akt_gj_help
   FROM dbp_view.v_jahr_gj_1
   WHERE gj>2001;