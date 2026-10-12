--==============================================================
-- Table: amx_l_pruef_objekt_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_l_pruef_objekt_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.amx_l_pruef_objekt_1 (
business_unit_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='ID der organisatorischen Einheit.Verweis auf ein Prüffeld mit dem Typ Stelle.  Aus dem Quellfeld business_unit_id bzw. audit_universe.id'),
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
business_unit_bez STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Die Bezeichnung (der Name) des Prüffeldes aus der Quellspalte name, z.Bsp. CZ6700_Kaufland Klatovy, FR_Themen'),
pruef_feld_typ_id BIGNUMERIC(38,0) OPTIONS(description='Eindeutige ID eines Prüffeld-Typs aus der Quelle id'),
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mandant_1 im DWH. Aus den ersten Zeichen vonaudit_universe.imp_reference (Länderkennung) ermittelt'),
in_matrix_pruefgebiete_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag aus dem Quellfeld shows_up_in_dimension'),
aktiv_fg BIGNUMERIC(38,0) DEFAULT 1 NOT NULL
OPTIONS(description='Flag zeigt an, ob das Prüffeld aktiv ist. Aus dem Quellfeld active'),
amx_grp_id BIGNUMERIC(38,0)
OPTIONS(description='Gruppierung zusammengehöriger Elemente aus den unterschiedlichen AMX Systemen            '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (business_unit_id, amx_system_id) NOT ENFORCED
) OPTIONS(description='KMR - audimex - Lookup Tabelle der Prüf-Objekte. Wird im DWH gebildet');