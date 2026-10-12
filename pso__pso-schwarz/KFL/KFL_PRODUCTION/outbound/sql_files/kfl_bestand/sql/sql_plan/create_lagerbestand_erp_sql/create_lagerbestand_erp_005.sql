--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.lagerbestand_erp_per_tag_tmp;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.lagerbestand_erp_per_tag_tmp (
    wup_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    menge_lgbest_erp_frei_bme NUMERIC(29, 3),
    menge_lgbest_erp_gesamt_bme NUMERIC(29, 3),
    menge_lgbest_erp_qual_bme NUMERIC(29, 3),
    wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL,
    dat DATE NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.lagerbestand_erp_per_tag_tmp2;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.lagerbestand_erp_per_tag_tmp2 (
    wup_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    menge_lgbest_erp_frei_bme NUMERIC(29, 3),
    menge_lgbest_erp_gesamt_bme NUMERIC(29, 3),
    menge_lgbest_erp_qual_bme NUMERIC(29, 3),
    wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL,
    dat DATE NOT NULL,
    wup_id_neu INTEGER,
    nb_id_neu INTEGER,
    vw_id INTEGER,
    gp_id INTEGER,
    vk_netto NUMERIC(29, 4)
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.art_bestand_vw_sum_tmp;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.


CREATE TABLE IF NOT EXISTS dbp_etl.art_bestand_vw_sum_tmp (
    mandant_id INTEGER NOT NULL,
    vw_id INTEGER NOT NULL,
    bezugsweg_id INTEGER NOT NULL,
    lagerbestand_fg INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    gp_id INTEGER NOT NULL,
    relevant_fg INTEGER NOT NULL,
    wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL,
    menge_lgbest_erp_frei_bme NUMERIC(29, 3) NOT NULL,
    menge_lgbest_erp_gesamt_bme NUMERIC(29, 3) NOT NULL,
    menge_lgbest_erp_qual_bme NUMERIC(29, 3) NOT NULL,
    betrag_vk_netto_frei_bme NUMERIC(29, 4),
    betrag_vk_netto_gesamt_bme NUMERIC(29, 4),
    betrag_vk_netto_qual_bme NUMERIC(29, 4),
    menge_abgang_bme NUMERIC(29, 3)
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.lager_process_tag;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.


CREATE TABLE IF NOT EXISTS dbp_etl.lager_process_tag (
    dat DATE NOT NULL,
    verarbeitet_fg INTEGER
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.lagerbestand_erp_tmpk;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.lagerbestand_erp_tmpk (
    wup_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
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
    bewertungskreis_id STRING(4) COLLATE 'und:ci',
    vk_netto NUMERIC(29, 4),
    td_update TIMESTAMP,
    td_insert TIMESTAMP
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.kmo_mard_dat;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_mard_dat (
    mandant_id INTEGER,
    dat_von DATE
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.lagerbestand_erp_tmp3;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.lagerbestand_erp_tmp3 (
    wup_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL,
    art_id INTEGER NOT NULL,
    menge_lgbest_erp_frei_bme NUMERIC(29, 3),
    menge_lgbest_erp_umlag_bme NUMERIC(29, 3),
    menge_lgbest_erp_qual_bme NUMERIC(29, 3),
    menge_lgbest_erp_nf_charge_bme NUMERIC(29, 3),
    menge_lgbest_erp_gesp_bme NUMERIC(29, 3),
    menge_lgbest_erp_ret_gesp_bme NUMERIC(29, 3),
    sperr_id STRING(1) COLLATE 'und:ci',
    gjmo_buch INTEGER,
    lagerort_loesch_fg STRING(1) COLLATE 'und:ci',
    pflege_status STRING(20) COLLATE 'und:ci',
    dat_von DATE NOT NULL,
    menge_lgbest_erp_kolli NUMERIC(29, 3),
    menge_lgbest_erp_palette NUMERIC(29, 3),
    dat_bis DATE,
    betrag_lgbest_erp NUMERIC(29, 4),
    wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL,
    vk_netto_lgbest_erp NUMERIC(29, 4)
);
