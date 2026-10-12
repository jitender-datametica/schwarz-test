--==============================================================
-- Table: geschaeftsvorfall_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geschaeftsvorfall_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GESCHAEFTSVORFALL_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   geschaeftsvorfall_id                VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID eines Geschäftsvorfalls aus gv_id, z.Bsp. 01',
   spr_id                              INTEGER     NOT NULL COMMENT 'Referenz zu der Tabelle spr_1 fuer jede DWH Sprache = 1.',
   geschaeftsvorfall_bez               VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Geschäftvorfalls aus gv_bez, z.Bsp. NATURALRABATT N FÜR M',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GESCHAEFTSVORFALL_SPR_ZU PRIMARY KEY (mandant_id, geschaeftsvorfall_id, spr_id) NOT ENFORCED
)  COMMENT = 'AIS_KMO - Sprachabhängige Bezeichnungen der Geschäftsvorfälle aus zbonus_sl';
