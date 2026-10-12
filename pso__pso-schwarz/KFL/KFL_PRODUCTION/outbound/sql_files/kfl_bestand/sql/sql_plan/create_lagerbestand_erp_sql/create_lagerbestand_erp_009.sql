--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.lagerbest_erp_per_tag_kmo_tmp;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.lagerbest_erp_per_tag_kmo_tmp (
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


DROP TABLE IF EXISTS dbp_etl.lagerbest_erp_per_tag_kmo_tmp2;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.lagerbest_erp_per_tag_kmo_tmp2 (
    wup_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    menge_lgbest_erp_frei_bme NUMERIC(29, 3),
    menge_lgbest_erp_gesamt_bme NUMERIC(29, 3),
    menge_lgbest_erp_qual_bme NUMERIC(29, 3),
    wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL,
    dat DATE NOT NULL,
    vw_id INTEGER,
    gp_id INTEGER,
    vk_netto NUMERIC(29, 4)
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.art_bestand_vw_sum_kmo_tmp;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.art_bestand_vw_sum_kmo_tmp (
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
    betrag_vk_netto_abgang NUMERIC(29, 4)
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.lager_process_tag_kmo;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.lager_process_tag_kmo (
    mandant_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    verarbeitet_fg INTEGER
);
