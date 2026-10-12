--==============================================================
-- Table: amx_l_handlung_typ_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_l_handlung_typ_2
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:36 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_L_HANDLUNG_TYP_2 (
   amx_handlung_typ_id                 INTEGER     NOT NULL COMMENT 'Eindeutige ID des Handlungstyps aus dem Quellfeld ID',
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex',
   amx_handlung_typ_bez                VARCHAR(255)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung des Handlungstyps aus dem Quellfeld name, z.Bsp. Bewertungsfrage',
   amx_grp_id                          INTEGER     COMMENT 'Gruppierung zusammengehöriger Elemente aus den unterschiedlichen AMX Systemen
            ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_L_HANDLUNG_TYP PRIMARY KEY (amx_handlung_typ_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'VIS audimex - Lookup Tabelle derHandlungs-Typen aus der Quelltabelle checklist_logic';

