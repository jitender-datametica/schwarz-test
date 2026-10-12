CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_letzte_ecm_statusmeldung_1 (system_id, mandant_id,
statusmeldung_id, beleg_gj, beleg_id, zeitstempel, dat, statusmeldung_ecm_lfd_nr, letzte_ecm_statuscode_id, ersteller_id
) AS SELECT 7 AS system_id,
 mandant_id,
 statusmeldung_id,
 beleg_gj,
 beleg_id,
 zeitstempel,
 dat,
 statusmeldung_ecm_lfd_nr,
 statuscode_id AS letzte_ecm_statuscode_id,
 ersteller_id
FROM kfl_production_dbp_view.v_statusmeldung_1 AS V01
WHERE ecm_vorgang <> 0
 AND beleg_gj <> 0
 AND beleg_id > 0
 AND mandant_id = 1
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(beleg_gj AS STRING), beleg_id ORDER BY
      zeitstempel IS NULL, zeitstempel, statusmeldung_ecm_lfd_nr IS NULL, statusmeldung_ecm_lfd_nr)) = 1;