CREATE OR REPLACE TABLE dbp_etl.marktbestand_erp_tmp_2 (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    vz_wup_id INTEGER DEFAULT -1,
    vw_id INTEGER,
    gp_id INTEGER DEFAULT -1,
    bestand_id INTEGER,
    bezugsweg_id INTEGER DEFAULT 0 NOT NULL,
    listung_id INTEGER,
    kdis INTEGER DEFAULT 0 NOT NULL,
    relevant_fg INTEGER DEFAULT 0 NOT NULL,
    ek_netto NUMERIC(29, 4) DEFAULT 0 NOT NULL,
    ek_netto_bnk NUMERIC(29, 4) DEFAULT 0 NOT NULL,
    vk_netto NUMERIC(29, 4) DEFAULT 0,
    wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL,
    ek_nettonetto NUMERIC(29, 4) DEFAULT 0 NOT NULL,
    einstandspreis NUMERIC(29, 4) DEFAULT 0 NOT NULL,
    menge_lgbest_erp_frei_bme NUMERIC(29, 3) NOT NULL,
    menge_lgbest_erp_qual_bme NUMERIC(29, 3) NOT NULL,
    menge_lgbest_erp_gesp_bme NUMERIC(29, 3) NOT NULL
);

INSERT INTO dbp_etl.marktbestand_erp_tmp_2 (
    mandant_id, art_id, wup_id, menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_qual_bme, menge_lgbest_erp_gesp_bme
)
(SELECT
    mandant_id,
    art_id,
    wup_id,
    menge_lgbest_erp_frei_bme,
    menge_lgbest_erp_qual_bme,
    menge_lgbest_erp_gesp_bme
FROM dbp_data.marktbestand_erp_2
WHERE dat = DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY));
