--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_rb;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


DROP TABLE IF EXISTS dbp_etl.art_gp_wup_zu_per_kmo_rb;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--CREATE MULTISET TABLE ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_rb,
--NO FALLBACK ,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--  mandant_id              INTEGER NOT NULL,
--  art_id                  INTEGER NOT NULL,
--  gp_id                   INTEGER NOT NULL,
--  wup_id                  INTEGER NOT NULL,
--  nb_id                   INTEGER ,
--  einkaufsorganisation_id INTEGER NOT NULL,
--  dat_von                 DATE FORMAT 'YYYY-MM-DD' NOT NULL,
--  dat_bis                 DATE FORMAT 'YYYY-MM-DD',
--  ek_brutto               NUMBER(29,4),    -- NUMBER(29,4),
--  ek_netto                NUMBER(29,4),    -- NUMBER(29,4),
--  ek_nettonetto           NUMBER(29,4),    -- NUMBER(29,4),
--  ek_kal_basis            NUMBER(29,4),    -- NUMBER(29,4),
--  ek_mep                  NUMBER(29,4),    -- NUMBER(29,4),
--  einstandspreis          NUMBER(29,4),    -- NUMBER(29,4),
--  logistikkostenzuschlag  NUMBER(29,4) COMPRESS 0.0000 ,
--  bezugsweg_id            INTEGER NOT NULL,
--  wrg_id                  STRING(3) CHARACTER SET LATIN CASESPECIFIC COMPRESS 'EUR',
--  komponentenmenge        NUMBER(29,4) COMPRESS 1.0000 ,
--  ek_brutto_nrfb_rab      NUMBER(29,4),    -- NUMBER(29,4),
--  bonusbasis              NUMBER(29,4),    -- NUMBER(29,4),
--  bezugsnebenkosten       NUMBER(29,4),    -- NUMBER(29,4) COMPRESS 0.0000 ,
--  zollwert                NUMBER(29,4) COMPRESS 0.0000 ,
--  ek_netto_bnk            NUMBER(29,4),    -- NUMBER(29,4),
--  ek_netto_bnk_sachk      NUMBER(29,4),    -- NUMBER(29,4),
--  cycle_id                INTEGER
--)
--PRIMARY INDEX NUPI_art_gp_wup_zu_per (art_id, wup_id);
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


-- NUMERIC(29,4),
-- NUMERIC(29,4),
-- NUMERIC(29,4),
-- NUMERIC(29,4),
-- NUMERIC(29,4),
-- NUMERIC(29,4),

-- NUMERIC(29,4)  ,
-- NUMERIC(29,4),
-- NUMERIC(29,4),
-- NUMERIC(29,4),
-- NUMERIC(29,4),
CREATE TABLE IF NOT EXISTS
dbp_etl.art_gp_wup_zu_per_kmo_rb (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER,
    einkaufsorganisation_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE,
    ek_brutto NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_nettonetto NUMERIC(29, 4),
    ek_kal_basis NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4),
    einstandspreis NUMERIC(29, 4),
    logistikkostenzuschlag NUMERIC(29, 4),
    bezugsweg_id INTEGER NOT NULL,
    wrg_id STRING(3),
    komponentenmenge NUMERIC(29, 4),
    ek_brutto_nrfb_rab NUMERIC(29, 4),
    bonusbasis NUMERIC(29, 4),
    bezugsnebenkosten NUMERIC(29, 4),
    zollwert NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto_bnk_sachk NUMERIC(29, 4),
    cycle_id INTEGER
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_rb
--SELECT *
--FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_bg
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


INSERT INTO dbp_etl.art_gp_wup_zu_per_kmo_rb
(
    SELECT *
    FROM dbp_etl.art_gp_wup_zu_per_kmo_bg
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_rb
--SELECT *
--FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_cz
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


INSERT INTO dbp_etl.art_gp_wup_zu_per_kmo_rb
(
    SELECT *
    FROM dbp_etl.art_gp_wup_zu_per_kmo_cz
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_rb
--SELECT *
--FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_hr
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


INSERT INTO dbp_etl.art_gp_wup_zu_per_kmo_rb
(
    SELECT *
    FROM dbp_etl.art_gp_wup_zu_per_kmo_hr
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_rb
--SELECT *
--FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_pl
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


INSERT INTO dbp_etl.art_gp_wup_zu_per_kmo_rb
(
    SELECT *
    FROM dbp_etl.art_gp_wup_zu_per_kmo_pl
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_rb
--SELECT *
--FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_ro
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


INSERT INTO dbp_etl.art_gp_wup_zu_per_kmo_rb
(
    SELECT *
    FROM dbp_etl.art_gp_wup_zu_per_kmo_ro
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_rb
--SELECT *
--FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_sk
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


INSERT INTO dbp_etl.art_gp_wup_zu_per_kmo_rb
(
    SELECT *
    FROM dbp_etl.art_gp_wup_zu_per_kmo_sk
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_rb
--SELECT *
--FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_md
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


INSERT INTO dbp_etl.art_gp_wup_zu_per_kmo_rb
(
    SELECT *
    FROM dbp_etl.art_gp_wup_zu_per_kmo_md
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM ${DWH_COMMON_DBX_DATA}.art_gp_wup_zu_per
--WHERE
--  (
--     mandant_id
--    ,art_id
--    ,gp_id
--    ,wup_id
--    ,einkaufsorganisation_id
--    ,dat_von
--    ,bezugsweg_id
--  ) IN
--  (
--    SELECT
--       a.mandant_id
--      ,a.art_id
--      ,a.gp_id
--      ,a.wup_id
--      ,a.einkaufsorganisation_id
--      ,a.dat_von
--      ,a.bezugsweg_id
--    FROM ${DWH_COMMON_DBX_DATA}.art_gp_wup_zu_per a
--
--    INNER JOIN
--    (
--      SELECT
--         mandant_id
--        ,art_id
--        ,gp_id
--        ,wup_id
--        ,bezugsweg_id
--        ,MIN(dat_von) AS dat_von_
--      FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_rb
--
--      GROUP BY
--         mandant_id
--        ,art_id
--        ,gp_id
--        ,wup_id
--        ,bezugsweg_id
--    ) b
--    ON a.mandant_id = b.mandant_id
--      AND a.art_id = b.art_id
--      AND a.gp_id = b.gp_id
--      AND a.wup_id = b.wup_id
--      AND a.bezugsweg_id = b.bezugsweg_id
--      AND a.dat_von >= b.dat_von_
--  )
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


DELETE FROM dbp_data.art_gp_wup_zu_per
WHERE (mandant_id, art_id, gp_id, wup_id, einkaufsorganisation_id, dat_von, bezugsweg_id) IN (
    SELECT (
        A.mandant_id, A.art_id,
        A.gp_id, A.wup_id, A.einkaufsorganisation_id, A.dat_von, A.bezugsweg_id
    )
    FROM dbp_data.art_gp_wup_zu_per AS A
    INNER JOIN (
        SELECT
            mandant_id,
            art_id,
            gp_id,
            wup_id,
            bezugsweg_id,
            MIN(dat_von) AS dat_von_
        FROM dbp_etl.art_gp_wup_zu_per_kmo_rb
        GROUP BY
            mandant_id,
            art_id,
            gp_id,
            wup_id,
            bezugsweg_id
    ) AS b
        ON
            A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.gp_id = b.gp_id AND A.wup_id = b.wup_id
            AND A.bezugsweg_id = b.bezugsweg_id AND A.dat_von >= b.dat_von_
);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_DATA}.art_gp_wup_zu_per
--(
--   cycle_id
--  ,mandant_id
--  ,art_id
--  ,gp_id
--  ,wup_id
--  ,nb_id
--  ,einkaufsorganisation_id
--  ,dat_von
--  ,dat_bis
--  ,ek_brutto
--  ,ek_netto
--  ,ek_nettonetto
--  ,ek_kal_basis
--  ,ek_mep
--  ,einstandspreis
--  ,logistikkostenzuschlag
--  ,bezugsweg_id
--  ,wrg_id
--  ,komponentenmenge
--  ,ek_brutto_nrfb_rab
--  ,bonusbasis
--  ,bezugsnebenkosten
--  ,zollwert
--  ,ek_netto_bnk
--  ,ek_netto_bnk_sachk
--)
--SELECT
--   cycle_id
--  ,mandant_id
--  ,art_id
--  ,gp_id
--  ,wup_id
--  ,nb_id
--  ,einkaufsorganisation_id
--  ,dat_von
--  ,dat_bis
--  ,ek_brutto
--  ,ek_netto
--  ,ek_nettonetto
--  ,ek_kal_basis
--  ,ek_mep
--  ,einstandspreis
--  ,logistikkostenzuschlag
--  ,bezugsweg_id
--  ,wrg_id
--  ,komponentenmenge
--  ,ek_brutto_nrfb_rab
--  ,bonusbasis
--  ,bezugsnebenkosten
--  ,zollwert
--  ,ek_netto_bnk
--  ,ek_netto_bnk_sachk
--FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_rb
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


INSERT INTO dbp_data.art_gp_wup_zu_per (
    mandant_id, gp_id, wup_id, nb_id, dat_von, bezugsweg_id, art_id,
    einkaufsorganisation_id, dat_bis, ek_brutto, ek_netto, ek_nettonetto, ek_kal_basis, ek_mep, einstandspreis,
    logistikkostenzuschlag, wrg_id, komponentenmenge, ek_brutto_nrfb_rab, bonusbasis, bezugsnebenkosten, zollwert,
    ek_netto_bnk, ek_netto_bnk_sachk, cycle_id
)
(SELECT
    mandant_id,
    gp_id,
    wup_id,
    nb_id,
    dat_von,
    bezugsweg_id,
    art_id,
    einkaufsorganisation_id,
    dat_bis,
    ek_brutto,
    ek_netto,
    ek_nettonetto,
    ek_kal_basis,
    ek_mep,
    einstandspreis,
    logistikkostenzuschlag,
    wrg_id,
    komponentenmenge,
    ek_brutto_nrfb_rab,
    bonusbasis,
    bezugsnebenkosten,
    zollwert,
    ek_netto_bnk,
    ek_netto_bnk_sachk,
    cycle_id
FROM dbp_etl.art_gp_wup_zu_per_kmo_rb);


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_bg;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


TRUNCATE TABLE dbp_etl.art_gp_wup_zu_per_kmo_bg;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_cz;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


TRUNCATE TABLE dbp_etl.art_gp_wup_zu_per_kmo_cz;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_hr;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


TRUNCATE TABLE dbp_etl.art_gp_wup_zu_per_kmo_hr;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_pl;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


TRUNCATE TABLE dbp_etl.art_gp_wup_zu_per_kmo_pl;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_ro;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


TRUNCATE TABLE dbp_etl.art_gp_wup_zu_per_kmo_ro;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_sk;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


TRUNCATE TABLE dbp_etl.art_gp_wup_zu_per_kmo_sk;


--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_md;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact your local system administrator.
--translated statement


TRUNCATE TABLE dbp_etl.art_gp_wup_zu_per_kmo_md;
