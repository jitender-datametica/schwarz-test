--==============================================================
-- Table: disposition_rhythmus_ltf_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: disposition_rhythmus_ltf_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.DISPOSITION_RHYTHMUS_LTF_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   disposition_rhythmus_ltf_id         VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'ID für den Dispositionsrhythmus (wie oft, an welchen Wochentagen)',
   disposition_rhythmus_ltf_bez        VARCHAR(30)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung für den Dispositionsrhythmus (wie oft, an welchen Wochentagen)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_DISPOSITION_RHYTHMUS_LTF_SPR_ZU PRIMARY KEY (mandant_id, spr_id, disposition_rhythmus_ltf_id) NOT ENFORCED
)  COMMENT = 'LIS - Sprachabhängige Bezeichnungen für den Dispositionsrhythmus - SAP RET - ZRS_DISPORHYTHMT';

