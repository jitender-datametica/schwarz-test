--==============================================================
-- Table: auslieferposition_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: auslieferposition_1
   generated from Powerdesigner on Wednesday, June 8, 2022 1:34:06 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.auslieferposition_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
beleg_guid STRING(32) NOT NULL OPTIONS(description='Beleg-ID.'),
beleg_pos_guid STRING(32) NOT NULL OPTIONS(description='Positions-ID.'),
belegtyp_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Belegtyp.'),
beleg_id BIGNUMERIC(35,0) OPTIONS(description='Belegnummer.'),
manuell_erzeugt_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Manuell erzeugt.'),
beleg_pos_id BIGNUMERIC(38,0) OPTIONS(description='Positionsnummer.'),
tor_id STRING(4) COLLATE 'und:ci' OPTIONS(description='Lagertor.'),
datzeit_erstellung DATETIME OPTIONS(description='Anlagetimestamp.'),
datzeit_aenderung DATETIME OPTIONS(description='Aenderungstimestamp.'),
dat_lief_soll DATE OPTIONS(description='Lieferdatum (GI = Goods Issue).'),
zeit_lief_soll TIME OPTIONS(description='Uhrzeit zum Lieferdatum (GI = Goods Issue).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, beleg_guid, beleg_pos_guid) NOT ENFORCED
) OPTIONS(description='Outbound Delivery Order Item.');