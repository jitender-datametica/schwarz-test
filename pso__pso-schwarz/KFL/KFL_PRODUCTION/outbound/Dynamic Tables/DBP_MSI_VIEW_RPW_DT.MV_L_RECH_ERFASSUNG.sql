CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_l_rech_erfassung
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 erfassung_id,
 7 AS system_id,
  CASE
  WHEN erfassung_id IN ('MED', 'DED')
  THEN 'EDI'
  ELSE 'NonEDI'
  END AS edi_fg
FROM kfl_production_dbp_view.v_l_rech_erfassung
WHERE mandant_id = 1;