--==============================================================
-- Table: amx_l_pruef_feld_typ_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_l_pruef_feld_typ_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_L_PRUEF_FELD_TYP_1 (
   pruef_feld_typ_id                   INTEGER     NOT NULL COMMENT 'Eindeutige ID eines Prüffeld-Typs aus der Quelle id',
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex',
   pruef_feld_typ_bez                  VARCHAR(255)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung des Prüffeldtyps aus der Quellspalte name, z.Bsp. K_Filiale',
   pruef_feld_typ_typ_id               INTEGER     NOT NULL DEFAULT -1 COMMENT 'Klassifizierung des Prüffeld-Typs aus dem Quellfeld type_tag. Lookup Tabelle in der Quelle  vorhanden, aber nicht angefordert',
   amx_grp_id                          INTEGER     COMMENT 'Gruppierung zusammengehöriger Elemente aus den unterschiedlichen AMX Systemen
            ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_L_PRUEF_FELD_TYP PRIMARY KEY (pruef_feld_typ_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'VIS audimex - Lookup Tabelle der Prüffeld-Typen aus der Quelltabelle audimex.audit_uni_type';

