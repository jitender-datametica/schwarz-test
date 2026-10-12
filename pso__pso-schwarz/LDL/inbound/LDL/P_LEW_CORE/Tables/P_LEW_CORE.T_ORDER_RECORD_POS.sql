/* --------------------------------------------------------------------------------
   DDL for table: t_order_record_pos
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ORDER_RECORD_POS CLUSTER BY (
     CLIENT_ID,
     DWH_CAL_DT 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   order_record_id                     NUMBER(20,0)     NOT NULL COMMENT 'Einkaufsbeleg; SAP-Retail: ekpo.ebeln; SAP-BW: t_bw_2lis_02_scl.ebeln; ELWIS: t_s_order_record_pos.order_record_id',
   order_record_pos_id                 NUMBER(38,0)     NOT NULL COMMENT 'Positionsnummer des Einkaufsbelegs; SAP-Retail: ekpo.ebelp; SAP-BW: t_bw_2lis_02_scl.ebelp; ELWIS: t_s_order_record_pos.order_record_pos_id',
   loc_sid                             NUMBER(38,0)     COMMENT 'Betrieb; FK auf LOCATION; SAP-Retail: ekpo.werks; SAP-BW: t_bw_2lis_02_scl.werks; ELWIS: t_s_order_record_pos.loc_sid',
   item_sid                            NUMBER(38,0)     COMMENT 'Artikel; FK auf ITEM; SAP-Retail: ekpo.matnr; SAP-BW: t_bw_2lis_02_scl.matnr; ELWIS: t_s_order_record_pos.itm_sid',
   uom_sid                             NUMBER(38,0)     COMMENT 'Bestellmengeneinheit; FK auf UNIT OF MEASUREMENT; SAP-Retail: ekpo.meins; SAP-BW: t_bw_2lis_02_scl.meins; ELWIS: t_s_order_record_pos.order_uom_sid',
   uom_cd                              VARCHAR(20)      COMMENT 'Bestellmengeneinheit; SAP-Retail: ekpo.meins; SAP-BW: t_bw_2lis_02_scl.meins; ELWIS: t_s_order_record_pos.order_uom_sid',
   return_reason_mark                  VARCHAR(20)      COMMENT 'Retouren Grund - Code (Ref-Tab: t_ref_return_reason(_descr)); SAP-Retail: ekpo.ret_reason_k; SAP-BW: t_bw_2lis_02_scl.ret_reason_k; ELWIS: t_s_order_record_pos.order_return_reason_cd',
   return_reason_label                 VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Retouren Grund - Beschreibung; SAP-Retail: ekpo.zzbsgru_txt; SAP-BW: t_bw_2lis_02_scl.zzbsgru_txt; ELWIS: t_s_order_record_pos.order_return_reason_desc',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Belegdatum; SAP-Retail: ekko.bedat; SAP-BW: t_bw_2lis_02_scl.bedat; ELWIS: t_s_order_record_pos.order_dat',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_ORDER_RECORD_POS PRIMARY KEY (client_id, order_record_id, order_record_pos_id) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. ORDP;Einkaufsbelegposition;
             SAP-Retail: ekpo;
             SAP-BW: t_bw_2lis_02_scl;
             ELWIS: t_s_order_record_pos';

