/* --------------------------------------------------------------------------------
   DDL for table: t_ref_pos_record_type_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_POS_RECORD_TYPE_1 (
   record_type_id                      NUMBER(38,0)     NOT NULL COMMENT 'Eindeutiger ID fuer Record-Type',
   record_type_context_cd              VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Kontext in dem record_type_id verwendet wird: AU: Audit, SL: Statistic, TI: Time, TX: Tax',
   record_type_descr                   VARCHAR(100)     NOT NULL COLLATE 'en-ci' COMMENT 'Beschreibung fuer Record-Type ID',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_POS_RECORD_TYPE PRIMARY KEY (record_type_id) NOT ENFORCED 
)  COMMENT = '$Revision: 10219 $. Reference table for record types in the context of Sales_1(Receiptline);
             In different context the record_type_id is named differently,e.g. AU: audit_type_id, SL: statistic_id, TX: tax_class_cd, TI: ti_cd;
             WAWI: t_ref_ejr_xml_recordtypes';

