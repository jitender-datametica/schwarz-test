--[OK] statement is translated correctly (syntax and type checks are fine)


-- Lade-Kennzeichen (0= neue Daten, 1= alte Daten (aus Zieltabelle, s. Step 4)
CREATE TABLE IF NOT EXISTS
dbp_etl.bestand_mardh_tmp_1 (
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    gjmo INTEGER NOT NULL,
    gjmo_bis INTEGER NOT NULL,
    lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL,
    mard_fg INTEGER NOT NULL,
    menge_lgbest_erp_frei_bme NUMERIC(29, 3),
    menge_lgbest_erp_umlag_bme NUMERIC(29, 3),
    menge_lgbest_erp_qual_bme NUMERIC(29, 3),
    menge_lgbest_erp_nf_charge_bme NUMERIC(29, 3),
    menge_lgbest_erp_gesp_bme NUMERIC(29, 3),
    menge_lgbest_erp_ret_gesp_bme NUMERIC(29, 3),
    lade_kz INTEGER NOT NULL,
    td_update TIMESTAMP,
    td_insert TIMESTAMP
);
