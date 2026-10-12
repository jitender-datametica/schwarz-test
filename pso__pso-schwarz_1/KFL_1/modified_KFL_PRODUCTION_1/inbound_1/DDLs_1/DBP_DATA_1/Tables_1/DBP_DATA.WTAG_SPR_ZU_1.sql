--==============================================================
-- Table: wtag_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wtag_spr_zu_1
   generated from Powerdesigner on Sonntag, 4. Februar 2024 11:32:38
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WTAG_SPR_ZU_1 (
   wtag_id                             INTEGER     NOT NULL COMMENT 'Wochentag ID, von 1 bis 7, wobei 1 = Montag und 7 = Sonntag',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   wtag_bez                            VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Wochentags in den DWH-Sprachen',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WTAG_SPR_ZU PRIMARY KEY (wtag_id, spr_id) NOT ENFORCED
)  COMMENT = 'TP1_MIS - Bezeichnung der Wochentage in den DWH-Sprachen';
