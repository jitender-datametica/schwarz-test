/* --------------------------------------------------------------------------------
   DDL for table: t_order_record_pos_split_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_order_record_pos_split_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
order_record_id NUMERIC(20,0) NOT NULL
OPTIONS(description='Einkaufsbeleg; SAP-Retail: eket.ebeln; SAP-BW: t_bw_2lis_02_scl.ebeln'),
order_record_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Positionsnummer des Einkaufsbelegs; SAP-Retail: eket.ebelp; SAP-BW: t_bw_2lis_02_scl.ebelp'),
order_record_pos_split_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Unterteilungsnummer der Bestellposition; SAP-Retail: eket.etenr; SAP-BW: t_bw_2lis_02_scl.etenr'),
order_split_qty NUMERIC(18,5)
OPTIONS(description='Einteilungsmenge; SAP-Retail: eket.menge; SAP-BW: t_bw_2lis_02_scl.menge; ELWIS: t_s_order_record_pos_split.ship_qty'),
delivery_dt DATE
OPTIONS(description='Lieferdatum; SAP-Retail: eket.eindt; SAP-BW: t_bw_2lis_02_scl.eindt; ELWIS: t_s_order_record_pos_split.delivey_dat'),
dwh_cal_dt DATE NOT NULL
OPTIONS(description='Belegdatum; SAP-Retail: ekko.bedat; SAP-BW: t_bw_2lis_02_scl.bedat; ELWIS: t_s_order_record_pos_split.order_dat'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, order_record_id, order_record_pos_id, order_record_pos_split_id) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id
OPTIONS(description='$Revision: 0000 $. ORDS; Lieferplaneinteilung;              SAP-Retail: eket;             SAP-BW: 2lis_02_scl;             ELWIS: t_s_order_record_pos_split');