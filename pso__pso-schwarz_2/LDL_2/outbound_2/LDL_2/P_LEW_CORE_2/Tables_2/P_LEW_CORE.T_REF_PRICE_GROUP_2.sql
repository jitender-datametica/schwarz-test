/* --------------------------------------------------------------------------------
   DDL for table: t_ref_price_group_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_price_group_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
price_group_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ELWIS: t_s_prcs_grp.prcs_grp_cd'),
price_group_name STRING(100) COLLATE 'und:ci' OPTIONS(description='ELWIS: t_r_prcs_grp_descr.prcs_grp_descr'),
price_group_prio BIGNUMERIC(38,0) OPTIONS(description='ELWIS: t_s_prcs_grp.prcs_grp_prio'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, price_group_id) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $.              manualy maintained lookup table;             ELWIS: t_s_prcs_grp, t_r_prcs_grp_descr;');