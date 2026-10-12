--==============================================================
-- Table: l_quellsystem_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_quellsystem_2
   generated from Powerdesigner on Dienstag, 9. Januar 2024 11:59:38
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_QUELLSYSTEM_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   quellsystem_id                      NUMBER(38,0)     NOT NULL COMMENT 'ID des Quellsystems.',
   quellsystem_bez                     VARCHAR(100)     COMMENT 'Bezeichnung des Quellsystems.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_QUELLSYSTEM PRIMARY KEY (mandant_id, quellsystem_id) NOT ENFORCED
)  COMMENT = 'Beinhaltet die IDs der Quellsysteme.';
