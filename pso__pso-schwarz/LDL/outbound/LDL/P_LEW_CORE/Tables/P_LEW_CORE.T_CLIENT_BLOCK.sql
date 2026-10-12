/* --------------------------------------------------------------------------------
   DDL for table: t_client_block
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:09 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_client_block (
client_block_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='PK Block;'),
client_block_cd STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Block code;'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (client_block_id) NOT ENFORCED
) OPTIONS(description='$Revision: 0000 $ Client block. Groups clients with common logistics.');