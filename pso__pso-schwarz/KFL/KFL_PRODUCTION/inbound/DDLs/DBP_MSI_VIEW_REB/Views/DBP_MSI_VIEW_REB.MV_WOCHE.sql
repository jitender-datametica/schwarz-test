CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_WOCHE
(
kjwo
, gjwo
, kjwo_vj
, gjwo_vj
, akt_wo_kalendarisch
, akt_wo
, kj
, gj
)
AS
   SELECT
   kjwo, gjwo, kjwo_vj, gjwo_vj, akt_wo_kalendarisch, akt_wo, CAST (SUBSTR(TRIM(kjwo), 0, 4) AS SMALLINT), CAST (SUBSTR(TRIM(gjwo), 0, 4) AS SMALLINT)

   FROM dbp_view.v_woche
   WHERE kjwo > 200152
;