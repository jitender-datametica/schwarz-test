/* --------------------------------------------------------------------------------
   DDL for table: t_ref_return_reason_descr_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_RETURN_REASON_DESCR_1 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   return_reason_cd                    VARCHAR(20)      NOT NULL COMMENT 'Retoure-Grund Code; SAP-Retail: zmmx_cust14t.ret_reason_key; SAP-BW: t_bw_z_ds_zmmx_cust14t.ret_reason_k; ELWIS: t_r_ret_reason_descr.ret_reason_cd',
   lang_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Sprache; FK auf REPORT LANGUAGE; SAP-Retail: zmmx_cust14t.spras; SAP-BW: t_bw_z_ds_zmmx_cust14t.spras; ELWIS: t_r_ret_reason_descr.lang_cd',
   lang_cd                             VARCHAR(20)      COMMENT 'Sprache - Code; SAP-Retail: zmmx_cust14t.ret_reason_descr; SAP-BW: t_bw_z_ds_zmmx_cust14t.spras; ELWIS: t_r_ret_reason_descr.lang_cd',
   return_reason_descr                 VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Retouren-Grund Beschreibung; SAP-Retail: zmmx_cust14t.ret_reason_descr; SAP-BW: t_bw_z_ds_zmmx_cust14t.ret_reason_descr; ELWIS: t_r_ret_reason_descr.descr',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_RETURN_REASON_DESCR PRIMARY KEY (client_id, return_reason_cd, lang_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Retouren-Gruende - Bezeichnungen;
             SAP-Retail: zmmx_cust14t;
             SAP-BW: t_bw_z_ds_zmmx_cust14t;
             ELWIS: t_r_ret_reason_descr';

