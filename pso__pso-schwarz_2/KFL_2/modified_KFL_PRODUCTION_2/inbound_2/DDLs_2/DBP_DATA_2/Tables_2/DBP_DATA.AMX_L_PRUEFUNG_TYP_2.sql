--==============================================================
-- Table: amx_l_pruefung_typ_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_l_pruefung_typ_2
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:36 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_L_PRUEFUNG_TYP_2 (
   pruefung_typ_id                     INTEGER     NOT NULL COMMENT 'Eindeutige ID des Prüfungstyps aus dem Quellfeld ID',
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex',
   pruefung_typ_bez                    VARCHAR(50)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung des Prüfungstyps aus dem Quellfeld name, z.Bsp. Standard',
   ad_hoc_fg                           INTEGER     NOT NULL DEFAULT 0 COMMENT 'Flag legt fest, ob es sich um einen ad_hoc - Prüfungstyp handelt.Aus dem Quellfeld is_ad_hoc',
   amx_grp_id                          INTEGER     COMMENT 'Gruppierung zusammengehöriger Elemente aus den unterschiedlichen AMX Systemen
            ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_L_PRUEFUNG_TYP PRIMARY KEY (pruefung_typ_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'VIS audimex - Lookup Tabelle der Prüfungs-Typen aus der Quelltabelle audimex.auditing_type';

