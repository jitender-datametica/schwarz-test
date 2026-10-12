--==============================================================
-- Table: geku_austr_gebiet_tag_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_austr_gebiet_tag_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_AUSTR_GEBIET_TAG_1 (
   wmd_austraeger_gebiet_uid           INTEGER     NOT NULL COMMENT 'Eindeutige ID eines Austrägergebiets',
   dat                                 DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM_1-TT',
   auflage                             INTEGER     NOT NULL COMMENT 'Auflage in Stück',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_AUSTR_GEBIET_TAG PRIMARY KEY (wmd_austraeger_gebiet_uid, dat) NOT ENFORCED
)  COMMENT = 'GEKU - hier werden die Auflagen aus der Tabelle geku_austr_gebiet_1 historisiert abgelegt';

