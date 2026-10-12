/* --------------------------------------------------------------------------------
   DDL for table: t_order_record
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_order_record (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
order_record_id NUMERIC(20,0) NOT NULL
OPTIONS(description='Einkaufsbeleg; SAP-Retail: ekko.ebeln; SAP-BW: t_bw_2lis_02_scl.ebeln'),
sup_sid BIGNUMERIC(38,0)
OPTIONS(description='Lieferant; FK auf SUPPLIER; SAP-Retail: ekko.lifnr; SAP-BW: t_bw_2lis_02_scl.lifnr'),
loc_sid BIGNUMERIC(38,0)
OPTIONS(description='Lieferbetrieb; FK auf LOCATION; SAP-Retail: ekko.reswk; SAP-BW: t_bw_2lis_02_scl.reswk'),
order_type_cd STRING(20)
OPTIONS(description='Belegart; SAP-Retail: ekko.bsart; SAP-BW: t_bw_2lis_02_scl.bsart; ELWIS: order_type_cd'),
dwh_cal_dt DATE NOT NULL
OPTIONS(description='Belegdatum; SAP-Retail: ekko.bedat; SAP-BW: t_bw_2lis_02_scl.bedat; ELWIS: order_dat'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, order_record_id) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id
OPTIONS(description='$Revision: 0000 $. ORDR; Einkaufsbelegkopf;              SAP-Retail: ekko;             SAP-BW: t_bw_2lis_02_scl;             ELWIS: t_s_order_record');