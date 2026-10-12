--==============================================================
-- Table: amx_l_kapitel_typ
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_l_kapitel_typ
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_L_KAPITEL_TYP (
   kapitel_typ_id                      INTEGER     NOT NULL COMMENT 'Eindeutige ID des Prüfprogrammtyps aus dem Quellfeld id',
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex',
   kapitel_typ_bez                     VARCHAR(255)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung des prüfprogrammtyps aus dem Quellfeld name',
   amx_grp_id                          INTEGER     COMMENT 'Gruppierung zusammengehöriger Elemente aus den unterschiedlichen AMX Systemen
            ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_L_KAPITEL_TYP PRIMARY KEY (kapitel_typ_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'VIS audimex - Lookup Tabelle der Prüf-Programm-Typen aus der Quelltabelle audimex.audit_concept_type';

