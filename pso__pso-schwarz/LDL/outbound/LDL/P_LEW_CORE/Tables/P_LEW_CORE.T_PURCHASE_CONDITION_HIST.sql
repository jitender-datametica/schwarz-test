/* --------------------------------------------------------------------------------
   DDL for table: t_purchase_condition_hist
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_purchase_condition_hist (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
pur_cond_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key PURCHASE CONDITION'),
curr_sid BIGNUMERIC(38,0)
OPTIONS(description='Waehrung des Konditionsbetrags; FK auf CURRENCY; SAP-Retail: konp.konwa; SAP-BW: z_ds_zmmx_v_bw_konhp.konwa; ELWIS Name: t_s_pur_cond_pos.cond_am'),
condition_pos_nr BIGNUMERIC(38,0)
OPTIONS(description='Positionsnr. im Quellsystem - im Applikationsbereich Einkauf gibt es nur eine Pos pro knumh; SAP-Retail: konp.kopos; SAP-BW: z_ds_zmmx_v_bw_konhp.kopos'),
curr_cd STRING(20)
OPTIONS(description='Waehrungscode des Konditionsbetrags; SAP-Retail: konp.konwa; SAP-BW: z_ds_zmmx_v_bw_konhp.konwa; ELWIS: t_s_pur_cond_pos.cond_am'),
condition_val NUMERIC(18,5)
OPTIONS(description='Konditionsbetrag; SAP-Retail: konp.kbetr; SAP-BW: z_ds_zmmx_v_bw_konhp.kbetr; ELWIS: t_s_pur_cond_pos.cond_amt '),
condition_pct_val NUMERIC(18,5)
OPTIONS(description='Konditionsprozentsatz = kbetr/10; SAP-Retail: konp.kbetr; SAP-BW: z_ds_zmmx_v_bw_konhp.kbetr; ELWIS: t_s_pur_cond_pos.cond_amt '),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Pinfo-Detail ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status angenommen; SAP-Retail: eine.loekz'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (pur_cond_sid, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. PUCOH;              Konditionen aus Applikation Einkauf ("M");             hierbei sind fachlich zu einer Kondition nicht mehr als eine Positionsnr moeglich;             SAP-Retail: konh/konp;              SAP-BW: z_ds_zmmx_v_bw_konhp;             ELWIS: t_s_pur_cond(_pos)');