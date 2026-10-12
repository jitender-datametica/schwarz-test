--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.art_wup_ek_datum_relevant_kmo_2;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.art_wup_ek_datum_relevant_kmo_2 (
    dat_relevant DATE NOT NULL,
    dat_ausstieg DATE NOT NULL,
    rueckbewertung_fg INTEGER NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.art_gp_nm_zu_per_rb_kmo_2;


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE TABLE IF NOT EXISTS dbp_etl.art_gp_nm_zu_per_rb_kmo_2 LIKE dbp_data.art_gp_nm_zu_per_2;


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.art_gp_wup_zu_per_rb_kmo_2;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.art_gp_wup_zu_per_rb_kmo_2 (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE,
    ek_netto NUMERIC(29, 4),
    ek_nettonetto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4),
    einstandspreis NUMERIC(29, 4),
    wrg_id STRING(3) COLLATE 'und:ci',
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4)
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Table 'KFL_DEVELOPMENT.DBP_ETL.ART_WUP_EK_DATUM_RELEVANT_KMO_2' does not exist or not authorized.


INSERT INTO dbp_etl.art_wup_ek_datum_relevant_kmo_2 (
    dat_relevant, dat_ausstieg, rueckbewertung_fg
)
(
    SELECT
        CASE
            WHEN EXTRACT(MONTH FROM CURRENT_DATE("Europe/Berlin")) = 1
                THEN
                    DATE(
                        CAST(
                            EXTRACT(YEAR FROM CURRENT_DATE("Europe/Berlin"))
                            - 1 AS STRING
                        )
                        || '-01-01'
                    )
            ELSE
                DATE(
                    CAST(
                        EXTRACT(
                            YEAR FROM CURRENT_DATE("Europe/Berlin")
                        ) AS STRING
                    )
                    || '-01-01'
                )
        END AS dat_relevant,
        CURRENT_DATE("Europe/Berlin") AS dat_ausstieg,
        1 AS rueckbewertung_fg
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.ART_WUP_EK_DATUM_RELEVANT_KMO_2' does not exist or not authorized.


INSERT INTO dbp_etl.art_gp_nm_zu_per_rb_kmo_2 (
    mandant_id, art_id, wup_id, nb_id, dat_von, gp_id,
    einkaufsorganisation_id, dat_bis, vz_wup_id, bq_findung_id, bezugsweg_id
)
(SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    dat_von,
    gp_id,
    einkaufsorganisation_id,
    dat_bis,
    vz_wup_id,
    bq_findung_id,
    bezugsweg_id
FROM dbp_data.art_gp_nm_zu_per_2
WHERE dat_bis >= (
    SELECT dat_relevant
    FROM dbp_etl.art_wup_ek_datum_relevant_kmo_2
)
AND mandant_id > 1);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.ART_WUP_EK_DATUM_RELEVANT_KMO_2' does not exist or not authorized.


INSERT INTO dbp_etl.art_gp_wup_zu_per_rb_kmo_2 (
    mandant_id, art_id, gp_id, wup_id, dat_von, dat_bis,
    ek_netto,
    ek_nettonetto,
    ek_mep,
    einstandspreis,
    wrg_id,
    komponentenmenge,
    ek_netto_bnk
)
(
    SELECT
        mandant_id,
        art_id,
        gp_id,
        wup_id,
        dat_von,
        dat_bis,
        ek_netto,
        ek_nettonetto,
        ek_mep,
        einstandspreis,
        wrg_id,
        komponentenmenge,
        ek_netto_bnk
    FROM dbp_data.art_gp_wup_zu_per_2
    WHERE
        mandant_id > 1
        AND dat_bis >= (
            SELECT dat_relevant
            FROM dbp_etl.art_wup_ek_datum_relevant_kmo_2
        )
        -- CAST(PTY_FLOATDECEX(ek_netto , 'KLKPROD', 0, 1) AS NUMERIC(29,4)) > 0 AND
        AND
        ek_netto > 0
        AND wup_id = -1
);
