--==============================================================
-- Table: amx_l_hauptbereich
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_l_hauptbereich
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:36 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_L_HAUPTBEREICH (
   hauptbereich_id                     INTEGER     NOT NULL COMMENT 'Eindeutige ID eines Hauptbereichs aus dem Quellfeld topic.id',
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex',
   hauptbereich_bez                    VARCHAR(255)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'bezeichnung des Hauptbereichs aus der Spalte name, z.Bsp. FR_Frische SB',
   amx_grp_id                          INTEGER     COMMENT 'Gruppierung zusammengehöriger Elemente aus den unterschiedlichen AMX Systemen
            ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_L_HAUPTBEREICH PRIMARY KEY (hauptbereich_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'VIS audimex - Lookup Tabelle der Hauptbereiche aus der Quelltabelle audimex.topic';

