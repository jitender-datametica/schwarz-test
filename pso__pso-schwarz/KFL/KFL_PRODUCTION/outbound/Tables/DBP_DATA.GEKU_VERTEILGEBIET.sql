--==============================================================
-- Table: geku_verteilgebiet
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_verteilgebiet
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_verteilgebiet (
verteilgebiet_uid INTEGER NOT NULL OPTIONS(description='Eindeutige ID des Verteilgebiets'),
gebietsleiter_uid INTEGER NOT NULL OPTIONS(description='Eindeutige ID des Gebietsleiters aus pc_nr'),
verteilgebiet_bez STRING(60) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Verteilgebiets'),
mandant_id BIGNUMERIC(38,0) OPTIONS(description='Mandant im DWH. Gehört zum NILS Verteilgebiet'),
nils_verteilgebiet_id BIGNUMERIC(38,0)
OPTIONS(description='Verteilgebiet ID aus dem System NILS. Wird per Transaction Service oder GEKU-SST gepflegt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (verteilgebiet_uid) NOT ENFORCED
) OPTIONS(description='GEKU - Lookup-Tabelle der Verteilgebiete aus wmd_vg_out');