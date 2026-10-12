/* --------------------------------------------------------------------------------
   DDL for table: t_order_record_pos_split_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ORDER_RECORD_POS_SPLIT_2 CLUSTER BY (
     DWH_CAL_DT,
     CLIENT_ID 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   order_record_id                     NUMBER(20,0)     NOT NULL COMMENT 'Einkaufsbeleg; SAP-Retail: eket.ebeln; SAP-BW: t_bw_2lis_02_scl.ebeln',
   order_record_pos_id                 NUMBER(38,0)     NOT NULL COMMENT 'Positionsnummer des Einkaufsbelegs; SAP-Retail: eket.ebelp; SAP-BW: t_bw_2lis_02_scl.ebelp',
   order_record_pos_split_id           NUMBER(38,0)     NOT NULL COMMENT 'Unterteilungsnummer der Bestellposition; SAP-Retail: eket.etenr; SAP-BW: t_bw_2lis_02_scl.etenr',
   order_split_qty                     NUMBER(18,5)     COMMENT 'Einteilungsmenge; SAP-Retail: eket.menge; SAP-BW: t_bw_2lis_02_scl.menge; ELWIS: t_s_order_record_pos_split.ship_qty',
   delivery_dt                         DATE             COMMENT 'Lieferdatum; SAP-Retail: eket.eindt; SAP-BW: t_bw_2lis_02_scl.eindt; ELWIS: t_s_order_record_pos_split.delivey_dat',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Belegdatum; SAP-Retail: ekko.bedat; SAP-BW: t_bw_2lis_02_scl.bedat; ELWIS: t_s_order_record_pos_split.order_dat',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_ORDER_RECORD_POS_SPLIT PRIMARY KEY (client_id, order_record_id, order_record_pos_id, order_record_pos_split_id) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. ORDS; Lieferplaneinteilung; 
             SAP-Retail: eket;
             SAP-BW: 2lis_02_scl;
             ELWIS: t_s_order_record_pos_split';

