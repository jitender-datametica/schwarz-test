/* --------------------------------------------------------------------------------
   DDL for table: t_sales_receipt_record_pos_1
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_SALES_RECEIPT_RECORD_POS_1 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   sales_receipt_record_cd             VARCHAR(20)      NOT NULL COMMENT 'Lieferung; SAP-Retail: lips.vbeln; SAP-BW: t_bw_z_ds_zlex_bw_anlieferung.vbeln; ELWIS: t_s_deliv_mhd.deliv_id',
   sales_receipt_record_pos_id         NUMBER(38,0)     NOT NULL COMMENT 'Lieferposition; SAP-Retail: lips.posnr; SAP-BW: t_bw_z_ds_zlex_bw_anlieferung.posnr; ELWIS: t_s_deliv_mhd.deliv_pos_id',
   item_sid                            NUMBER(38,0)     COMMENT 'Artikel_1; FK auf ITEM_1; SAP-Retail: vbrp.matnr; SAP-BW: t_bw_z_ds_zlex_bw_anlieferung.matnr; ELWIS: t_s_deliv_mhd.itm_sid',
   loc_sid                             NUMBER(38,0)     COMMENT 'Betrieb; FK auf LOCATION_1; SAP-Retail: vbrp.werks; SAP-BW: t_bw_z_ds_zlex_bw_anlieferung.werks; ELWIS: t_s_deliv_mhd.loc_sid',
   uom_sid_sales                       NUMBER(38,0)     COMMENT 'Verkaufsmengeneinheit; vrkme',
   sales_receipt_pos_type_cd           VARCHAR(20)      COMMENT 'Positionstyp Lieferung; SAP-Retail: lips.pstyv; SAP-BW: t_bw_z_ds_zlex_bw_anlieferung.pstyv',
   storage_loc_cd                      VARCHAR(20)      COMMENT 'Lagerort; SAP-Retail: lips.lgort; SAP-BW: t_bw_z_ds_zlex_bw_anlieferung.lgort',
   batch_cd                            VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Chargennummer; SAP-Retail: lips.charg; SAP-BW: t_bw_z_ds_zlex_bw_anlieferung.charg; ELWIS: t_s_deliv_mhd.package_id',
   ref_record_cd                       VARCHAR(20)      COLLATE 'en-ci' COMMENT 'VORLAEUFIGER NAME - unbekanntes Ref-Ziel (Vermutung: order_record_id); Belegnummer des Vorlagebeleges; SAP-Retail lips.vgbel',
   ref_record_pos_id                   NUMBER(38,0)     COMMENT 'VORLAEUFIGER NAME - unbekanntes Ref-Ziel (Vermutung: order_record_pos_id); Positionsnummer der Vorlage-Geschaeftsposition; SAP-Retail: lips.vgpos',
   gtin                                VARCHAR(20)      COMMENT 'Global Trade Item_1 Number (GTIN); SAP-Retail: lips.ean11',
   uom_cd_sales                        VARCHAR(20)      COMMENT 'Verkaufsmengeneinheit; SAP-Retail: lips.vrkme',
   delivery_act_qty                    NUMBER(18,5)     COMMENT 'Tatsaechlich gelieferte Menge in uom_cd_sales; SAP-Retail: lips.lfimg',
   delivery_orig_qty                   NUMBER(18,5)     COMMENT 'Originalmenge der Lieferposition; SAP-Retail: lips.ormng',
   delivery_dt                         DATE             COMMENT 'Liefertermin; SAP-Retail: likp.lfdat; SAP-BW: t_bw_z_ds_zlex_bw_anlieferung..lfdat; ELWIS: t_s_deliv_mhd.liefer_dat',
   best_before_dt                      DATE             COMMENT 'Verfallsdatum oder Mindesthaltbarkeitsdatum; SAP-Retail: lips.vfdat; SAP-BW: t_bw_z_ds_zlex_bw_anlieferung..vfdat; ELWIS: t_s_deliv_mhd.mhd_dat',
   item_provision_dt                   DATE             COMMENT 'Artikelbereitstellungsdatum; SAP-Retail: lips.mbdat; SAP-BW: t_bw_z_ds_zlex_bw_anlieferung..mbdat',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Belegdatum im Beleg; SAP-Retail: likp.bldat; SAP-BW: t_bw_z_ds_zlex_bw_anlieferung.bldat; ELWIS: -',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_SALES_RECEIPT_RECORD_POS PRIMARY KEY (client_id, sales_receipt_record_cd, sales_receipt_record_pos_id) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Vertriebsbeleg: Lieferung: Positionsdaten
             SAP-Retail: (likp), lips;
             SAP-BW: t_bw_z_ds_zlex_bw_anlieferung;
             ELWIS: t_s_deliv_mhd';

