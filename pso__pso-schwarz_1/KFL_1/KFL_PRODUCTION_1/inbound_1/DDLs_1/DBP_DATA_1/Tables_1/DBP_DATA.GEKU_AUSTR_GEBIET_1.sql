--==============================================================
-- Table: geku_austr_gebiet_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_austr_gebiet_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_AUSTR_GEBIET_1 (
   wmd_austraeger_gebiet_uid           NUMBER(18,0)     NOT NULL COMMENT 'Eindeutige ID eines Austrägergebiets',
   gebiets_bereich_uid                 NUMBER(18,0)     COMMENT 'Eindeutige ID eines Gebietsbereichs aus gbb_uid',
   auflage                             NUMBER(38,0)     COMMENT 'Auflage in Stück',
   solo_fg                             NUMBER(38,0)     COMMENT 'Solo-Gebiet ja=1, nein=0',
   wmd_austr_gebiet_bez                VARCHAR(250)     COLLATE 'en-ci' COMMENT 'Bezeichnung des Austrägergebiets',
   austr_gebiet_lfd_nr                 NUMBER(38,0)     COMMENT 'Mehrere Austrägergebiete können dieselbe Bezeichnung haben und unterscheiden sich durch eine_1 laufende Nummer - vielleicht aber auch durch eine_1 PLZ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_AUSTR_GEBIET PRIMARY KEY (wmd_austraeger_gebiet_uid) NOT ENFORCED
)  COMMENT = 'GEKU - Lookup-Tabelle der Austrägergebiete aus wmd_at_out - MULTISET';

