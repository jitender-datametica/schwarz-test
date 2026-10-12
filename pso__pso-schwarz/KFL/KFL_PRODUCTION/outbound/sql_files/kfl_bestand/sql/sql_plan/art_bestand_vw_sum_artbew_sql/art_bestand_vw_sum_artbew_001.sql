--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.art_bestand_vw_sum_artbew_tmp;


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.art_bestand_vw_sum_artbew_tmp2;


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.art_bestand_vw_sum_tmp;


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.art_bestand_vw_sum_tmp2;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.art_bestand_vw_sum_artbew_tmp (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    gp_id INTEGER,
    wrg_id STRING(3),
    relevant_fg INTEGER,
    bezugsweg_id INTEGER,
    dat DATE,
    menge_abgang_bme NUMERIC(29, 4),
    herkunft STRING(10) COLLATE 'und:ci' NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.art_bestand_vw_sum_artbew_tmp2 (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    gp_id INTEGER,
    wrg_id STRING(3),
    vw_id INTEGER,
    relevant_fg INTEGER,
    bezugsweg_id INTEGER,
    dat DATE,
    menge_abgang_bme NUMERIC(29, 4),
    herkunft STRING(10) COLLATE 'und:ci' NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


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
    menge_abgang_bme NUMERIC(29, 3),
    herkunft STRING(10) COLLATE 'und:ci' NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.art_bestand_vw_sum_tmp2 (
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
