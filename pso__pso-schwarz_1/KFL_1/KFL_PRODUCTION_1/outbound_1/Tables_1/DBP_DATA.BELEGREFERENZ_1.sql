--==============================================================
-- Table: belegreferenz_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belegreferenz_1
   generated from Powerdesigner on Freitag, 12. Januar 2024 12:51:34
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.belegreferenz_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
beleg_guid STRING(32) NOT NULL OPTIONS(description='Beleg-ID'),
beleg_pos_guid STRING(32) NOT NULL OPTIONS(description='Position-ID'),
referenz_belegtyp_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Referenzbelegtyp'),
referenzbeleg_guid STRING(32) NOT NULL OPTIONS(description='Referenzbeleg-ID'),
referenzbeleg_pos_guid STRING(32) NOT NULL OPTIONS(description='Referenzpositions-ID'),
referenzbeleg_id STRING(35) COLLATE 'und:ci' OPTIONS(description='Referenzbelegnummer'),
belegtyp_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Belegtyp'),
referenz_bs_id STRING(60) COLLATE 'und:ci' OPTIONS(description='Schlüsselname Business System'),
partner_guid STRING(32) OPTIONS(description='Partner-ID'),
referenzbeleg_pos_id BIGNUMERIC(38,0) OPTIONS(description='Referenzpositionsnummer'),
zeitzone STRING(6) COLLATE 'und:ci' OPTIONS(description='Zeitzone'),
datzeit_termin_beginn DATETIME OPTIONS(description='Termin Beginn'),
datzeit_termin_ende DATETIME OPTIONS(description='Termin Ende'),
datzeit_erstellung DATETIME
OPTIONS(description='Erstellungszeitpunkt des Belegs, Quellspalte = CRETST, Quelltabelle abhängig vom Belegtyp: PDI = /SCDL/DB_PROCH_I, PDO = /SCDL/DB_PROCH_O, FDO = /SCDL/DB_DLVH_O (The column does not contain timezone, but the value of the timestamp is in the timezone of the mandant_1)'),
datzeit_aenderung DATETIME
OPTIONS(description='Änderungszeitpunkt des Belegs, Quellspalte = CHTST, Quelltabelle abhängig vom Belegtyp: PDI = /SCDL/DB_PROCH_I, PDO = /SCDL/DB_PROCH_O, FDO = /SCDL/DB_DLVH_O (The column does not contain timezone, but the value of the timestamp is in the timezone of the mandant_1)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, beleg_guid, beleg_pos_guid, referenzbeleg_guid, referenzbeleg_pos_guid) NOT ENFORCED
) OPTIONS(description='Belegreferenz_1 EWM');