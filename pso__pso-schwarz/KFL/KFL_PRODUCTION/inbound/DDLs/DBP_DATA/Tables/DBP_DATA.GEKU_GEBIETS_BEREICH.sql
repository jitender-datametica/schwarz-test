--==============================================================
-- Table: geku_gebiets_bereich
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_gebiets_bereich
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_GEBIETS_BEREICH (
   gebiets_bereich_uid                 NUMBER(18,0)     NOT NULL COMMENT 'Eindeutige ID eines Gebietsbereichs aus gbb_uid',
   verteilgebiet_uid                   NUMBER(18,0)     NOT NULL COMMENT 'Eindeutige ID des Verteilgebiets',
   gebiets_betreuer_uid                NUMBER(18,0)     NOT NULL COMMENT 'Eindeutige ID eines Gebietsbetreuers',
   gebiets_bereich_bez                 VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Gebietsbereiche aus code_name',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_GEBIETS_BEREICH PRIMARY KEY (gebiets_bereich_uid) NOT ENFORCED
)  COMMENT = 'GEKU - Lookup-Tabelle der Gebietsbereiche aus wmd_gbb_out';

