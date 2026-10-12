/* --------------------------------------------------------------------------------
   DDL for table: t_packaging_type_2
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_packaging_type_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
pack_type_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key PACKAGING TYPE'),
src_zz_pack_type STRING(20)
OPTIONS(description='Verpackungstyp-Code; SAP-Retail: zlax008_cust4.zz_pack_type; SAP-BW: t_bw_z_ds_zlax008_cust4t.zz_pack_type'),
pack_type_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung des Verpackungstyps in Stiftuungssprache; SAP-Retail: zlax008_cust4t.description; SAP-BW: t_bw_z_ds_zlax008_cust4t.description'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (pack_type_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. PCKT; Verpackungstyp; z.B. "Dose", "Eimer", "Kiste", "Lose", etc.             SAP-Retail: zlax008_cust4;             SAP-BW: t_bw_z_ds_zlax008_cust4t;             ELWIS: t_r_itm_package_type;             WAWI: t_ref_itm_logist_unit');