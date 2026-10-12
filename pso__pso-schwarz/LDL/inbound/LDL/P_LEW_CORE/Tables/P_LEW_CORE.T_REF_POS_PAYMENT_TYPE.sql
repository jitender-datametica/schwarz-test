/* --------------------------------------------------------------------------------
   DDL for table: t_ref_pos_payment_type
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_POS_PAYMENT_TYPE (
   payment_type_id                     NUMBER(38,0)     NOT NULL COMMENT 'Eindeutiger ID fuer Payment-Type',
   payment_type_descr                  VARCHAR(100)     NOT NULL COLLATE 'en-ci' COMMENT 'Beschreibung fuer Payment-Type ID',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_POS_PAYMENT_TYPE PRIMARY KEY (payment_type_id) NOT ENFORCED 
)  COMMENT = '$Revision: 10219 $. Reference table for payment types in the context of Sales (Receiptline) ;
             WAWI: t_ref_ejr_xml_paymenttypes';

