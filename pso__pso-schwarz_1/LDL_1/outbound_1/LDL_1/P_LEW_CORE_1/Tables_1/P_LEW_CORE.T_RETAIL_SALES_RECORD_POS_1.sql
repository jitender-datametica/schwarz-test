/* --------------------------------------------------------------------------------
   DDL for table: t_retail_sales_record_pos_1
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_retail_sales_record_pos_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
retail_sales_record_id NUMERIC(20,0) NOT NULL
OPTIONS(description='Faktura; SAP-Retail: vbrp.vbeln; SAP-BW: t_bw_2lis_13_vditm.vbeln; ELWIS: t_s_retail_sales_record_pos.sales_rec_nr'),
retail_sales_record_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fakturaposition; SAP-Retail: vbrp.posnr; SAP-BW: t_bw_2lis_13_vditm.posnr; ELWIS: t_s_retail_sales_record_pos.sales_rec_pos_nr'),
item_sid BIGNUMERIC(38,0)
OPTIONS(description='Artikel_1; FK auf ITEM_1; SAP-Retail: vbrp.matnr; SAP-BW: t_bw_2lis_13_vditm.matnr'),
loc_sid BIGNUMERIC(38,0)
OPTIONS(description='Betrieb; FK auf LOCATION_1; SAP-Retail: vbrp.werks; SAP-BW: t_bw_2lis_13_vditm.werks'),
uom_sid BIGNUMERIC(38,0)
OPTIONS(description='Verkaufsmengeneinheit; FK auf UNIT_1 OF MEASUREMENT; SAP-Retail: vbrp.vrkme; SAP-BW: t_bw_2lis_13_vditm.vrkme'),
curr_sid BIGNUMERIC(38,0)
OPTIONS(description='Belegwaehrung; FK auf CURRENCY; SAP-Retail: vbrk.waerk; SAP-BW: t_bw_2lis_13_vditm.waerk'),
uom_cd STRING(20) OPTIONS(description='Verkaufsmengeneinheit; SAP-Retail: vbrp.vrkme; SAP-BW: t_bw_2lis_13_vditm.vrkme'),
qty_act NUMERIC(18,5)
OPTIONS(description='Tatsaechlich fakturierte Menge; SAP-Retail: vbrp.fkimg; SAP-BW: t_bw_2lis_13_vditm.fkimg; ELWIS: t_s_retail_sales_record_pos.qty_act'),
qty_stock_unit NUMERIC(18,5)
OPTIONS(description='Verkaufsmenge in Lagermengeneinheit; SAP-Retail: vbrp.fklmg; SAP-BW: t_bw_2lis_13_vditm.fklmg; ELWIS: t_s_retail_sales_record_pos.qty_lme'),
curr_cd STRING(20) OPTIONS(description='Belegwaehrung - Code; SAP-Retail: vbrk.waerk; SAP-BW: t_bw_2lis_13_vditm.waerk'),
net_val NUMERIC(18,5)
OPTIONS(description='Nettowert der Fakturaposition in Belegwaehrung; SAP-Retail: vbrp.netwr; SAP-BW: t_bw_2lis_13_vditm.netwr; ELWIS: t_s_retail_sales_record_pos.net_sales_amt'),
tax_val NUMERIC(18,5)
OPTIONS(description='Steuerbetrag in Belegwaehrung; SAP-Retail: vbrp.mwsbp; SAP-BW: t_bw_2lis_13_vditm.mwsbp; ELWIS: t_s_retail_sales_record_pos.tax_sales_amt'),
cond_subtotal_1 NUMERIC(18,5)
OPTIONS(description='Konditionszwischensumme 1 aus Kalkulationsschema; SAP-Retail: vbrp.kzwi1; SAP-BW: t_bw_2lis_13_vditm.kzwi1; ELWIS: t_s_retail_sales_record_pos.gross_calc1_sales_amt'),
cond_subtotal_2 NUMERIC(18,5)
OPTIONS(description='Konditionszwischensumme 2 aus Kalkulationsschema; SAP-Retail: vbrp.kzwi2; SAP-BW: t_bw_2lis_13_vditm.kzwi2; ELWIS: t_s_retail_sales_record_pos.gross_calc2_sales_amt'),
dwh_cal_dt DATE NOT NULL
OPTIONS(description='Verkaufsdatum/Fakruradatum/Rechnungdatum; SAP-Retail: vbrk.FKDAT; SAP-BW: t_bw_2lis_13_vditm.fkdat; ELWIS: invoice_dat'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, retail_sales_record_id, retail_sales_record_pos_id) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id
OPTIONS(description='$Revision: 0000 $. RESP; Faktura - Positionsdaten;             SAP-Retail: vbrp (&vbrk);             SAP-BW: t_bw_2lis_13_vditm;             ELWIS: t_s_retail_sales_record_pos');