--==============================================================
-- Table: anlage_klasse_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: anlage_klasse_spr_zu_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ANLAGE_KLASSE_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   anlage_klasse_id                    VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'ID der Anlageklasse aus der Quelle anlkl. Als Char-Feld mit führenden Nullen gespeichert',
   spr_id                              INTEGER     NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
   anlage_klasse_bez_kurz              VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Anlageklasse aus txt20',
   anlage_klasse_bez                   VARCHAR(50)      NOT NULL COLLATE 'en-ci' COMMENT 'Langbezeichnung der Anlageklasse aus txt50',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ANLAGE_KLASSE_SPR_ZU PRIMARY KEY (mandant_id, anlage_klasse_id, spr_id) NOT ENFORCED
)  COMMENT = 'IMS - Sprachabhängige Bezeichnung der Anlageklasse';

