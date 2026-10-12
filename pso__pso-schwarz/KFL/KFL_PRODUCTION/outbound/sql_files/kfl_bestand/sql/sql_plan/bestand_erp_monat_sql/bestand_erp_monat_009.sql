CREATE TABLE IF NOT EXISTS dbp_etl.vis_monat_bestand_wg_log (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    gjmo INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    log_tstmp DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
);
