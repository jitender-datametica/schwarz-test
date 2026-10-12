--==============================================================
-- Table: amx_l_hauptbereich_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_l_hauptbereich_2
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:36 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.amx_l_hauptbereich_2 (
hauptbereich_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID eines Hauptbereichs aus dem Quellfeld topic.id'),
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Unterscheidung zw. Den unterschiedlichen AMX Systemen. 1 = OneAudimex / 2 = KL Audimex'),
hauptbereich_bez STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='bezeichnung des Hauptbereichs aus der Spalte name, z.Bsp. FR_Frische SB'),
amx_grp_id BIGNUMERIC(38,0)
OPTIONS(description='Gruppierung zusammengehöriger Elemente aus den unterschiedlichen AMX Systemen            '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (hauptbereich_id, amx_system_id) NOT ENFORCED
) OPTIONS(description='VIS audimex - Lookup Tabelle der Hauptbereiche aus der Quelltabelle audimex.topic');