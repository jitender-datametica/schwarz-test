/* --------------------------------------------------------------------------------
   DDL for table: t_ref_return_reason_descr_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_return_reason_descr_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
return_reason_cd STRING(20) NOT NULL
OPTIONS(description='Retoure-Grund Code; SAP-Retail: zmmx_cust14t.ret_reason_key; SAP-BW: t_bw_z_ds_zmmx_cust14t.ret_reason_k; ELWIS: t_r_ret_reason_descr.ret_reason_cd'),
lang_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Sprache; FK auf REPORT LANGUAGE; SAP-Retail: zmmx_cust14t.spras; SAP-BW: t_bw_z_ds_zmmx_cust14t.spras; ELWIS: t_r_ret_reason_descr.lang_cd'),
lang_cd STRING(20)
OPTIONS(description='Sprache - Code; SAP-Retail: zmmx_cust14t.ret_reason_descr; SAP-BW: t_bw_z_ds_zmmx_cust14t.spras; ELWIS: t_r_ret_reason_descr.lang_cd'),
return_reason_descr STRING(100) COLLATE 'und:ci'
OPTIONS(description='Retouren-Grund Beschreibung; SAP-Retail: zmmx_cust14t.ret_reason_descr; SAP-BW: t_bw_z_ds_zmmx_cust14t.ret_reason_descr; ELWIS: t_r_ret_reason_descr.descr'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, return_reason_cd, lang_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. Retouren-Gruende - Bezeichnungen;             SAP-Retail: zmmx_cust14t;             SAP-BW: t_bw_z_ds_zmmx_cust14t;             ELWIS: t_r_ret_reason_descr');