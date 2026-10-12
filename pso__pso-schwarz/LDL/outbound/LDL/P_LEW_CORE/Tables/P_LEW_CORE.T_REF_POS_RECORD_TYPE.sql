/* --------------------------------------------------------------------------------
   DDL for table: t_ref_pos_record_type
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_pos_record_type (
record_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutiger ID fuer Record-Type'),
record_type_context_cd STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kontext in dem record_type_id verwendet wird: AU: Audit, SL: Statistic, TI: Time, TX: Tax'),
record_type_descr STRING(100) COLLATE 'und:ci' NOT NULL OPTIONS(description='Beschreibung fuer Record-Type ID'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (record_type_id) NOT ENFORCED
)
OPTIONS(description='$Revision: 10219 $. Reference table for record types in the context of Sales(Receiptline);             In different context the record_type_id is named differently,e.g. AU: audit_type_id, SL: statistic_id, TX: tax_class_cd, TI: ti_cd;             WAWI: t_ref_ejr_xml_recordtypes');