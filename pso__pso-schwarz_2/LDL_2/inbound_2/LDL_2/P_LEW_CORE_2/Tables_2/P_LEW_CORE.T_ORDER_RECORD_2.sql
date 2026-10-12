/* --------------------------------------------------------------------------------
   DDL for table: t_order_record_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ORDER_RECORD_2 CLUSTER BY (
     DWH_CAL_DT,
     CLIENT_ID 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   order_record_id                     NUMBER(20,0)     NOT NULL COMMENT 'Einkaufsbeleg; SAP-Retail: ekko.ebeln; SAP-BW: t_bw_2lis_02_scl.ebeln',
   sup_sid                             NUMBER(38,0)     COMMENT 'Lieferant; FK auf SUPPLIER_2; SAP-Retail: ekko.lifnr; SAP-BW: t_bw_2lis_02_scl.lifnr',
   loc_sid                             NUMBER(38,0)     COMMENT 'Lieferbetrieb; FK auf LOCATION_2; SAP-Retail: ekko.reswk; SAP-BW: t_bw_2lis_02_scl.reswk',
   order_type_cd                       VARCHAR(20)      COMMENT 'Belegart; SAP-Retail: ekko.bsart; SAP-BW: t_bw_2lis_02_scl.bsart; ELWIS: order_type_cd',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Belegdatum; SAP-Retail: ekko.bedat; SAP-BW: t_bw_2lis_02_scl.bedat; ELWIS: order_dat',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_ORDER_RECORD PRIMARY KEY (client_id, order_record_id) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. ORDR; Einkaufsbelegkopf; 
             SAP-Retail: ekko_2;
             SAP-BW: t_bw_2lis_02_scl;
             ELWIS: t_s_order_record';

