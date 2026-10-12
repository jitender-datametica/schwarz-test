/* --------------------------------------------------------------------------------
   DDL for table: t_sales_receipt_record_pos_1
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_sales_receipt_record_pos_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
sales_receipt_record_cd STRING(20) NOT NULL
OPTIONS(description='Lieferung; SAP-Retail: lips.vbeln; SAP-BW: t_bw_z_ds_zlex_bw_anlieferung.vbeln; ELWIS: t_s_deliv_mhd.deliv_id'),
sales_receipt_record_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Lieferposition; SAP-Retail: lips.posnr; SAP-BW: t_bw_z_ds_zlex_bw_anlieferung.posnr; ELWIS: t_s_deliv_mhd.deliv_pos_id'),
item_sid BIGNUMERIC(38,0)
OPTIONS(description='Artikel_1; FK auf ITEM_1; SAP-Retail: vbrp.matnr; SAP-BW: t_bw_z_ds_zlex_bw_anlieferung.matnr; ELWIS: t_s_deliv_mhd.itm_sid'),
loc_sid BIGNUMERIC(38,0)
OPTIONS(description='Betrieb; FK auf LOCATION_1; SAP-Retail: vbrp.werks; SAP-BW: t_bw_z_ds_zlex_bw_anlieferung.werks; ELWIS: t_s_deliv_mhd.loc_sid'),
uom_sid_sales BIGNUMERIC(38,0) OPTIONS(description='Verkaufsmengeneinheit; vrkme'),
sales_receipt_pos_type_cd STRING(20)
OPTIONS(description='Positionstyp Lieferung; SAP-Retail: lips.pstyv; SAP-BW: t_bw_z_ds_zlex_bw_anlieferung.pstyv'),
storage_loc_cd STRING(20)
OPTIONS(description='Lagerort; SAP-Retail: lips.lgort; SAP-BW: t_bw_z_ds_zlex_bw_anlieferung.lgort'),
batch_cd STRING(20) COLLATE 'und:ci'
OPTIONS(description='Chargennummer; SAP-Retail: lips.charg; SAP-BW: t_bw_z_ds_zlex_bw_anlieferung.charg; ELWIS: t_s_deliv_mhd.package_id'),
ref_record_cd STRING(20) COLLATE 'und:ci'
OPTIONS(description='VORLAEUFIGER NAME - unbekanntes Ref-Ziel (Vermutung: order_record_id); Belegnummer des Vorlagebeleges; SAP-Retail lips.vgbel'),
ref_record_pos_id BIGNUMERIC(38,0)
OPTIONS(description='VORLAEUFIGER NAME - unbekanntes Ref-Ziel (Vermutung: order_record_pos_id); Positionsnummer der Vorlage-Geschaeftsposition; SAP-Retail: lips.vgpos'),
gtin STRING(20) OPTIONS(description='Global Trade Item_1 Number (GTIN); SAP-Retail: lips.ean11'),
uom_cd_sales STRING(20) OPTIONS(description='Verkaufsmengeneinheit; SAP-Retail: lips.vrkme'),
delivery_act_qty NUMERIC(18,5)
OPTIONS(description='Tatsaechlich gelieferte Menge in uom_cd_sales; SAP-Retail: lips.lfimg'),
delivery_orig_qty NUMERIC(18,5) OPTIONS(description='Originalmenge der Lieferposition; SAP-Retail: lips.ormng'),
delivery_dt DATE
OPTIONS(description='Liefertermin; SAP-Retail: likp.lfdat; SAP-BW: t_bw_z_ds_zlex_bw_anlieferung..lfdat; ELWIS: t_s_deliv_mhd.liefer_dat'),
best_before_dt DATE
OPTIONS(description='Verfallsdatum oder Mindesthaltbarkeitsdatum; SAP-Retail: lips.vfdat; SAP-BW: t_bw_z_ds_zlex_bw_anlieferung..vfdat; ELWIS: t_s_deliv_mhd.mhd_dat'),
item_provision_dt DATE
OPTIONS(description='Artikelbereitstellungsdatum; SAP-Retail: lips.mbdat; SAP-BW: t_bw_z_ds_zlex_bw_anlieferung..mbdat'),
dwh_cal_dt DATE NOT NULL
OPTIONS(description='Belegdatum im Beleg; SAP-Retail: likp.bldat; SAP-BW: t_bw_z_ds_zlex_bw_anlieferung.bldat; ELWIS: -'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, sales_receipt_record_cd, sales_receipt_record_pos_id) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. Vertriebsbeleg: Lieferung: Positionsdaten             SAP-Retail: (likp), lips;             SAP-BW: t_bw_z_ds_zlex_bw_anlieferung;             ELWIS: t_s_deliv_mhd');