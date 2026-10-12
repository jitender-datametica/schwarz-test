--==============================================================
-- Table: amx_l_zustand
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_l_zustand
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:36 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_L_ZUSTAND (
   zustand_id                          NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID eines Zustands aus dem Quellfeld wal_state.nr',
   amx_system_id                       NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex',
   zustand_bez                         VARCHAR(255)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung des Zustandes aus dem Quellfeld name',
   amx_grp_id                          NUMBER(38,0)     COMMENT 'Gruppierung zusammengehöriger Elemente aus den unterschiedlichen AMX Systemen
            ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_L_ZUSTAND PRIMARY KEY (zustand_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'VIS audimex - Lookup Tabelle der Zustände aus der Quelltabelle audimex.wal_state';

