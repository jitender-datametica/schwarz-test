/* --------------------------------------------------------------------------------
   DDL for table: t_ref_pos_payment_type_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_pos_payment_type_1 (
payment_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutiger ID fuer Payment-Type'),
payment_type_descr STRING(100) COLLATE 'und:ci' NOT NULL OPTIONS(description='Beschreibung fuer Payment-Type ID'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (payment_type_id) NOT ENFORCED
)
OPTIONS(description='$Revision: 10219 $. Reference table for payment types in the context of Sales_1 (Receiptline) ;             WAWI: t_ref_ejr_xml_paymenttypes');