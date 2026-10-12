CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_letzte_ecm_statusmeldung
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT 7 AS system_id,
 mandant_id,
 statusmeldung_id,
 beleg_gj,
 beleg_id,
 zeitstempel,
 dat,
 statusmeldung_ecm_lfd_nr,
 statuscode_id AS letzte_ecm_statuscode_id,
 ersteller_id
FROM kfl_production_dbp_view.v_statusmeldung AS V01
WHERE ecm_vorgang <> 0
 AND beleg_gj <> 0
 AND beleg_id > 0
 AND mandant_id = 1
QUALIFY (ROW_NUMBER() OVER (PARTITION BY mandant_id, beleg_gj, beleg_id ORDER BY zeitstempel NULLS LAST,
      statusmeldung_ecm_lfd_nr NULLS LAST)) = 1;