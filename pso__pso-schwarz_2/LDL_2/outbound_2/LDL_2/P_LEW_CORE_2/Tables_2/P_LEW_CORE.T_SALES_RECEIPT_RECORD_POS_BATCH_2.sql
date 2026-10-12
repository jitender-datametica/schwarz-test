/* --------------------------------------------------------------------------------
   DDL for table: t_sales_receipt_record_pos_batch_2
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_sales_receipt_record_pos_batch_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
sales_receipt_record_cd STRING(20) NOT NULL
OPTIONS(description='Lieferung - Belegnummer; SAP-Retail: lips.vbeln; SAP-BW: z_ds_wecp.deliv; ELWIS: t_s_deliv_mhd.deliv_id'),
sales_receipt_record_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Lieferposition; SAP-Retail: lips.posnr; SAP-BW: z_ds_wecp.delivp; ELWIS: t_s_deliv_mhd.deliv_pos_id'),
batch_cd STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Chargennummer; SAP-Retail: lips.charg; SAP-BW: z_ds_wecp.hu_id; ELWIS: t_s_deliv_mhd.package_id'),
item_sid BIGNUMERIC(38,0)
OPTIONS(description='Artikel_2; FK auf ITEM_2; SAP-Retail: vbrp.matnr; SAP-BW: z_ds_wecp.matnr; ELWIS: t_s_deliv_mhd.itm_sid'),
loc_sid BIGNUMERIC(38,0)
OPTIONS(description='Betrieb; FK auf LOCATION_2; SAP-Retail: vbrp.werks; SAP-BW: z_ds_wecp.werks; ELWIS: t_s_deliv_mhd.loc_sid'),
uom_sid BIGNUMERIC(38,0) OPTIONS(description='Mengeneinheit; SAP-BW: z_ds_wecp.quan_base_unit; ELWIS: -'),
uom_cd STRING(20) OPTIONS(description='Mengeneinheit; SAP-BW: z_ds_wecp.quan_base_unit; ELWIS: -'),
delivery_act_qty NUMERIC(18,5)
OPTIONS(description='Tatsaechlich gelieferte Menge (in uom_cd); SAP-BW: z_ds_wecp.mde_kolli_allov; ELWIS: -'),
delivery_batch_qty NUMERIC(18,5)
OPTIONS(description='Menge in der Charge batch_cd (in uom_cd) (Summe aller Chargen = delivery_act_qty); SAP-BW: z_ds_wecp.mde_kolli_nve; ELWIS: -'),
delivery_dt DATE
OPTIONS(description='Lieferdatum; SAP-Retail: likp.lfdat; SAP-BW: z_ds_wecp.lfdat; ELWIS: t_s_deliv_mhd.liefer_dat'),
best_before_dt DATE
OPTIONS(description='Verfalls- bzw. Mindesthaltbarkeitsdatum (pro Charge); SAP-Retail: lips.vfdat; SAP-BW: z_ds_wecp.mde_mhd; ELWIS: t_s_deliv_mhd.mhd_dat'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Belegdatum; SAP-Retail: likp.bldat; SAP-BW: z_ds_wecp.doc_date; ELWIS: -'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, sales_receipt_record_cd, sales_receipt_record_pos_id) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. Lieferung: Chargensplittung pro Position             Quelle: WarenEingangsCockPit;              SAP-Retail: ?;             SAP-BW: z_ds_wecp (AT WH(5,6));             ELWIS: t_s_deliv_mhd');