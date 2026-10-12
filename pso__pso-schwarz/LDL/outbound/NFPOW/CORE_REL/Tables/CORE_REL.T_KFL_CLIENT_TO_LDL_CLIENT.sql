/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_client_to_ldl_client
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_client_to_ldl_client (
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the KFL client (Mandant) in the Kaufland DWH            KFL: mapping script.'),
tgt_ldl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the Lidl client in the Lidl DWH when data of a Kaufland client has to be mapped to Lidl structures, Kaufland Moldavia here has the target Lidl Romania            KFL: mapping script.'),
src_ldl_client_id BIGNUMERIC(38,0)
OPTIONS(description='identifier of the Lidl client in the Lidl DWH when data of a Lidl client has to be mapped to Kaufland structures, Kaufland Moldavia here has no source on the Lidl side            KFL: mapping script.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (kfl_client_id) NOT ENFORCED
)
OPTIONS(description='This table stores the relations between Kaufland clients (Mandanten) and Lidl clients (client_ids representing the ERP system instances)');