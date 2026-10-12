/* --------------------------------------------------------------------------------
   DDL for table: t_client_block
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:09 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CLIENT_BLOCK (
   client_block_id                     NUMBER(38,0)     NOT NULL COMMENT 'PK Block;',
   client_block_cd                     VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Block code;',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_CLIENT_BLOCK PRIMARY KEY (client_block_id) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $ Client block. Groups clients with common logistics.';

