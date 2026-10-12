CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_JAHR_GJ_2
(
gj
, akt_gj
, akt_gj_komplett
, akt_gj_help
)
AS
   SELECT
   gj, akt_gj, akt_gj_komplett, CASE WHEN EXTRACT (MONTH FROM(CURRENT_DATE)) = 3 THEN akt_gj +1 ELSE akt_gj END AS akt_gj_help

   FROM dbp_view.v_jahr_gj_2
   WHERE gj > 2001
;