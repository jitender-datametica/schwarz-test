--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.RB_FAKTURA_MEDATA_DATE_1' does not exist or not authorized.
CREATE TABLE IF NOT EXISTS dbp_etl.rb_faktura_date_metadata_min_1 AS
SELECT CAST(FORMAT_DATE('%Y%m%d', MIN(dat_von)) AS INT64) AS dat_von--pe_review
FROM dbp_etl.rb_faktura_medata_date_1
WHERE kjmo IN (
    SELECT MIN(kjmo) AS a1636383086
    FROM dbp_etl.rb_faktura_medata_date_1
    WHERE rb_status = 0
)
AND rb_status = 0;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.RB_FAKTURA_MEDATA_DATE_1' does not exist or not authorized.

CREATE TABLE IF NOT EXISTS dbp_etl.rb_faktura_date_metadata_max_1 AS
SELECT CAST(FORMAT_DATE('%Y%m%d', MIN(dat_bis)) AS INT64) AS dat_bis--pe_review
FROM dbp_etl.rb_faktura_medata_date_1
WHERE kjmo IN (
    SELECT MIN(kjmo) AS a1636383086
    FROM dbp_etl.rb_faktura_medata_date_1
    WHERE rb_status = 0
)
AND rb_status = 0;

--[OK] statement is translated correctly (syntax and type checks are fine)

DROP TABLE IF EXISTS dbp_etl.faktura_medata_rb_1;

--[OK] statement is translated correctly (syntax and type checks are fine)

CREATE TABLE IF NOT EXISTS dbp_etl.faktura_medata_rb_1 LIKE dbp_data.besch_faktura_medata_1;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--ALTER TABLE DBX_LOAD.faktura_medata_rb_1
-- ADD wup_id INTEGER NOT NULL
--,ADD nb_id INTEGER NOT NULL
--,ADD gp_id INTEGER NOT NULL
--,ADD ek_netto_bnk_neu  NUMBER(29,4) 
--,ADD ek_mep_neu NUMBER(29,4) 
--,ADD logistikkostenzuschlag_neu NUMBER(29,4)
--
--;
--
--Comment from validation checker
--error line 3 at position 11 unexpected 'INTEGER'.
--,ADD nb_id  ^^^> INTEGER NOT NULL
--translated statement
-- ALTER TABLE DBP_ETL.faktura_medata_rb_1
--  ADD wup_id INTEGER NOT NULL
-- ,ADD nb_id INTEGER NOT NULL
-- ,ADD gp_id INTEGER NOT NULL
-- ,ADD ek_netto_bnk_neu  NUMBER(29,4) 
-- ,ADD ek_mep_neu NUMBER(29,4) 
-- ,ADD logistikkostenzuschlag_neu NUMBER(29,4)

-- ;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.RB_FAKTURA_DATE_METADATA_MIN_1' does not exist or not authorized.

INSERT INTO dbp_etl.faktura_medata_rb_1 (
    art_id, mandant_id, wup_id, nb_id, faktura_markt, zwsum_3_betrag,
    menge_fakturiert, dat_faktura, ek_netto_bnk, ek_mep, logistikkostenzuschlag, gp_id, ek_netto_bnk_neu, ek_mep_neu,
    logistikkostenzuschlag_neu
)
(
    SELECT
        T0.art_id,
        T0.mandant_id,
        T0.wup_id,
        T0.nb_id,
        T0.faktura_markt,
        T0.zwsum_3_betrag,
        T0.menge_fakturiert,
        T0.dat_faktura,
        T0.ek_netto_bnk,
        T0.ek_mep,
        T0.logistikkostenzuschlag,
        T1.gp_id,
        ROUND(
            CAST(CAST(T2.ek_netto_bnk AS NUMERIC) * T0.menge_fakturiert * T2.komponentenmenge AS NUMERIC), 4) AS
        ek_netto_bnk_neu,
        ROUND(CAST(CAST(T2.ek_mep AS NUMERIC) * T0.menge_fakturiert * T2.komponentenmenge AS NUMERIC), 4) AS ek_mep_neu,
        ROUND(CAST(T2.logistikkostenzuschlag * T0.menge_fakturiert * T2.komponentenmenge AS NUMERIC), 4)
            AS
            logistikkostenzuschlag_neu
    FROM dbp_data.besch_faktura_medata_1 AS T0
    INNER JOIN dbp_data.art_gp_zu_per_1 AS T1_1
        ON
            T0.mandant_id = T1.mandant_id AND T0.art_id = T1.art_id AND
            T0.dat_faktura BETWEEN T1.dat_von AND T1.dat_bis
    INNER JOIN dbp_data.art_gp_wup_zu_per_1 AS T2
        ON
            T0.art_id = T2.art_id AND T1.gp_id = T2.gp_id AND T0.dat_faktura
            BETWEEN T2.dat_von AND T2.dat_bis
    WHERE
        T1.einkaufsorganisation_id = 1000
        AND T2.einkaufsorganisation_id = 1000
        AND T2.wup_id = 6906
        AND T2.nb_id IN (99, -111)
        AND T2.bezugsweg_id = 4
        AND CAST(T2.ek_kal_basis AS NUMERIC) > 0
        AND T0.mandant_id = T2.mandant_id
        AND T0.dat_faktura BETWEEN PARSE_DATE('%Y%m%d', CAST((
            SELECT dat_von --pe_review
            FROM dbp_etl.rb_faktura_date_metadata_min_1) AS STRING)) AND PARSE_DATE('%Y%m%d', CAST((
            SELECT dat_bis
            FROM dbp_etl.rb_faktura_date_metadata_max_1
        ) AS STRING))
        AND T0.mandant_id = 1
);
