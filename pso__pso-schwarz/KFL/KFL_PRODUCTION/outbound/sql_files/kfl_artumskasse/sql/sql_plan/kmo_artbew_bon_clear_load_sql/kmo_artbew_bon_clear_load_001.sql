--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.kmo_artbew_bon;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


-- Informationen stammen aus Bon Kopf
-- Informationen stammen aus Bon Zeile
-- Hilfsattribute fuer Verarbeitung

CREATE TABLE IF NOT EXISTS dbp_etl.kmo_artbew_bon (
    mandant_id INTEGER,
    bon_id STRING(25) COLLATE 'und:ci',
    dat_booking DATE,
    wup_id INTEGER,
    bon_zeile INTEGER,
    kl_art_id INTEGER,
    ean_kasse INTEGER,
    menge NUMERIC(29, 4),
    umsatz_brutto NUMERIC(29, 4),
    wg_id INTEGER,
    lkp_art_id INTEGER,
    lkp_nb_id INTEGER,
    lkp_wg_id INTEGER,
    lkp_arthiertyp_id INTEGER,
    lkp_zek_id INTEGER,
    lkp_mwst_id INTEGER,
    lkp_posten_id STRING(4) COLLATE 'und:ci',
    lkp_umrechnungskurs FLOAT64,
    lkp_mwst NUMERIC(29, 2),
    lkp_wrg STRING(3) COLLATE 'und:ci'
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.kmo_artbew_bon_promotion;


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_artbew_bon_promotion (
    mandant_id INTEGER,
    bon_id STRING(25) COLLATE 'und:ci',
    dat_booking DATE,
    kl_art_id INTEGER,
    bon_zeile INTEGER,
    bonuskauf_id STRING(20) COLLATE 'und:ci',
    konditionsart_id STRING(10) COLLATE 'und:ci',
    umsatz_brutto NUMERIC(29, 4),
    umsatz_promo_brutto NUMERIC(29, 4),
    menge_promo NUMERIC(29, 3)
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.kmo_artbew_bon_dat;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_artbew_bon_dat (
    dat DATE NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.kmo_artbew_bon_delta;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_artbew_bon_delta (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    dat_booking DATE NOT NULL,
    xml_name STRING(255)
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Schema 'KFL_DEVELOPMENT.DBP_ODS' does not exist or not authorized.


/* Umsatz maximal bis gestern */ INSERT INTO dbp_etl.kmo_artbew_bon_delta (
    mandant_id, wup_id,
    dat_booking, xml_name
)
(
    SELECT
        K.mandant_id,
        K.wup_id,
        K.dat_booking,
        B.xml_name
    FROM dbp_ods.ods_bon_kopf AS K
    INNER JOIN dbp_ods.ods_bon_transaction AS T
        ON
            K.bon_id = T.bon_id AND K.mandant_id = T.mandant_id
            AND K.wup_id = T.wup_id AND T.mandant_id > 1 AND T.kassensystem_name = 'POSITION'
    INNER JOIN
        dbp_ods.bon_load_status AS B
        ON T.datei_name = B.xml_name AND B.artbew_fg = 0
    WHERE
        K.mandant_id <> 1 -- bartosiewiczadm - cloud migration

        -- AND b.parseBon_Time <= (CAST(CURRENT_TIME AS timestamp_ntz(0)) - INTERVAL '10 MINUTE' )

        AND B.parsebon_time
        <= CAST(
            TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 10 MINUTE) AS DATETIME
        )
        AND K.dat_booking
        <= DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
    GROUP BY
        K.mandant_id,
        K.wup_id,
        K.dat_booking,
        B.xml_name
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Schema 'KFL_DEVELOPMENT.DBP_ODS' does not exist or not authorized.


-- pro Mandant kann hier ein spezieller Filter eingebaut werden
-- Gesamten Markttag holen
-- Gesamten Markttag holen

-- pro Mandant kann hier ein spezieller Filter eingebaut werden
INSERT INTO dbp_etl.kmo_artbew_bon (
    mandant_id,
    bon_id,
    dat_booking,
    wup_id,
    bon_zeile,
    kl_art_id,
    ean_kasse,
    menge,
    umsatz_brutto,
    wg_id
)
(SELECT
    mandant_id,
    bon_id,
    dat_booking,
    wup_id,
    bon_zeile,
    kl_art_id,
    CAST(ean_kasse AS INTEGER) AS ean_kasse,
    CAST(menge_ AS NUMERIC) AS menge_,
    CAST(umsatz_brutto_ AS NUMERIC) AS umsatz_brutto_,
    wg_id
FROM (
    SELECT
        K.mandant_id,
        K.bon_id,
        K.dat_booking,
        K.wup_id,
        Z.kl_art_id,
        Z.ean_kasse,
        Z.bon_zeile,
        CASE
            WHEN K.kunde_fg = 0 /* zeilenstornor_fg = 1 */
                THEN Z.menge * -1
            ELSE Z.menge
        END AS menge_,
        CASE
            WHEN K.kunde_fg = 0 /* zeilenstornor_fg = 1 */
                THEN Z.umsatz_brutto * -1
            ELSE Z.umsatz_brutto
        END AS umsatz_brutto_,
        Z.wg_id
    FROM dbp_ods.ods_bon_kopf AS K
    INNER JOIN (
        SELECT
            mandant_id,
            wup_id,
            dat_booking
        FROM dbp_etl.kmo_artbew_bon_delta
        GROUP BY
            mandant_id,
            wup_id,
            dat_booking
    ) AS d
        ON
            K.mandant_id = d.mandant_id
            AND K.wup_id = d.wup_id
            AND K.dat_booking = d.dat_booking
    INNER JOIN dbp_ods.ods_bon_verkauf AS Z
        ON
            K.mandant_id = Z.mandant_id AND K.bon_id = Z.bon_id AND K
            .wup_id = Z.wup_id
    INNER JOIN dbp_ods.ods_bon_transaction AS T
        ON
            K.mandant_id = T.mandant_id AND K.bon_id = T.bon_id
            AND K.wup_id = T.wup_id
    WHERE
        K.mandant_id > 1
        AND K.kunde_fg = 1
        AND K.turnover_fg = 1
        AND CASE
            WHEN
                K.mandant_id = 8
                OR K.mandant_id = 3 AND K.kasse_nr NOT IN (241)
                OR K.mandant_id = 7 AND K.kasse_nr NOT IN (
                    241,
                    242
                )
                OR K.mandant_id = 2 AND K.kasse_nr NOT IN (241, 242)
                OR K.mandant_id = 6 AND K.kasse_nr NOT IN (
                    241,
                    242
                ) OR K.mandant_id = 5 AND K.kasse_nr NOT IN (241, 242
                )
                THEN 1
            ELSE 0
        END = 1
        AND (
            K.bon_id, K.wup_id) NOT IN (
            SELECT (bon_id, wup_id)
            FROM dbp_ods.ods_bon_storno
        )
    UNION DISTINCT
    SELECT
        K.mandant_id,
        K.bon_id,
        K.dat_booking,
        K.wup_id,
        Z.kl_art_id,
        Z.ean_kasse,
        -- Mengen Flag beruecksichtigen (Vorgabe David vom 18.03.)
        Z.bon_zeile
        ,
        CASE
            WHEN K.kunde_fg = 0 /* zeilenstornor_fg = 1 */
                THEN Z.menge * -1
            ELSE Z.menge
        END * Z.menge_fg AS menge_,
        CASE
            WHEN K.kunde_fg = 0 /* zeilenstornor_fg = 1 */
                THEN Z.umsatz_brutto * -1
            ELSE Z.umsatz_brutto
        END AS umsatz_brutto_,
        Z.wg_id
    FROM dbp_ods.ods_bon_kopf AS K
    INNER JOIN (
        SELECT
            mandant_id,
            wup_id,
            dat_booking
        FROM dbp_etl.kmo_artbew_bon_delta
        GROUP BY
            mandant_id,
            wup_id,
            dat_booking
    ) AS d
        ON
            K.mandant_id = d.mandant_id
            AND K.wup_id = d.wup_id
            AND K.dat_booking = d.dat_booking
    INNER JOIN dbp_ods.ods_bon_retoure AS Z
        ON
            K.mandant_id = Z.mandant_id AND K.bon_id = Z.bon_id AND K
            .wup_id = Z.wup_id
    INNER JOIN dbp_ods.ods_bon_transaction AS T
        ON
            K.mandant_id = T.mandant_id AND K.bon_id = T.bon_id
            AND K.wup_id = T.wup_id
    WHERE
        K.mandant_id > 1
        AND K.kunde_fg = 1
        AND K.turnover_fg = 1
        AND CASE
            WHEN
                K.mandant_id = 8
                OR K.mandant_id = 3 AND K.kasse_nr NOT IN (241)
                OR K.mandant_id = 7 AND K.kasse_nr NOT IN (
                    241,
                    242
                )
                OR K.mandant_id = 2 AND K.kasse_nr NOT IN (241, 242)
                OR K.mandant_id = 6 AND K.kasse_nr NOT IN (
                    241,
                    242
                ) OR K.mandant_id = 5 AND K.kasse_nr NOT IN (241, 242
                )
                THEN 1
            ELSE 0
        END = 1
        AND (
            K.bon_id, K.wup_id) NOT IN (
            SELECT (bon_id, wup_id)
            FROM dbp_ods.ods_bon_storno
        )
) AS t7);


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_etl.kmo_artbew_bon SET
    lkp_nb_id = W.nb_id
FROM dbp_data.wup AS W
WHERE
    kmo_artbew_bon.mandant_id = W.mandant_id AND kmo_artbew_bon.wup_id = W.wup_id;


--translated statement


UPDATE dbp_etl.kmo_artbew_bon SET
    lkp_art_id = t0.art_id,
    lkp_zek_id = CAST(t0.zek_id AS INTEGER),
    lkp_mwst_id = t0.mwst_id,
    lkp_posten_id = t0.posten_id FROM (
    SELECT
        mandant_id,
        kl_art_id,
        art_id,
        zek_id,
        mwst_id,
        posten_id
    FROM dbp_data.art AS A
    QUALIFY
        (
            ROW_NUMBER()
                OVER (
                    PARTITION BY mandant_id, kl_art_id
                    ORDER BY art_id IS NULL DESC, art_id DESC
                )
        )
        = 1
) AS t0
WHERE
    kmo_artbew_bon.mandant_id = t0.mandant_id AND kmo_artbew_bon.kl_art_id = t0.kl_art_id;


--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_etl.kmo_artbew_bon SET
    lkp_wg_id = W.wg_id,
    lkp_arthiertyp_id = W.arthiertyp_id
FROM dbp_data.art_wg_zu_per AS W
WHERE
    kmo_artbew_bon.mandant_id = W.mandant_id
    AND kmo_artbew_bon.lkp_art_id = W.art_id
    AND W.dat_bis = PARSE_DATE(
        '%F',
        '9999-12-31'
    ) AND W.arthiertyp_id = 2;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.KMO_ARTBEW_BON' does not exist or not authorized.


UPDATE dbp_etl.kmo_artbew_bon SET
    lkp_wrg = M.default_wrg
FROM dbp_data.mandant AS M
WHERE kmo_artbew_bon.mandant_id = M.mandant_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.KMO_ARTBEW_BON' does not exist or not authorized.


UPDATE dbp_etl.kmo_artbew_bon SET
    lkp_umrechnungskurs = CAST(K.umrechnungskurs AS FLOAT64)
FROM dbp_data.kurs AS K
WHERE
    kmo_artbew_bon.lkp_wrg = K.von_wrg_id
    AND kmo_artbew_bon.dat_booking BETWEEN K.dat_von AND K.dat_bis
    AND K.kurstyp_id
    = 9 AND K.nach_wrg_id = 'EUR';


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.KMO_ARTBEW_BON' does not exist or not authorized.


UPDATE dbp_etl.kmo_artbew_bon SET
    lkp_mwst = M.mwst
FROM dbp_data.mwst_per AS M
WHERE
    kmo_artbew_bon.mandant_id = M.mandant_id
    AND kmo_artbew_bon.lkp_mwst_id = M.mwst_id
    AND kmo_artbew_bon.dat_booking
    BETWEEN M.dat_von AND M.dat_bis;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.KMO_ARTBEW_BON' does not exist or not authorized.


DELETE FROM dbp_etl.kmo_artbew_bon
WHERE lkp_art_id IS NULL;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.KMO_ARTBEW_BON' does not exist or not authorized.


INSERT INTO dbp_etl.kmo_artbew_bon_dat (dat)
(
    SELECT dat_booking
    FROM dbp_etl.kmo_artbew_bon
    GROUP BY dat_booking
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.KMO_ARTBEW_BON' does not exist or not authorized.


INSERT INTO dbp_etl.kmo_artbew_bon_promotion (
    mandant_id, bon_id, dat_booking, kl_art_id, bon_zeile,
    bonuskauf_id,
    konditionsart_id,
    umsatz_brutto,
    umsatz_promo_brutto,
    menge_promo
)
(
    SELECT
        K.mandant_id,
        K.bon_id,
        K.dat_booking,
        K.kl_art_id,
        K.bon_zeile,
        P.bonuskauf_id,
        P.konditionsart_id,
        SUM(CAST(P.betrag_promo_brutto * -1 AS NUMERIC)) AS umsatz_brutto,
        SUM(P.umsatz_promo_brutto) AS umsatz_promo_brutto,
        SUM(P.menge_promo) AS menge_promo
    FROM dbp_etl.kmo_artbew_bon AS K
    INNER JOIN dbp_ods.ods_promotion AS P
        ON
            K.mandant_id = P.mandant_id AND K.bon_id = P.bon_id AND K.bon_zeile
            = P.bon_zeile /* mfialkiewicz ods_promotion filtering condition from on prem bon data loader */
            AND (
                P.wup_id
                >= 1000 AND P.wup_id <= 9999
            ) AND P.kl_art_id <= 9999999
    -- Falls pro Bonzeile mehrfach die gleichen Konditionsart
    WHERE COALESCE(P.betrag_promo_brutto, 0) <> 0

    -- und Bonuskaufid aufgefuert waeren (???)

    GROUP BY
        K.mandant_id,
        K.bon_id,
        K.dat_booking,
        K.kl_art_id,
        K.bon_zeile,
        P.bonuskauf_id,
        P.konditionsart_id
);
