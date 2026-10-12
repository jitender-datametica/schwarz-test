/* --------------------------------------------------------------------------------
   DDL for table: t_ref_pos_record_qualifier_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_pos_record_qualifier_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
record_qualifier_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Record-Qualifier - ID'),
record_qualifier_descr STRING(100) COLLATE 'und:ci' OPTIONS(description='Record-Qualifier - Beschreibung'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, record_qualifier_id) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. Lookup-Tabelle fuer die record_qualifier_id aus SAP-CAR angelieferten Records;             aktuell manuelle Befuellung');