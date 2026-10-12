/* --------------------------------------------------------------------------------
   DDL for table: t_location_item_receipt_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_LOCATION_ITEM_RECEIPT_1 CLUSTER BY (
     DWH_CAL_DT,
     CLIENT_ID 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   location_item_receipt_year          NUMBER(38,0)     NOT NULL COMMENT 'Materialbelegsjahr; SAP-BW: t_odp_itm_we_calc.doc_year',
   location_item_receipt_id            NUMBER(20,0)     NOT NULL COMMENT 'Materialbeleg; SAP-BW: t_odp_itm_we_calc.mat_doc; ELWIS: t_s_mov_item_receive_wh.itm_mov_record_id',
   location_item_receipt_pos_id        NUMBER(38,0)     NOT NULL COMMENT 'Materialbelegposition; SAP-BW: t_odp_itm_we_calc.mat_item; ELWIS: t_s_mov_item_receive_wh.itm_mov_record_pos_id',
   loc_sid                             NUMBER(38,0)     COMMENT 'Betrieb/Filiale; FK auf LOCATION_1; SAP-BW: t_odp_itm_we_calc.plant; ELWIS: t_s_mov_item_receive_wh.loc_sid',
   item_sid                            NUMBER(38,0)     COMMENT 'Artikel_1; FK auf ITEM_1; SAP-BW: t_odp_itm_we_calc.material; ELWIS: t_s_mov_item_receive_wh.itm_sid',
   loc_sid_wh                          NUMBER(38,0)     COMMENT 'Warehouse; FK auf LOCATION_1; SAP-BW: t_odp_itm_we_calc._slash_bic_slash_zmnliefwd; ELWIS: t_s_mov_item_receive_wh.wh_loc_sid',
   sup_sid                             NUMBER(38,0)     COMMENT 'Lieferant; FK auf SUPPLIER_1; SAP-BW: t_odp_itm_we_calc.vendor; ELWIS: t_s_mov_item_receive_wh.sup_sid',
   curr_sid_local                      NUMBER(38,0)     COMMENT 'Hauswaehrung; FK auf CURRENCY; SAP-BW: t_odp_itm_we_calc.loc_currcy; ELWIS: t_s_mov_item_receive_wh.curr_iso_cd',
   curr_sid_receipt                    NUMBER(38,0)     NOT NULL COMMENT 'Belegwaehrung; FK auf CURRENCY; SAP-BW: t_odp_itm_we_calc.doc_currcy; ELWIS: t_s_mov_item_receive_wh.receipt_curr_iso_cd',
   uom_sid                             NUMBER(38,0)     COMMENT 'Mengeneinheit; FK auf UNIT_1 OF MEASUREMENT; SAP-BW: t_odp_itm_we_calc.base_uom; ELWIS: t_s_mov_item_receive_wh.base_qty_uom_sid',
   comp_sid                            NUMBER(38,0)     COMMENT 'Buchungskreis; FK auf COMPANY; ',
   fisc_year_variant_cd                VARCHAR(20)      NOT NULL COMMENT 'Geschaeftsjahr - Variante; SAP-BW: xxx.fiscvarnt; ELWIS: -',
   deb_cred_cd                         VARCHAR(20)      NOT NULL COMMENT '(S)oll-/(H)aben-Kennz.; SAP-BW: t_odp_itm_we_calc.dcindic; ELWIS: t_s_mov_item_receive_wh.deb_cred_cd',
   ledger_account_cd                   VARCHAR(20)      COMMENT 'Sachkonto; SAP-BW: t_odp_itm_we_calc.gl_account; ELWIS: t_s_mov_item_receive_wh.ledger_account_nr',
   receipt_dt                          DATE             COMMENT 'Materialbelegsdatum; SAP-BW: t_odp_itm_we_calc.doc_date; ELWIS: t_s_mov_item_receive_wh.record_dat',
   order_record_id                     NUMBER(20,0)     COMMENT 'Einkaufsbeleg; SAP-BW: t_odp_itm_we_calc.oi_ebeln',
   order_record_pos_id                 NUMBER(38,0)     COMMENT 'Einkaufsbelegposition; SAP-BW: t_odp_itm_we_calc.oi_ebelp',
   list_type_mark                      VARCHAR(20)      COMMENT 'Listungsart - Code; SAP-BW: t_odp_itm_we_calc.slash_bic_slash_zmkeylist',
   list_type_label                     VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Listungsart - Beschreibung; A=Aktion_1, S=Sortiment',
   uom_cd                              VARCHAR(20)      COMMENT 'Mengeneinheit; SAP-BW: t_odp_itm_we_calc.base_uom; ELWIS: t_s_mov_item_receive_wh.base_qty_uom_sid',
   receive_piece_qty                   NUMBER(18,5)     COMMENT 'Menge in Stueck; SAP-BW: t_odp_itm_we_calc._slash_bic_slash_zaquantst; ELWIS: t_s_mov_item_receive_wh.qty_piece_rcv
            ',
   receive_case_qty                    NUMBER(18,5)     COMMENT 'Menge in Kolli; SAP-BW: t_odp_itm_we_calc._slash_bic_slash_zaquantka; ELWIS: t_s_mov_item_receive_wh.qty_case_rcv
            _slash_bic_slash_zaquantka
            ',
   curr_cd_local                       VARCHAR(20)      COMMENT 'Hauswaehrung - Code; SAP-BW: t_odp_itm_we_calc.loc_currcy; ELWIS: t_s_mov_item_receive_wh.curr_iso_cd',
   curr_cd_receipt                     VARCHAR(20)      COMMENT 'Belegwaehrung - Code; SAP-BW: t_odp_itm_we_calc.doc_currcy; ELWIS: t_s_mov_item_receive_wh.receipt_curr_iso_cd',
   sales_gross_val                     NUMBER(18,5)     COMMENT 'Brutto-Verkaufswert in Hauswaehrung (curr_cd_local); SAP-BW: t_odp_itm_we_calc.cpstlc; ELWIS: t_s_mov_item_receive_wh.val_retail_rcv',
   sales_net_val                       NUMBER(18,5)     COMMENT 'Netto-Verkaufswert in Hauswaehrung (curr_cd_local); SAP-BW: t_odp_itm_we_calc.cpsvlc; ELWIS: t_s_mov_item_receive_wh.val_net_retail_rcv',
   tax_val                             NUMBER(18,5)     COMMENT 'Steuern in Hauswaehrung (curr_cd_local); SAP-BW: t_odp_itm_we_calc._slash_bic_slash_zkstbtrlc; ELWIS: t_s_mov_item_receive_wh.house_tax_val',
   environmental_levies_val            NUMBER(18,5)     COMMENT 'Umweltabgaben in Hauswaehrung (curr_cd_local); SAP-BW: t_odp_itm_we_calc._slash_bic_slash_zkaumwa; ELWIS: t_s_mov_item_receive_wh.house_eco_vat_val',
   customs_val                         NUMBER(18,5)     COMMENT 'Zoelle in Hauswaehrung (curr_cd_local); SAP-BW: t_odp_itm_we_calc._slash_bic_slash_zkazoll; ELWIS: t_s_mov_item_receive_wh.house_custm_val',
   refunds_val                         NUMBER(18,5)     COMMENT 'Rueckverguetungen in Hauswaehrung (curr_cd_local); SAP-BW: t_odp_itm_we_calc._slash_bic_slash_zkarueckv; ELWIS: t_s_mov_item_receive_wh.house_rfnd_val',
   carrier_costs_val                   NUMBER(18,5)     COMMENT 'Speditionskosten in Hauswaehrung (curr_cd_local); SAP-BW: t_odp_itm_we_calc._slash_bic_slash_zkaspedit; ELWIS: t_s_mov_item_receive_wh.house_carr_val',
   pur_development_net_val             NUMBER(18,5)     COMMENT 'EK Wert netto aus Bestellentwicklung in Hauswahrung (curr_cd_local); SAP-BW: t_odp_itm_we_calc._slash_bic_slash_zkekbtr; ELWIS: t_s_mov_item_receive_wh.house_curr_pur_ord_hist_val',
   bwcounter                           NUMBER(38,0)     COMMENT 'bwcounter; inhaltliche Bedeutung nicht klar - Vermutung: enge Beziehung zu deb_cred_cd; Werte: 1 u. 2; SAP-BW: itm_we_calc._slash_bic_slash_zmbwcount',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Buchungsdatum; SAP-BW: t_odp_itm_we_calc.calday; ELWIS: t_s_mov_item_receive_wh.booking_dat',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_LOCATION_ITEM_RECEIPT PRIMARY KEY (client_id, location_item_receipt_year, location_item_receipt_id, location_item_receipt_pos_id, curr_sid_receipt, fisc_year_variant_cd, deb_cred_cd) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. LIRC; WE-Kalkulation aus SAP BW;
             SAP-Retail: -;
             SAP-BW: t_odp_itm_we_calc;
             ELWIS: t_s_mov_item_receive_wh;
             WAWI: ';

