--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DROP TABLE ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_rb_1;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
DROP TABLE IF EXISTS DBP_ETL.art_gp_wup_zu_per_kmo_rb_1;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--original statement
--CREATE MULTISET TABLE ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_rb_1,
--NO FALLBACK ,
--NO BEFORE JOURNAL,
--NO AFTER JOURNAL,
--CHECKSUM = DEFAULT
--(
--  mandant_id              BYTEINT NOT NULL,
--  art_id                  INTEGER NOT NULL,
--  gp_id                   INTEGER NOT NULL,
--  wup_id                  INTEGER NOT NULL,
--  nb_id                   SMALLINT ,
--  einkaufsorganisation_id SMALLINT NOT NULL,
--  dat_von                 DATE FORMAT 'YYYY-MM_1-DD' NOT NULL,
--  dat_bis                 DATE FORMAT 'YYYY-MM_1-DD',
--  ek_brutto               DECIMAL(18,4),    -- DECIMAL(18,4),
--  ek_netto                DECIMAL(18,4),    -- DECIMAL(18,4),
--  ek_nettonetto           DECIMAL(18,4),    -- DECIMAL(18,4),
--  ek_kal_basis            DECIMAL(18,4),    -- DECIMAL(18,4),
--  ek_mep                  DECIMAL(18,4),    -- DECIMAL(18,4),
--  einstandspreis          DECIMAL(18,4),    -- DECIMAL(18,4),
--  logistikkostenzuschlag  DECIMAL(18,4) COMPRESS 0.0000 ,
--  bezugsweg_id            BYTEINT NOT NULL,
--  wrg_id                  CHAR(3) CHARACTER SET LATIN CASESPECIFIC COMPRESS 'EUR',
--  komponentenmenge        DECIMAL(18,4) COMPRESS 1.0000 ,
--  ek_brutto_nrfb_rab      DECIMAL(18,4),    -- DECIMAL(18,4),
--  bonusbasis              DECIMAL(18,4),    -- DECIMAL(18,4),
--  bezugsnebenkosten       DECIMAL(18,4),    -- DECIMAL(9,4) COMPRESS 0.0000 ,
--  zollwert                DECIMAL(9,4) COMPRESS 0.0000 ,
--  ek_netto_bnk            DECIMAL(18,4),    -- DECIMAL(18,4),
--  ek_netto_bnk_sachk      DECIMAL(18,4),    -- DECIMAL(18,4),
--  cycle_id                INTEGER
--)
--PRIMARY INDEX NUPI_art_gp_wup_zu_per (art_id, wup_id);
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
CREATE  TABLE DBP_ETL.art_gp_wup_zu_per_kmo_rb_1  (
  mandant_id              BYTEINT NOT NULL,
  art_id                  INTEGER NOT NULL,
  gp_id                   INTEGER NOT NULL,
  wup_id                  INTEGER NOT NULL,
  nb_id                   SMALLINT ,
  einkaufsorganisation_id SMALLINT NOT NULL,
  dat_von                 DATE NOT NULL,
  dat_bis                 DATE,
  ek_brutto               DECIMAL(18,4),    -- DECIMAL(18,4),
  ek_netto                DECIMAL(18,4),    -- DECIMAL(18,4),
  ek_nettonetto           DECIMAL(18,4),    -- DECIMAL(18,4),
  ek_kal_basis            DECIMAL(18,4),    -- DECIMAL(18,4),
  ek_mep                  DECIMAL(18,4),    -- DECIMAL(18,4),
  einstandspreis          DECIMAL(18,4),    -- DECIMAL(18,4),
  logistikkostenzuschlag  DECIMAL(18,4)  ,
  bezugsweg_id            BYTEINT NOT NULL,
  wrg_id                  CHAR(3) COLLATE 'de-cs' ,
  komponentenmenge        DECIMAL(18,4)  ,
  ek_brutto_nrfb_rab      DECIMAL(18,4),    -- DECIMAL(18,4),
  bonusbasis              DECIMAL(18,4),    -- DECIMAL(18,4),
  bezugsnebenkosten       DECIMAL(18,4),    -- DECIMAL(9,4)  ,
  zollwert                DECIMAL(9,4)  ,
  ek_netto_bnk            DECIMAL(18,4),    -- DECIMAL(18,4),
  ek_netto_bnk_sachk      DECIMAL(18,4),    -- DECIMAL(18,4),
  cycle_id                INTEGER
)
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_rb_1
--SELECT *
--FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_bg_1
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
INSERT INTO DBP_ETL.art_gp_wup_zu_per_kmo_rb_1
SELECT *
FROM DBP_ETL.art_gp_wup_zu_per_kmo_bg_1
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_rb_1
--SELECT *
--FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_cz_1
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
INSERT INTO DBP_ETL.art_gp_wup_zu_per_kmo_rb_1
SELECT *
FROM DBP_ETL.art_gp_wup_zu_per_kmo_cz_1
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_rb_1
--SELECT *
--FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_hr_1
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
INSERT INTO DBP_ETL.art_gp_wup_zu_per_kmo_rb_1
SELECT *
FROM DBP_ETL.art_gp_wup_zu_per_kmo_hr_1
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_rb_1
--SELECT *
--FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_pl_1
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
INSERT INTO DBP_ETL.art_gp_wup_zu_per_kmo_rb_1
SELECT *
FROM DBP_ETL.art_gp_wup_zu_per_kmo_pl_1
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_rb_1
--SELECT *
--FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_ro_1
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
INSERT INTO DBP_ETL.art_gp_wup_zu_per_kmo_rb_1
SELECT *
FROM DBP_ETL.art_gp_wup_zu_per_kmo_ro_1
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_rb_1
--SELECT *
--FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_sk_1
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
INSERT INTO DBP_ETL.art_gp_wup_zu_per_kmo_rb_1
SELECT *
FROM DBP_ETL.art_gp_wup_zu_per_kmo_sk_1
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_rb_1
--SELECT *
--FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_md_1
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
INSERT INTO DBP_ETL.art_gp_wup_zu_per_kmo_rb_1
SELECT *
FROM DBP_ETL.art_gp_wup_zu_per_kmo_md_1
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM ${DWH_COMMON_DBX_DATA}.art_gp_wup_zu_per_1
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
--    FROM ${DWH_COMMON_DBX_DATA}.art_gp_wup_zu_per_1 a
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
--      FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_rb_1
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
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
DELETE FROM DBP_DATA.art_gp_wup_zu_per_1
WHERE
  (
     mandant_id
    ,art_id
    ,gp_id
    ,wup_id
    ,einkaufsorganisation_id
    ,dat_von
    ,bezugsweg_id
  ) IN
  (
    SELECT
       a.mandant_id
      ,a.art_id
      ,a.gp_id
      ,a.wup_id
      ,a.einkaufsorganisation_id
      ,a.dat_von
      ,a.bezugsweg_id
    FROM DBP_DATA.art_gp_wup_zu_per_1 a

    INNER JOIN
    (
      SELECT
         mandant_id
        ,art_id
        ,gp_id
        ,wup_id
        ,bezugsweg_id
        ,MIN(dat_von) AS dat_von_
      FROM DBP_ETL.art_gp_wup_zu_per_kmo_rb_1

      GROUP BY
         mandant_id
        ,art_id
        ,gp_id
        ,wup_id
        ,bezugsweg_id
    ) b
    ON a.mandant_id = b.mandant_id
      AND a.art_id = b.art_id
      AND a.gp_id = b.gp_id
      AND a.wup_id = b.wup_id
      AND a.bezugsweg_id = b.bezugsweg_id
      AND a.dat_von >= b.dat_von_
  )
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--INSERT INTO ${DWH_COMMON_DBX_DATA}.art_gp_wup_zu_per_1
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
--FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_rb_1
--;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
INSERT INTO DBP_DATA.art_gp_wup_zu_per_1
(
   cycle_id
  ,mandant_id
  ,art_id
  ,gp_id
  ,wup_id
  ,nb_id
  ,einkaufsorganisation_id
  ,dat_von
  ,dat_bis
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logistikkostenzuschlag
  ,bezugsweg_id
  ,wrg_id
  ,komponentenmenge
  ,ek_brutto_nrfb_rab
  ,bonusbasis
  ,bezugsnebenkosten
  ,zollwert
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
)
SELECT
   cycle_id
  ,mandant_id
  ,art_id
  ,gp_id
  ,wup_id
  ,nb_id
  ,einkaufsorganisation_id
  ,dat_von
  ,dat_bis
  ,ek_brutto
  ,ek_netto
  ,ek_nettonetto
  ,ek_kal_basis
  ,ek_mep
  ,einstandspreis
  ,logistikkostenzuschlag
  ,bezugsweg_id
  ,wrg_id
  ,komponentenmenge
  ,ek_brutto_nrfb_rab
  ,bonusbasis
  ,bezugsnebenkosten
  ,zollwert
  ,ek_netto_bnk
  ,ek_netto_bnk_sachk
FROM DBP_ETL.art_gp_wup_zu_per_kmo_rb_1
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_bg_1;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
DELETE FROM DBP_ETL.art_gp_wup_zu_per_kmo_bg_1;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_cz_1;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
DELETE FROM DBP_ETL.art_gp_wup_zu_per_kmo_cz_1;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_hr_1;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
DELETE FROM DBP_ETL.art_gp_wup_zu_per_kmo_hr_1;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_pl_1;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
DELETE FROM DBP_ETL.art_gp_wup_zu_per_kmo_pl_1;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_ro_1;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
DELETE FROM DBP_ETL.art_gp_wup_zu_per_kmo_ro_1;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_sk_1;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
DELETE FROM DBP_ETL.art_gp_wup_zu_per_kmo_sk_1;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM ${DWH_COMMON_DBX_LOAD}.art_gp_wup_zu_per_kmo_md_1;
--
--Comment from validation checker
--MESSAGE: [unixODBC]User temporarily locked. Try again later, or contact_1 your local system administrator.
--translated statement
DELETE FROM DBP_ETL.art_gp_wup_zu_per_kmo_md_1;

