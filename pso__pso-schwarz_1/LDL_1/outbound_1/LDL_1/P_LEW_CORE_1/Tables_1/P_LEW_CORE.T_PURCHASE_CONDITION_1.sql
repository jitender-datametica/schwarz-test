/* --------------------------------------------------------------------------------
   DDL for table: t_purchase_condition_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_purchase_condition_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
pur_cond_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key PURCHASE CONDITION'),
src_knumh STRING(20)
OPTIONS(description='Nummer des Konditionssatzes; SAP-Retail: konh.knumh; SAP-BW: z_ds_zmmx_v_bw_konhp.knumh'),
application_cd STRING(20)
OPTIONS(description='Applikation: M=Einkauf; SAP-Retail: konh.kappl; SAP-BW: z_ds_zmmx_v_bw_konhp.kappl; ELWIS: t_s_pur_cond.cond_appl'),
condition_type_cd STRING(20)
OPTIONS(description='Konditionsart; SAP-Retail: konh.kschl; SAP-BW: z_ds_zmmx_v_bw_konhp.kschl; ELWIS: t_s_pur_cond.cond_type'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (pur_cond_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. PUCO;              Konditionen aus Applikation Einkauf ("M");             hierbei sind fachlich zu einer Kondition nicht mehr als eine_1 Positionsnr moeglich;             SAP-Retail: konh/konp_1;              SAP-BW: z_ds_zmmx_v_bw_konhp;             ELWIS: t_s_pur_cond(_pos)');