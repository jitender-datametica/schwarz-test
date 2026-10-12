DELETE FROM dbp_etl.bestand_mardh_mard_vz_log_1
WHERE (
    mandant_id, art_id, wup_id, nb_id, lagerort_id) IN (
    SELECT (mandant_id, art_id, wup_id, nb_id, lagerort_id)
    FROM dbp_etl.bestand_mardh_tmp_1
);
