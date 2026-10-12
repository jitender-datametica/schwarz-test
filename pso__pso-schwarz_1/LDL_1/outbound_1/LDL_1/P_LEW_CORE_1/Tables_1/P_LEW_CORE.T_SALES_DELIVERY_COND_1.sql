/* --------------------------------------------------------------------------------
   DDL for table: t_sales_delivery_cond_1
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_sales_delivery_cond_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
sales_invoice_record_cd STRING(20) NOT NULL
OPTIONS(description='Faktura; SAP-BW: t_bw_2lis_13_vdkon.vbeln; ELWIS: t_s_retail_sales_rec_pos_cond.sales_rec_nr'),
sales_invoice_record_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fakturaposition; SAP-BW: t_bw_2lis_13_vdkon.posnr; ELWIS: t_s_retail_sales_rec_pos_cond.sales_rec_pos_nr'),
cond_type_cd STRING(20) NOT NULL
OPTIONS(description='Konditionsart; SAP-BW: t_bw_2lis_13_vdkon.kschl; ELWIS: t_s_retail_sales_rec_pos_cond.cond_type_cd'),
cond_rec_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Zahler Konditionen; SAP-BW: t_bw_2lis_13_vdkon.zaehk; ELWIS: t_s_retail_sales_rec_pos_cond.cond_rec_id'),
curr_sid BIGNUMERIC(38,0)
OPTIONS(description='Waehrung; FK auf CURRENCY; SAP-BW; t_bw_2lis_13_vdkon.waers; ELWIS: t_s_retail_sales_rec_pos_cond.curr_sid'),
uom_sid BIGNUMERIC(38,0)
OPTIONS(description='Basis-Mengeneinheit; FK auf UNIT_1 OF MEASUREMENT; SAP-BW: t_bw_2lis_13_vdkon.meins'),
curr_cd STRING(20) OPTIONS(description='Wahrungscode; SAP-BW; t_bw_2lis_13_vdkon.waers'),
cond_val NUMERIC(18,5)
OPTIONS(description='Konditionsbetrag; SAP-BW: t_bw_2lis_13_vdkon.kbetr; ELWIS: t_s_retail_sales_rec_pos_cond.cond_sales_amt'),
cond_pct_val NUMERIC(18,5) OPTIONS(description='Konditionsprozentsatz = kbetr/10; SAP-BW: t_bw_2lis_13_vdkon.kbetr; '),
gross_val NUMERIC(18,5)
OPTIONS(description='Bruttobetrag der Fakturaposition; SAP-BW: t_bw_2lis_13_vdkon.kawrt; ELWIS: t_s_retail_sales_rec_pos_cond.gross_val'),
tax_val NUMERIC(18,5)
OPTIONS(description='Steuerbetrag; SAP-BW: t_bw_2lis_13_vdkon.mwsbp; ELWIS: t_s_retail_sales_rec_pos_cond.tax_val'),
net_val NUMERIC(18,5)
OPTIONS(description='Nettobetrag der Fakturaposition: total_sales_val - tax_sales_val; ELWIS: t_s_retail_sales_rec_pos_cond.net_val'),
uom_cd STRING(20) OPTIONS(description='Basis-Mengeneinheit; SAP-BW: t_bw_2lis_13_vdkon.meins'),
qty_act NUMERIC(18,5)
OPTIONS(description='Tatsaechlich fakturierte Menge; SAP-BW: t_bw_2lis_13_vdkon.fkimg; ELWIS: t_s_retail_sales_rec_pos_cond.act_qty'),
qty_stock_unit NUMERIC(18,5)
OPTIONS(description='Fakturamenge in LME; SAP-BW: t_bw_2lis_13_vdkon.fklmg; ELWIS: t_s_retail_sales_rec_pos_cond.lme_qty'),
sales_invoice_dt DATE OPTIONS(description='Rechnungsdatum; SAP-Retail: vbrk.fkdat; SAP-BW: t_bw_2lis_13_vditm.fkdat'),
sales_delivery_dt DATE
OPTIONS(description='Buchungsdatum des Warenausgangs; SAP-Retail: vbrp.fbuda; SAP-BW: t_bw_2lis_13_vditm.fbuda'),
dwh_cal_dt DATE NOT NULL
OPTIONS(description='Verkaufsdatum/Fakruradatum/Rechnungdatum; SAP-BW: t_bw_2lis_13_vdkon.fkdat; ELWIS: t_s_retail_sales_rec_pos_cond.invoice_dat'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, sales_invoice_record_cd, sales_invoice_record_pos_id, cond_type_cd, cond_rec_id) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id
OPTIONS(description='$Revision: 0000 $. RESC; Preisfindung Kommunikations-Konditionssatz;             SAP-Retail: ?;             SAP-BW: t_bw_2lis_13_vdkon;             ELWIS: t_s_retail_sales_rec_pos_cond;             WAWI: ');