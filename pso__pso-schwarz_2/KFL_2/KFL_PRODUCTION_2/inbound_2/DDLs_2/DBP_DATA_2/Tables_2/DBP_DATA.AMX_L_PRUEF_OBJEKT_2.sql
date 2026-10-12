--==============================================================
-- Table: amx_l_pruef_objekt_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_l_pruef_objekt_2
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_L_PRUEF_OBJEKT_2 (
   business_unit_id                    NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'ID der organisatorischen Einheit.Verweis auf ein Prüffeld mit dem Typ Stelle.  Aus dem Quellfeld business_unit_id bzw. audit_universe.id',
   amx_system_id                       NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex',
   business_unit_bez                   VARCHAR(255)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Die Bezeichnung (der Name) des Prüffeldes aus der Quellspalte name, z.Bsp. CZ6700_Kaufland Klatovy, FR_Themen',
   pruef_feld_typ_id                   NUMBER(38,0)     COMMENT 'Eindeutige ID eines Prüffeld-Typs aus der Quelle id',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH. Aus den ersten Zeichen vonaudit_universe.imp_reference (Länderkennung) ermittelt',
   in_matrix_pruefgebiete_fg           NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Flag aus dem Quellfeld shows_up_in_dimension',
   aktiv_fg                            NUMBER(38,0)     NOT NULL DEFAULT 1 COMMENT 'Flag zeigt an, ob das Prüffeld aktiv ist. Aus dem Quellfeld active',
   amx_grp_id                          NUMBER(38,0)     COMMENT 'Gruppierung zusammengehöriger Elemente aus den unterschiedlichen AMX Systemen
            ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_L_PRUEF_OBJEKT PRIMARY KEY (business_unit_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'KMR - audimex - Lookup Tabelle der Prüf-Objekte. Wird im DWH gebildet';

