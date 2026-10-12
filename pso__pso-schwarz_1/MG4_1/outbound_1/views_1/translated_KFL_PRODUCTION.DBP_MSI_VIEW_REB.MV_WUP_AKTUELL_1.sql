CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_wup_aktuell_1 (aktuell_wup_id, nb_id, mandant_id, wup_standort,
markt) AS SELECT aktuell_wup_id,
 nb_id,
 mandant_id,
 MAX(wup_standort) AS wup_standort,
 MAX(TRIM(CAST(aktuell_wup_id AS STRING) || ' ' || wup_standort)) AS markt
FROM kfl_production_dbp_view.v_wup_1
WHERE mandant_id = 1
 AND ((dat_eroeffnung < CURRENT_DATE OR dat_eroeffnung < DATE_ADD(CURRENT_DATE, INTERVAL 45 DAY)) AND dat_von
     IS NOT NULL OR nb_id <> 0 OR wup_id = 9203)
 AND nb_id <> 99
 AND NOT wup_id BETWEEN 1 AND 999
GROUP BY aktuell_wup_id,
 nb_id,
 mandant_id;