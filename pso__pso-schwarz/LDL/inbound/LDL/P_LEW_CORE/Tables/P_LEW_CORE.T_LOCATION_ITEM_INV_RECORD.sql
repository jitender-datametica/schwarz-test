/* --------------------------------------------------------------------------------
   DDL for table: t_location_item_inv_record
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_LOCATION_ITEM_INV_RECORD CLUSTER BY (
     DWH_CAL_DT,
     CLIENT_ID 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Betrieb; FK auf LOCATION; SAP-BW: xxx.plant',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Artikel; FK auf ITEM; SAP-BW: xxx.material',
   comp_sid                            NUMBER(38,0)     COMMENT 'Buchungskreis; FK auf COMPANY; SAP-BW: t_odp_inventur_agg.comp_code',
   curr_sid                            NUMBER(38,0)     COMMENT 'Belegwahrung; FK auf CURRENCY; SAP-BW: t_odp_inventur_agg.doc_currcy',
   uom_sid                             NUMBER(38,0)     COMMENT 'Mengeneinheit Stuckvariante fur Inventurdifferenz; FK auf UNIT OF MEASUREMENT; SAP-BW: t_odp_inventur_agg._slash_bic_slash_zustvarme',
   sales_org_sid                       NUMBER(38,0)     COMMENT 'Verkaufsorganisation; FK auf SALES ORG; SAP-BW: t_odp_inventur_agg.salesorg',
   discriminator_src_cd                VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Herkunftsmarkierung der Saetze: MM,WM,EWM; "MM": SAP-Retail.t_odp_inventur_agg, "WM": SAP-Retail.t_odp_inventur_wh, "EWM":SAP-EWM.t_odp_inventur_ewh',
   storage_loc_cd                      VARCHAR(20)      NOT NULL COMMENT 'Lagerort; SAP-BW: xxx.stor_loc; ELWIS: storage_loc_cd',
   storage_atom_cd                     VARCHAR(100)     NOT NULL COLLATE 'en-ci' COMMENT 'kuenstl Schluessel; MM/WM: "-"; EWM: String-Concat:("wm_storage_nr"-"ewm_storage_task_id"-"ewm_storage_task_pos_id"-"ewm_storage_task_sub_pos_id")',
   wm_storage_nr                       VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Lagernummer (SAP-Retail-WM; SAP-EWM); SAP-BW: t_odp_inventur_wh.whse_num; t_odp_inventur_ewh.wm_lgnum; ELWIS: t_s_inv_ewh_record.wm_storage_cd; t_s_inv_wh_record.storage_nr',
   ewm_storage_task_id                 NUMBER(20,0)     COMMENT 'Lageraufgabe (SAP-EWM);  SAP-BW: t_odp_inventur_ewh.wm_tanum; ELWIS: t_s_inv_ewh_record.storage_task_id',
   ewm_storage_task_pos_id             NUMBER(38,0)     COMMENT 'Lageraufgabenposition (SAP-EWM); SAP-BW: t_odp_inventur_ewh.wm_tapos; ELWIS: t_s_inv_ewh_record.storage_task_pos_id',
   ewm_storage_task_sub_pos_id         NUMBER(38,0)     COMMENT 'Unterposition einer Lageraufgabe (SAP-EWM); SAP-BW: t_odp_inventur_ewh.wm_wtsubit; ELWIS: t_s_inv_ewh_record.storage_task_sub_pos_id',
   fisc_year                           NUMBER(38,0)     COMMENT 'Geschaeftsjahr; SAP-BW: xxx.fiscyear; ELWIS: -',
   fisc_year_variant_cd                VARCHAR(20)      COMMENT 'Geschaeftsjahr - Variante; SAP-BW: xxx.fiscvarnt; ELWIS: -',
   inv_nr                              VARCHAR(20)      COMMENT 'Inventurnummer; SAP-BW: t_odp_inventur_agg/wh/ewh._slash_bic_slash_zminvnu1; ELWIS: inv_nr',
   inv_id                              NUMBER(20,0)     NOT NULL COMMENT 'Inventurbelegnummer; SAP-BW: t_odp_inventur_agg/wh._slash_bic_slash_zmiblnr; t_odp_inventur_ewh.zmnumber; ELWIS: inv_id',
   inv_type_mark                       VARCHAR(20)      COMMENT 'Herkunft - Code (A, B, C, D); SAP-BW: t_odp_inventur_agg._slash_bic_slash_zmpidtype; ELWIS: inv_type_cd',
   inv_type_label                      VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Herkunft - Beschreibung: A=Vollinventur; B=Teilinventur; C=Gesellschaftsinitiierte Einzelinventur; D=Filialinitiierte Einzelinventur; ',
   inv_period_start_dt                 DATE             COMMENT 'Vorheriges Inventurdatum + 1; SAP-BW: t_odp_inventur_agg/wh._slash_bic_slash_zmdvorinv + 1; ELWIS: inv_valid_from_dat',
   inv_record_dt                       DATE             COMMENT 'Belegdatum; SAP-BW: t_odp_inventur_agg/wh.calday; ELWIS: dat_formdate',
   inv_record_year                     NUMBER(38,0)     COMMENT 'Belegjahr; SAP-BW: t_odp_inventur_agg.doc_year; ELWIS: inv_record_year',
   inv_record_id                       NUMBER(20,0)     COMMENT 'Matrialbelegnummer; SAP-BW: t_odp_inventur_agg.mat_doc; ELWIS: inv_record_id',
   inv_record_pos_id                   NUMBER(38,0)     COMMENT 'Material Document Item; SAP-BW: t_odp_inventur_agg.mat_item; ELWIS: inv_record_pos_id',
   inv_move_type_mark                  VARCHAR(20)      COMMENT 'Bewegungsart - Code (701,702); SAP-BW: t_odp_inventur_agg.movetyp; ELWIS: inv_mov_type_cd',
   inv_move_type_label                 VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Bewegungsart - Beschreibung; 701=Wareneingang Inventur Lager; 702=Warenausgang Inventur Lager;',
   uom_cd                              VARCHAR(20)      COMMENT 'Mengeneinheit Stuckvariante fur Inventurdifferenz; SAP-BW: t_odp_inventur_agg._slash_bic_slash_zustvarme',
   sales_qty                           NUMBER(18,5)     COMMENT 'Abverkaufsmenge im Inventurzeitraum in ST/KG; SAP-BW: t_odp_inventur_agg._slash_bic_slash_zaamengst; ELWIS: qty_piece_sold',
   sales_case_qty                      NUMBER(18,5)     COMMENT 'Abverkaufsmenge im Inventurzeitraum in Kolli; SAP-BW: t_odp_inventur_agg._slash_bic_slash_zaamengka; ELWIS: qty_case_sold',
   inv_diff_qty                        NUMBER(18,5)     COMMENT 'Inventurdifferenz aus Mat-Beleg in ST/KG; SAP-BW: t_odp_inventur_agg._slash_bic_slash_zaindifst; ELWIS: qty_inv_diff_piece',
   inv_diff_case_qty                   NUMBER(18,5)     COMMENT 'Inventurdifferenz aus Mat-Beleg in Kolli; SAP-BW: t_odp_inventur_agg._slash_bic_slash_zaindifka; ELWIS: qty_inv_diff_case',
   curr_cd                             VARCHAR(20)      COMMENT 'Belegwahrung; SAP-BW: t_odp_inventur_agg.doc_currcy',
   gross_val                           NUMBER(18,5)     COMMENT 'Brutto-Verkaufswert in Hauswahrung; SAP-BW: t_odp_inventur_agg.cpstlc; ELWIS: gross_val',
   net_val                             NUMBER(18,5)     COMMENT 'Netto-Verkaufswert in Hauswahrung; SAP-BW: t_odp_inventur_agg.cpsvlc; ELWIS: sales_net_val',
   inv_diff_gross_val                  NUMBER(18,5)     COMMENT 'Inventurdifferenzwert durch. VK brutto; SAP-BW: t_odp_inventur_agg._slash_bic_slash_zkibvalu; ELWIS: gross_val_inv_diff',
   inv_diff_net_val                    NUMBER(18,5)     COMMENT 'Inventurdifferenzwert durch. VK netto; SAP-BW: t_odp_inventur_agg._slash_bic_slash_zkinvalu; ELWIS: net_val_inv_diff',
   sales_gross_val                     NUMBER(18,5)     COMMENT 'Brutto-Umsatz im Inventurzeitraum; SAP-BW: t_odp_inventur_agg._slash_bic_slash_zkuminb; ELWIS: val_rtl_inv',
   sales_net_val                       NUMBER(18,5)     COMMENT 'Netto-Umsatz im Inventurzeitraum; SAP-BW: t_odp_inventur_agg._slash_bic_slash_zkuminv; ELWIS: val_rtl_net_inv',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Inventurdatum; SAP-BW: t_odp_inventur_agg._slash_bic_slash_zmdzldat; ELWIS: inv_valid_to_dat',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_LOCATION_ITEM_INV_RECORD PRIMARY KEY (discriminator_src_cd, storage_atom_cd, loc_sid, item_sid, storage_loc_cd, inv_id, dwh_cal_dt) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Ums z. Inv.zeitraeumen .(In SAP-BW berechnet/aufbereitet);
             SAP-Retail: z_ds_mm(wm)_inventure; 
             SAP-EWM: 0wm_wt (Lageraufgaben);
             SAP-BW: MM=t_odp_inventur_agg WM=..tur_wh EWM=..tur_ewh;
             ELWIS: t_s_inv_(wh/ewh)_record';

