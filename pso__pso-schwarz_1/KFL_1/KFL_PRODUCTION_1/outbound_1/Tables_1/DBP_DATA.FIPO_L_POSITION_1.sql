--==============================================================
-- Table: fipo_l_position_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_l_position_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fipo_l_position_1 (
fipo_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID einer FIPO-Position aus dem Quellfeld pos_id'),
fipo_pos_kbez STRING(10) COLLATE 'und:ci' DEFAULT '          ' NOT NULL
OPTIONS(description='Kurzbezeichnung der FIPO_Position aus dem Quellfeld pos_kuerzel, z.Bsp. HL_1, VKL_1'),
fipo_pos_nr BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Nummer einer Position'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (fipo_pos_id) NOT ENFORCED
) OPTIONS(description='FIPO - Lookup Tabelle der FIPO-Positionen aus der Quelltabelle positionen');