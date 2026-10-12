--==============================================================
-- Table: geku_verteilgebiet_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_verteilgebiet_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEKU_VERTEILGEBIET_1 (
   verteilgebiet_uid                   INTEGER     NOT NULL COMMENT 'Eindeutige ID des Verteilgebiets',
   gebietsleiter_uid                   INTEGER     NOT NULL COMMENT 'Eindeutige ID des Gebietsleiters aus pc_nr',
   verteilgebiet_bez                   VARCHAR(60)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Verteilgebiets',
   mandant_id                          INTEGER     COMMENT 'Mandant_1 im DWH. Gehört zum NILS Verteilgebiet',
   nils_verteilgebiet_id               INTEGER     COMMENT 'Verteilgebiet ID aus dem System NILS. Wird per Transaction Service oder GEKU-SST gepflegt',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEKU_VERTEILGEBIET PRIMARY KEY (verteilgebiet_uid) NOT ENFORCED
)  COMMENT = 'GEKU - Lookup-Tabelle der Verteilgebiete aus wmd_vg_out';
