/* --------------------------------------------------------------------------------
   DDL for table: t_client_block_membership_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:11 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_client_block_membership_2 (
client_block_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='PK Block;'),
client_id_member BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key CLIENT'),
cy_week_deliver_from BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Block member deliver from week;'),
cy_week_deliver_to BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Block member deliver to week;'),
cy_week_advertise_from BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Block member advertise from week;'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (client_block_id, client_id_member, cy_week_deliver_from) NOT ENFORCED
) OPTIONS(description='$Revision: 0000 $ Client block members.             Manually maintained reference data.');