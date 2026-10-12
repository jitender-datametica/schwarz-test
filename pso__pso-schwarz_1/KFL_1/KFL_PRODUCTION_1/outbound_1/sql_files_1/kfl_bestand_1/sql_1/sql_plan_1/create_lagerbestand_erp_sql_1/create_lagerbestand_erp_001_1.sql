--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.lagerbestand_erp_1;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.lagerbestand_erp_1 (
    wup_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    lagerort_id STRING(4),
    art_id INTEGER NOT NULL,
    menge_lgbest_erp_frei_bme NUMERIC(29, 3),
    menge_lgbest_erp_umlag_bme NUMERIC(29, 3),
    menge_lgbest_erp_qual_bme NUMERIC(29, 3),
    menge_lgbest_erp_nf_charge_bme NUMERIC(29, 3),
    menge_lgbest_erp_gesp_bme NUMERIC(29, 3),
    menge_lgbest_erp_ret_gesp_bme NUMERIC(29, 3),
    sperr_id STRING(1),
    gjmo_buch INTEGER,
    lagerort_loesch_fg STRING(1),
    pflege_status STRING(20),
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    menge_lgbest_erp_kolli NUMERIC(29, 3),
    menge_lgbest_erp_palette NUMERIC(29, 3),
    betrag_lgbest_erp NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    komponentenmenge NUMERIC(29, 4),
    wrg_id STRING(3),
    vk_netto NUMERIC(29, 3),
    td_update TIMESTAMP,
    td_insert TIMESTAMP
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.lagerbestand_erp_tmp2_1;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.lagerbestand_erp_tmp2_1 (
    wup_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    lagerort_id STRING(4),
    art_id INTEGER NOT NULL,
    menge_lgbest_erp_frei_bme NUMERIC(29, 3),
    menge_lgbest_erp_umlag_bme NUMERIC(29, 3),
    menge_lgbest_erp_qual_bme NUMERIC(29, 3),
    menge_lgbest_erp_nf_charge_bme NUMERIC(29, 3),
    menge_lgbest_erp_gesp_bme NUMERIC(29, 3),
    menge_lgbest_erp_ret_gesp_bme NUMERIC(29, 3),
    sperr_id STRING(1),
    gjmo_buch INTEGER,
    lagerort_loesch_fg STRING(1),
    pflege_status STRING(20),
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    menge_lgbest_erp_kolli NUMERIC(29, 3),
    menge_lgbest_erp_palette NUMERIC(29, 3),
    betrag_lgbest_erp NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    komponentenmenge NUMERIC(29, 4),
    wrg_id STRING(3),
    vk_netto_lgbest_erp NUMERIC(29, 4)
);
