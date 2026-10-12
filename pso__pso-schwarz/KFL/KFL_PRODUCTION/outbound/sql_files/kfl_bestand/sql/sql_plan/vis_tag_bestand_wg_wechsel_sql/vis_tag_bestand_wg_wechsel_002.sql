--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.vis_tag_best_wg_wechsel_tmp;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--WARNING : UNIQUE PRIMARY INDEX applied on the table. Use PRIMARY KEY or UNIQUE constraint.


CREATE TABLE IF NOT EXISTS dbp_etl.vis_tag_best_wg_wechsel_tmp (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    arthiertyp_id INTEGER NOT NULL,
    alt_neu_kz INTEGER NOT NULL,
    wg_id INTEGER NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.vis_tag_best_wg_wechsel_join;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.


-- ,mwst             NUMERIC(29,2) NOT NULL
CREATE TABLE IF NOT EXISTS dbp_etl.vis_tag_best_wg_wechsel_join
(
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    arthiertyp_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    alt_neu_kz INTEGER NOT NULL,
    wg_id INTEGER NOT NULL,
    gj INTEGER NOT NULL,
    kjmo INTEGER NOT NULL,
    kjwo INTEGER NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.vis_tag_best_wg_wechsel_sum_t1;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.vis_tag_best_wg_wechsel_sum_t1 (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    wg_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    gj INTEGER NOT NULL,
    kjmo INTEGER NOT NULL,
    kjwo INTEGER NOT NULL,
    arthiertyp_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    relevant_fg INTEGER NOT NULL,
    bezugsweg_id INTEGER NOT NULL,
    wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL,
    anz_artikel_bestand INTEGER NOT NULL,
    anz_artikel_fehlmengen INTEGER NOT NULL,
    anz_artikel_nullbestand INTEGER NOT NULL,
    anz_artikel_minusbestand INTEGER NOT NULL,
    menge_lgbest_erp_frei_bme NUMERIC(29, 3) NOT NULL,
    menge_lgbest_erp_qual_bme NUMERIC(29, 3) NOT NULL,
    betrag_vk_netto_frei_bme NUMERIC(29, 4),
    betrag_vk_netto_qual_bme NUMERIC(29, 4),
    betrag_vk_brutto_frei_bme NUMERIC(29, 4),
    betrag_vk_brutto_qual_bme NUMERIC(29, 4),
    betrag_mo_anf_vk_ntto_frei_bme NUMERIC(29, 4),
    betrag_mo_anf_vk_ntto_qual_bme NUMERIC(29, 4),
    betrag_mo_anf_vk_btto_frei_bme NUMERIC(29, 4),
    betrag_mo_anf_vk_btto_qual_bme NUMERIC(29, 4)
);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.vis_tag_best_wg_wechsel_tmp (
    mandant_id, art_id, arthiertyp_id, alt_neu_kz, wg_id
)
(SELECT
    mandant_id,
    art_id,
    arthiertyp_id,
    -1,
    wg_id
FROM dbp_etl.vis_tag_bestand_wg_wechsel_log);


--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_etl.vis_tag_best_wg_wechsel_tmp (
    mandant_id, art_id, arthiertyp_id, alt_neu_kz, wg_id
)
(
    SELECT
        mandant_id,
        art_id,
        arthiertyp_id,
        1,
        wg_id
    FROM dbp_data.art_wg_zu_per AS T01
    WHERE
        dat_bis = PARSE_DATE('%F', '9999-12-31')
        AND arthiertyp_id = 2
);
