--==============================================================
-- Table: griffzone_typ_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: griffzone_typ_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GRIFFZONE_TYP_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   griffzone_typ_id                    VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Gruppierungsmekmal über Griffzonen.',
   spr_id                              INTEGER     NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
   griffzone_typ_bez                   VARCHAR(30)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung für den Griffzonen Typ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GRIFFZONE_TYP_SPR_ZU PRIMARY KEY (mandant_id, griffzone_typ_id, spr_id) NOT ENFORCED
)  COMMENT = 'TP408_LVS - Hier sind die Bezeichnungen der Griffzonentypen hinterlegt';
