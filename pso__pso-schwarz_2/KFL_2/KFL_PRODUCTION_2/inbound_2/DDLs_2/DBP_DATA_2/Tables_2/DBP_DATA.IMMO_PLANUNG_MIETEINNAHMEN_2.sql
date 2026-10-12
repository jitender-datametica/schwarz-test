--==============================================================
-- Table: immo_planung_mieteinnahmen_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_planung_mieteinnahmen_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMMO_PLANUNG_MIETEINNAHMEN_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Planflache in Quadratmetern',
   we_intreno                          VARCHAR(20)      NOT NULL COLLATE 'en-ci',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Währungsid',
   planmiete_per_monat                 NUMBER(18,2)     NOT NULL,
   planmiete_per_qm                    NUMBER(18,2)     NOT NULL COMMENT 'Planmiete pro Quadratmeter',
   planflaeche                         NUMBER(18,4)     NOT NULL COMMENT 'Planflaeche in Quadratmetern.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMMO_PLANUNG_MIETEINNAHMEN PRIMARY KEY (mandant_id, we_intreno) NOT ENFORCED
)  COMMENT = 'IMMO - Planung der Mieteinnahmen für das laufende Jahr. Werden jedes Jahr überschrieben.';
