/* --------------------------------------------------------------------------------
   DDL for table: t_order_record_pos_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_order_record_pos_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
order_record_id NUMERIC(20,0) NOT NULL
OPTIONS(description='Einkaufsbeleg; SAP-Retail: ekpo.ebeln; SAP-BW: t_bw_2lis_02_scl.ebeln; ELWIS: t_s_order_record_pos.order_record_id'),
order_record_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Positionsnummer des Einkaufsbelegs; SAP-Retail: ekpo.ebelp; SAP-BW: t_bw_2lis_02_scl.ebelp; ELWIS: t_s_order_record_pos.order_record_pos_id'),
loc_sid BIGNUMERIC(38,0)
OPTIONS(description='Betrieb; FK auf LOCATION_1; SAP-Retail: ekpo.werks; SAP-BW: t_bw_2lis_02_scl.werks; ELWIS: t_s_order_record_pos.loc_sid'),
item_sid BIGNUMERIC(38,0)
OPTIONS(description='Artikel_1; FK auf ITEM_1; SAP-Retail: ekpo.matnr; SAP-BW: t_bw_2lis_02_scl.matnr; ELWIS: t_s_order_record_pos.itm_sid'),
uom_sid BIGNUMERIC(38,0)
OPTIONS(description='Bestellmengeneinheit; FK auf UNIT_1 OF MEASUREMENT; SAP-Retail: ekpo.meins; SAP-BW: t_bw_2lis_02_scl.meins; ELWIS: t_s_order_record_pos.order_uom_sid'),
uom_cd STRING(20)
OPTIONS(description='Bestellmengeneinheit; SAP-Retail: ekpo.meins; SAP-BW: t_bw_2lis_02_scl.meins; ELWIS: t_s_order_record_pos.order_uom_sid'),
return_reason_mark STRING(20)
OPTIONS(description='Retouren Grund - Code (Ref-Tab: t_ref_return_reason(_descr)); SAP-Retail: ekpo.ret_reason_k; SAP-BW: t_bw_2lis_02_scl.ret_reason_k; ELWIS: t_s_order_record_pos.order_return_reason_cd'),
return_reason_label STRING(100) COLLATE 'und:ci'
OPTIONS(description='Retouren Grund - Beschreibung; SAP-Retail: ekpo.zzbsgru_txt; SAP-BW: t_bw_2lis_02_scl.zzbsgru_txt; ELWIS: t_s_order_record_pos.order_return_reason_desc'),
dwh_cal_dt DATE NOT NULL
OPTIONS(description='Belegdatum; SAP-Retail: ekko.bedat; SAP-BW: t_bw_2lis_02_scl.bedat; ELWIS: t_s_order_record_pos.order_dat'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, order_record_id, order_record_pos_id) NOT ENFORCED
) CLUSTER BY client_id, dwh_cal_dt
OPTIONS(description='$Revision: 0000 $. ORDP;Einkaufsbelegposition;             SAP-Retail: ekpo_1;             SAP-BW: t_bw_2lis_02_scl;             ELWIS: t_s_order_record_pos');