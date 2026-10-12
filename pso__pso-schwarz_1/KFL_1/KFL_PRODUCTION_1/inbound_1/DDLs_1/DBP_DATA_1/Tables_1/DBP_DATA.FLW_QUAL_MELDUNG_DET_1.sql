--==============================================================
-- Table: flw_qual_meldung_det_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_qual_meldung_det_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_QUAL_MELDUNG_DET_1 (
   qual_meldung_id                     NUMBER(18,0)     NOT NULL COMMENT 'eindeutige ID der Qualitätsmeldung aus qmnum',
   qual_meldung_pos_id                 NUMBER(38,0)     NOT NULL COMMENT 'Positionsnummer im Positionssatz aus fenum',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   katalogart_id                       VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Katalogart',
   codegruppe_id                       VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'ID der codegruppe',
   pruefcode_id                        VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Fehlercode aus fecod',
   fehlgrund_id                        VARCHAR(40)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung des Fehl- / Verspätungsgrundes aus txt  - wird aus Modellierungsgründen zur ID erklärt',
   fehlerklasse_id                     NUMBER(38,0)     NOT NULL COMMENT 'ID der Fehlerklasse, z.Bsp. 00 aus fehlerklasse',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_QUAL_MELDUNG_DET PRIMARY KEY (qual_meldung_id, qual_meldung_pos_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Qualitätsmeldung - Positionen aus qmfe - MULTISET';

