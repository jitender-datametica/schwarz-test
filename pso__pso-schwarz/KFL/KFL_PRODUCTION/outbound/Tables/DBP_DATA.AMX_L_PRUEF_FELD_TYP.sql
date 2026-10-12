--==============================================================
-- Table: amx_l_pruef_feld_typ
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_l_pruef_feld_typ
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.amx_l_pruef_feld_typ (
pruef_feld_typ_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID eines Prüffeld-Typs aus der Quelle id'),
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
pruef_feld_typ_bez STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung des Prüffeldtyps aus der Quellspalte name, z.Bsp. K_Filiale'),
pruef_feld_typ_typ_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Klassifizierung des Prüffeld-Typs aus dem Quellfeld type_tag. Lookup Tabelle in der Quelle  vorhanden, aber nicht angefordert'),
amx_grp_id BIGNUMERIC(38,0)
OPTIONS(description='Gruppierung zusammengehöriger Elemente aus den unterschiedlichen AMX Systemen            '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (pruef_feld_typ_id, amx_system_id) NOT ENFORCED
) OPTIONS(description='VIS audimex - Lookup Tabelle der Prüffeld-Typen aus der Quelltabelle audimex.audit_uni_type');