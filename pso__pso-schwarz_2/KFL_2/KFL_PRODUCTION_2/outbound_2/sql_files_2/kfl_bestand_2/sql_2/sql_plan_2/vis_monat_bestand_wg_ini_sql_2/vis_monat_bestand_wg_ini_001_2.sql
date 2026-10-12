--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.vis_monat_bestand_relevanz_2;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
--WARNING : UNIQUE PRIMARY INDEX applied on the table. Use PRIMARY KEY or UNIQUE constraint.


CREATE TABLE IF NOT EXISTS dbp_etl.vis_monat_bestand_relevanz_2 (
    mandant_id INTEGER NOT NULL,
    kjmo_letzter_bestand INTEGER NOT NULL,
    kjmo INTEGER NOT NULL,
    gj INTEGER NOT NULL,
    gjmo INTEGER NOT NULL,
    max_dat DATE NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.vis_monat_bestand_stamm_lkp_2;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.vis_monat_bestand_stamm_lkp_2 (
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    gjmo INTEGER NOT NULL,
    gj INTEGER NOT NULL,
    kjmo INTEGER NOT NULL,
    max_dat DATE NOT NULL,
    wg_id INTEGER NOT NULL,
    abt_id INTEGER,
    arthiertyp_id INTEGER NOT NULL,
    mwst NUMERIC(29, 2) NOT NULL,
    wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.vis_monat_bestand_stamm_lkp2_2;


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE TABLE IF NOT EXISTS dbp_etl.vis_monat_bestand_stamm_lkp2_2 (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    kjmo INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    relevant_fg INTEGER NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.vis_monat_bestand_wg_tmp2_2;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.vis_monat_bestand_wg_tmp2_2 (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    gjmo INTEGER NOT NULL,
    gj INTEGER NOT NULL,
    kjmo INTEGER NOT NULL,
    max_dat DATE NOT NULL,
    wg_id INTEGER NOT NULL,
    abt_id INTEGER NOT NULL,
    arthiertyp_id INTEGER NOT NULL,
    wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL,
    menge_lgbest_erp_frei_bme NUMERIC(29, 3) NOT NULL,
    menge_lgbest_erp_qual_bme NUMERIC(29, 3) NOT NULL,
    mwst NUMERIC(29, 2) NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.vis_monat_bestand_wg_tmp3_2;


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE TABLE IF NOT EXISTS dbp_etl.vis_monat_bestand_wg_tmp3_2 (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    gjmo INTEGER NOT NULL,
    gj INTEGER NOT NULL,
    kjmo INTEGER NOT NULL,
    wg_id INTEGER NOT NULL,
    abt_id INTEGER NOT NULL,
    arthiertyp_id INTEGER NOT NULL,
    relevant_fg INTEGER NOT NULL,
    bezugsweg_id INTEGER NOT NULL,
    wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL,
    menge_lgbest_erp_frei_bme NUMERIC(29, 3) NOT NULL,
    menge_lgbest_erp_qual_bme NUMERIC(29, 3) NOT NULL,
    betrag_vk_netto_frei_bme NUMERIC(29, 4),
    betrag_vk_netto_qual_bme NUMERIC(29, 4),
    betrag_vk_brutto_frei_bme NUMERIC(29, 4),
    betrag_vk_brutto_qual_bme NUMERIC(29, 4)
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.vis_monat_bestand_wg_2;


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE TABLE IF NOT EXISTS dbp_etl.vis_monat_bestand_wg_2 (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    gj INTEGER NOT NULL,
    kjmo INTEGER NOT NULL,
    wg_id INTEGER NOT NULL,
    abt_id INTEGER NOT NULL,
    arthiertyp_id INTEGER NOT NULL,
    relevant_fg INTEGER NOT NULL,
    bezugsweg_id INTEGER NOT NULL,
    wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL,
    menge_lgbest_erp_frei_bme NUMERIC(29, 3) NOT NULL,
    menge_lgbest_erp_qual_bme NUMERIC(29, 3) NOT NULL,
    betrag_vk_netto_frei_bme NUMERIC(29, 4),
    betrag_vk_netto_qual_bme NUMERIC(29, 4),
    betrag_vk_brutto_frei_bme NUMERIC(29, 4),
    betrag_vk_brutto_qual_bme NUMERIC(29, 4),
    menge_lgbest_erp_frei_bme_kum NUMERIC(29, 3) NOT NULL,
    menge_lgbest_erp_qual_bme_kum NUMERIC(29, 3) NOT NULL,
    betrag_vk_netto_frei_bme_kum NUMERIC(29, 4),
    betrag_vk_netto_qual_bme_kum NUMERIC(29, 4),
    betrag_vk_brutto_frei_bme_kum NUMERIC(29, 4),
    betrag_vk_brutto_qual_bme_kum NUMERIC(29, 4)
);


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.


INSERT INTO dbp_etl.vis_monat_bestand_relevanz_2 (
    mandant_id, kjmo_letzter_bestand, kjmo, gj, gjmo, max_dat
)
(
    SELECT
        tmp.mandant_id,
        tmp.kjmo_letzter_bestand,
        M.kjmo,
        M.gj,
        M.gjmo,
        CASE
            WHEN
                EXTRACT(MONTH FROM M.max_dat)
                = EXTRACT(MONTH FROM CURRENT_DATE("Europe/Berlin"))
                THEN CURRENT_DATE("Europe/Berlin")
            ELSE M.max_dat
        END AS max_dat
    FROM (SELECT
        mandant_id,
        MAX(kjmo) AS kjmo_letzter_bestand
    FROM dbp_msi_data.vis_monat_bestand_wg_2
    GROUP BY mandant_id) AS tmp
    INNER JOIN
        dbp_data.monat_2 AS M
        ON tmp.kjmo_letzter_bestand < M.kjmo AND M.akt_mo <= 0
);
