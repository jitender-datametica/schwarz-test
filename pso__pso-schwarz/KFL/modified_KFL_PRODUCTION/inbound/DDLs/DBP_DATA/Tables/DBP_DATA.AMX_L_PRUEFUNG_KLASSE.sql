--==============================================================
-- Table: amx_l_pruefung_klasse
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_l_pruefung_klasse
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_L_PRUEFUNG_KLASSE (
   pruefung_klasse_id                  INTEGER     NOT NULL COMMENT 'Eindeutige ID der Prüfungsklasse aus dem Quellfeld ID',
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex',
   pruefung_klasse_bez                 VARCHAR(50)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung der Prüfungsklasse aus dem Quellfeld name, z.Bsp. Revision Vertrieb',
   amx_grp_id                          INTEGER     COMMENT 'Gruppierung zusammengehöriger Elemente aus den unterschiedlichen AMX Systemen
            ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_L_PRUEFUNG_KLASSE PRIMARY KEY (pruefung_klasse_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'VIS audimex - Lookup Tabelle der Prüfungs-Klassen aus der Quelltabelle audimex.auditing_class';

