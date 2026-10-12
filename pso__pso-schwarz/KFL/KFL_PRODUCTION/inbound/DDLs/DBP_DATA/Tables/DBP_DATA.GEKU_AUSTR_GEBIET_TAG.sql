--==============================================================
-- Table: geku_austr_gebiet_tag
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_austr_gebiet_tag
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_AUSTR_GEBIET_TAG (
   wmd_austraeger_gebiet_uid           NUMBER(18,0)     NOT NULL COMMENT 'Eindeutige ID eines Austrägergebiets',
   dat                                 DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM-TT',
   auflage                             NUMBER(38,0)     NOT NULL COMMENT 'Auflage in Stück',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_AUSTR_GEBIET_TAG PRIMARY KEY (wmd_austraeger_gebiet_uid, dat) NOT ENFORCED
)  COMMENT = 'GEKU - hier werden die Auflagen aus der Tabelle geku_austr_gebiet historisiert abgelegt';

