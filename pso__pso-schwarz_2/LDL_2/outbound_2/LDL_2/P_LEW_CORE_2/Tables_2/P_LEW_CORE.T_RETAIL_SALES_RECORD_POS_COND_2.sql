/* --------------------------------------------------------------------------------
   DDL for table: t_retail_sales_record_pos_cond_2
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_retail_sales_record_pos_cond_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
retail_sales_record_id NUMERIC(20,0) NOT NULL
OPTIONS(description='Faktura; SAP-BW: t_bw_2lis_13_vdkon.vbeln; ELWIS: t_s_retail_sales_rec_pos_cond.sales_rec_nr'),
retail_sales_record_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fakturaposition; SAP-BW: t_bw_2lis_13_vdkon.posnr; ELWIS: t_s_retail_sales_rec_pos_cond.sales_rec_pos_nr'),
cond_type_cd STRING(20) NOT NULL
OPTIONS(description='Konditionsart; SAP-BW: t_bw_2lis_13_vdkon.kschl; ELWIS: t_s_retail_sales_rec_pos_cond.cond_type_cd'),
cond_rec_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Zahler Konditionen; SAP-BW: t_bw_2lis_13_vdkon.zaehk; ELWIS: t_s_retail_sales_rec_pos_cond.cond_rec_id'),
curr_sid BIGNUMERIC(38,0)
OPTIONS(description='Wahrung; FK auf CURRENCY; SAP-BW; t_bw_2lis_13_vdkon.WAERS; ELWIS: curr_sid'),
uom_sid BIGNUMERIC(38,0)
OPTIONS(description='Basis-Mengeneinheit; FK auf UNIT_2 OF MEASUREMENT; SAP-BW: t_bw_2lis_13_vdkon.MEINS'),
curr_cd STRING(20) OPTIONS(description='Wahrungscode; SAP-BW; t_bw_2lis_13_vdkon.WAERS; ELWIS: curr_sid'),
cond_val NUMERIC(18,5) OPTIONS(description='Konditionsbetrag; SAP-BW: t_bw_2lis_13_vdkon.KBETR; ELWIS: cond_sales_amt'),
gross_val NUMERIC(18,5) OPTIONS(description='Bruttobetrag der Fakturaposition; SAP-BW: t_bw_2lis_13_vdkon.KAWRT;'),
tax_val NUMERIC(18,5) OPTIONS(description='Steuerbetrag; SAP-BW: t_bw_2lis_13_vdkon.MWSBP;'),
net_val NUMERIC(18,5) OPTIONS(description='Nettobetrag der Fakturaposition: total_sales_val - tax_sales_val'),
uom_cd STRING(20) OPTIONS(description='Basis-Mengeneinheit; SAP-BW: t_bw_2lis_13_vdkon.MEINS'),
act_qty NUMERIC(18,5) OPTIONS(description='Tatsachlich fakturierte Menge; SAP-BW: t_bw_2lis_13_vdkon.FKIMG'),
lme_qty NUMERIC(18,5) OPTIONS(description='Fakturamenge in LME; SAP-BW: t_bw_2lis_13_vdkon.FKLMG'),
dwh_cal_dt DATE NOT NULL
OPTIONS(description='Verkaufsdatum/Fakruradatum/Rechnungdatum; SAP-BW: t_bw_2lis_13_vdkon.FKDAT; ELWIS: invoice_dat'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, retail_sales_record_id, retail_sales_record_pos_id, cond_type_cd, cond_rec_id) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id
OPTIONS(description='$Revision: 0000 $. RESC; Preisfindung Kommunikations-Konditionssatz;             SAP-Retail: ?;             SAP-BW: t_bw_2lis_13_vdkon;             ELWIS: t_s_retail_sales_rec_pos_cond;             WAWI: ');