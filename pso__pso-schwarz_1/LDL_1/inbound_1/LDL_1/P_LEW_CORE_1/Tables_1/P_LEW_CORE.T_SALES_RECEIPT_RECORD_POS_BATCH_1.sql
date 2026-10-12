/* --------------------------------------------------------------------------------
   DDL for table: t_sales_receipt_record_pos_batch_1
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_SALES_RECEIPT_RECORD_POS_BATCH_1 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   sales_receipt_record_cd             VARCHAR(20)      NOT NULL COMMENT 'Lieferung - Belegnummer; SAP-Retail: lips.vbeln; SAP-BW: z_ds_wecp.deliv; ELWIS: t_s_deliv_mhd.deliv_id',
   sales_receipt_record_pos_id         NUMBER(38,0)     NOT NULL COMMENT 'Lieferposition; SAP-Retail: lips.posnr; SAP-BW: z_ds_wecp.delivp; ELWIS: t_s_deliv_mhd.deliv_pos_id',
   batch_cd                            VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Chargennummer; SAP-Retail: lips.charg; SAP-BW: z_ds_wecp.hu_id; ELWIS: t_s_deliv_mhd.package_id',
   item_sid                            NUMBER(38,0)     COMMENT 'Artikel_1; FK auf ITEM_1; SAP-Retail: vbrp.matnr; SAP-BW: z_ds_wecp.matnr; ELWIS: t_s_deliv_mhd.itm_sid',
   loc_sid                             NUMBER(38,0)     COMMENT 'Betrieb; FK auf LOCATION_1; SAP-Retail: vbrp.werks; SAP-BW: z_ds_wecp.werks; ELWIS: t_s_deliv_mhd.loc_sid',
   uom_sid                             NUMBER(38,0)     COMMENT 'Mengeneinheit; SAP-BW: z_ds_wecp.quan_base_unit; ELWIS: -',
   uom_cd                              VARCHAR(20)      COMMENT 'Mengeneinheit; SAP-BW: z_ds_wecp.quan_base_unit; ELWIS: -',
   delivery_act_qty                    NUMBER(18,5)     COMMENT 'Tatsaechlich gelieferte Menge (in uom_cd); SAP-BW: z_ds_wecp.mde_kolli_allov; ELWIS: -',
   delivery_batch_qty                  NUMBER(18,5)     COMMENT 'Menge in der Charge batch_cd (in uom_cd) (Summe aller Chargen = delivery_act_qty); SAP-BW: z_ds_wecp.mde_kolli_nve; ELWIS: -',
   delivery_dt                         DATE             COMMENT 'Lieferdatum; SAP-Retail: likp.lfdat; SAP-BW: z_ds_wecp.lfdat; ELWIS: t_s_deliv_mhd.liefer_dat',
   best_before_dt                      DATE             COMMENT 'Verfalls- bzw. Mindesthaltbarkeitsdatum (pro Charge); SAP-Retail: lips.vfdat; SAP-BW: z_ds_wecp.mde_mhd; ELWIS: t_s_deliv_mhd.mhd_dat',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Belegdatum; SAP-Retail: likp.bldat; SAP-BW: z_ds_wecp.doc_date; ELWIS: -',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_SALES_RECEIPT_RECORD_POS_BATCH PRIMARY KEY (client_id, sales_receipt_record_cd, sales_receipt_record_pos_id, batch_cd) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Lieferung: Chargensplittung pro Position
             Quelle: WarenEingangsCockPit; 
             SAP-Retail: ?;
             SAP-BW: z_ds_wecp (AT WH(5,6));
             ELWIS: t_s_deliv_mhd';

