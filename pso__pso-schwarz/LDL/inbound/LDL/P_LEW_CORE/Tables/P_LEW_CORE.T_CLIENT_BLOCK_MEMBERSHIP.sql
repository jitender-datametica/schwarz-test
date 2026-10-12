/* --------------------------------------------------------------------------------
   DDL for table: t_client_block_membership
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:11 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CLIENT_BLOCK_MEMBERSHIP (
   client_block_id                     NUMBER(38,0)     NOT NULL COMMENT 'PK Block;',
   client_id_member                    NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key CLIENT',
   cy_week_deliver_from                NUMBER(38,0)     NOT NULL COMMENT 'Block member deliver from week;',
   cy_week_deliver_to                  NUMBER(38,0)     NOT NULL COMMENT 'Block member deliver to week;',
   cy_week_advertise_from              NUMBER(38,0)     NOT NULL COMMENT 'Block member advertise from week;',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_CLIENT_BLOCK_MEMBERSHIP PRIMARY KEY (client_block_id, client_id_member, cy_week_deliver_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $ Client block members.
             Manually maintained reference data.';

