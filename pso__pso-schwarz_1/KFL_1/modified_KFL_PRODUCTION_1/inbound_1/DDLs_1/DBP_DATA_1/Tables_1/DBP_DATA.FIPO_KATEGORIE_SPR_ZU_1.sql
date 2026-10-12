--==============================================================
-- Table: fipo_kategorie_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_kategorie_spr_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FIPO_KATEGORIE_SPR_ZU_1 (
   fipo_kategorie_id                   INTEGER     NOT NULL COMMENT 'Eindeutige ID einer FIPO-Kategorie aus dem Quellfeld kat_id',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   fipo_kategorie_bez                  VARCHAR(255)     COMMENT 'Bezeichnung einer FIPO-Kategorie aus dem Quellfeld kai_kategorie',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FIPO_KATEGORIE_SPR_ZU PRIMARY KEY (fipo_kategorie_id, spr_id) NOT ENFORCED
)  COMMENT = 'FIPO - Sprachtabelle zu Kategerien - Quelltabelle kategorien_int';

