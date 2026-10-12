/* --------------------------------------------------------------------------------
   DDL for table: t_ref_pos_transaction_type_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_pos_transaction_type_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
transaction_type_cd STRING(20) NOT NULL
OPTIONS(description='SAP-CAR: /posdw/tranty/TRANSACTIONTYPECODE; siehe t_logf.transtypecode'),
transaction_type_descr STRING(100) COLLATE 'und:ci'
OPTIONS(description='Beschreibung des POS Transaktionstyps in Stiftungssprache; SAP-CAR: /posdw/trantyt/DESCRIPTION'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, transaction_type_cd) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. Lookup-Tab fuer die transactiontype_id aus SAP-CAR angelieferten Records;             aktuell manuelle Befuellung             SAP-CAR: /POSDW/TRANTY & /POSDW/TRANTYT;             Hinweis: Tab vermutlich noch nicht korrekt: profiltype im Quellsystem Schlusselbestandteil');