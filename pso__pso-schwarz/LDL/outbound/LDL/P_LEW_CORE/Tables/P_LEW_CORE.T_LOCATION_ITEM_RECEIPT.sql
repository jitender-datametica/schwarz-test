/* --------------------------------------------------------------------------------
   DDL for table: t_location_item_receipt
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_location_item_receipt (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
location_item_receipt_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Materialbelegsjahr; SAP-BW: t_odp_itm_we_calc.doc_year'),
location_item_receipt_id NUMERIC(20,0) NOT NULL
OPTIONS(description='Materialbeleg; SAP-BW: t_odp_itm_we_calc.mat_doc; ELWIS: t_s_mov_item_receive_wh.itm_mov_record_id'),
location_item_receipt_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Materialbelegposition; SAP-BW: t_odp_itm_we_calc.mat_item; ELWIS: t_s_mov_item_receive_wh.itm_mov_record_pos_id'),
loc_sid BIGNUMERIC(38,0)
OPTIONS(description='Betrieb/Filiale; FK auf LOCATION; SAP-BW: t_odp_itm_we_calc.plant; ELWIS: t_s_mov_item_receive_wh.loc_sid'),
item_sid BIGNUMERIC(38,0)
OPTIONS(description='Artikel; FK auf ITEM; SAP-BW: t_odp_itm_we_calc.material; ELWIS: t_s_mov_item_receive_wh.itm_sid'),
loc_sid_wh BIGNUMERIC(38,0)
OPTIONS(description='Warehouse; FK auf LOCATION; SAP-BW: t_odp_itm_we_calc._slash_bic_slash_zmnliefwd; ELWIS: t_s_mov_item_receive_wh.wh_loc_sid'),
sup_sid BIGNUMERIC(38,0)
OPTIONS(description='Lieferant; FK auf SUPPLIER; SAP-BW: t_odp_itm_we_calc.vendor; ELWIS: t_s_mov_item_receive_wh.sup_sid'),
curr_sid_local BIGNUMERIC(38,0)
OPTIONS(description='Hauswaehrung; FK auf CURRENCY; SAP-BW: t_odp_itm_we_calc.loc_currcy; ELWIS: t_s_mov_item_receive_wh.curr_iso_cd'),
curr_sid_receipt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Belegwaehrung; FK auf CURRENCY; SAP-BW: t_odp_itm_we_calc.doc_currcy; ELWIS: t_s_mov_item_receive_wh.receipt_curr_iso_cd'),
uom_sid BIGNUMERIC(38,0)
OPTIONS(description='Mengeneinheit; FK auf UNIT OF MEASUREMENT; SAP-BW: t_odp_itm_we_calc.base_uom; ELWIS: t_s_mov_item_receive_wh.base_qty_uom_sid'),
comp_sid BIGNUMERIC(38,0) OPTIONS(description='Buchungskreis; FK auf COMPANY; '),
fisc_year_variant_cd STRING(20) NOT NULL
OPTIONS(description='Geschaeftsjahr - Variante; SAP-BW: xxx.fiscvarnt; ELWIS: -'),
deb_cred_cd STRING(20) NOT NULL
OPTIONS(description='(S)oll-/(H)aben-Kennz.; SAP-BW: t_odp_itm_we_calc.dcindic; ELWIS: t_s_mov_item_receive_wh.deb_cred_cd'),
ledger_account_cd STRING(20)
OPTIONS(description='Sachkonto; SAP-BW: t_odp_itm_we_calc.gl_account; ELWIS: t_s_mov_item_receive_wh.ledger_account_nr'),
receipt_dt DATE
OPTIONS(description='Materialbelegsdatum; SAP-BW: t_odp_itm_we_calc.doc_date; ELWIS: t_s_mov_item_receive_wh.record_dat'),
order_record_id NUMERIC(20,0) OPTIONS(description='Einkaufsbeleg; SAP-BW: t_odp_itm_we_calc.oi_ebeln'),
order_record_pos_id BIGNUMERIC(38,0) OPTIONS(description='Einkaufsbelegposition; SAP-BW: t_odp_itm_we_calc.oi_ebelp'),
list_type_mark STRING(20) OPTIONS(description='Listungsart - Code; SAP-BW: t_odp_itm_we_calc.slash_bic_slash_zmkeylist'),
list_type_label STRING(100) COLLATE 'und:ci' OPTIONS(description='Listungsart - Beschreibung; A=Aktion, S=Sortiment'),
uom_cd STRING(20)
OPTIONS(description='Mengeneinheit; SAP-BW: t_odp_itm_we_calc.base_uom; ELWIS: t_s_mov_item_receive_wh.base_qty_uom_sid'),
receive_piece_qty NUMERIC(18,5)
OPTIONS(description='Menge in Stueck; SAP-BW: t_odp_itm_we_calc._slash_bic_slash_zaquantst; ELWIS: t_s_mov_item_receive_wh.qty_piece_rcv            '),
receive_case_qty NUMERIC(18,5)
OPTIONS(description='Menge in Kolli; SAP-BW: t_odp_itm_we_calc._slash_bic_slash_zaquantka; ELWIS: t_s_mov_item_receive_wh.qty_case_rcv            _slash_bic_slash_zaquantka            '),
curr_cd_local STRING(20)
OPTIONS(description='Hauswaehrung - Code; SAP-BW: t_odp_itm_we_calc.loc_currcy; ELWIS: t_s_mov_item_receive_wh.curr_iso_cd'),
curr_cd_receipt STRING(20)
OPTIONS(description='Belegwaehrung - Code; SAP-BW: t_odp_itm_we_calc.doc_currcy; ELWIS: t_s_mov_item_receive_wh.receipt_curr_iso_cd'),
sales_gross_val NUMERIC(18,5)
OPTIONS(description='Brutto-Verkaufswert in Hauswaehrung (curr_cd_local); SAP-BW: t_odp_itm_we_calc.cpstlc; ELWIS: t_s_mov_item_receive_wh.val_retail_rcv'),
sales_net_val NUMERIC(18,5)
OPTIONS(description='Netto-Verkaufswert in Hauswaehrung (curr_cd_local); SAP-BW: t_odp_itm_we_calc.cpsvlc; ELWIS: t_s_mov_item_receive_wh.val_net_retail_rcv'),
tax_val NUMERIC(18,5)
OPTIONS(description='Steuern in Hauswaehrung (curr_cd_local); SAP-BW: t_odp_itm_we_calc._slash_bic_slash_zkstbtrlc; ELWIS: t_s_mov_item_receive_wh.house_tax_val'),
environmental_levies_val NUMERIC(18,5)
OPTIONS(description='Umweltabgaben in Hauswaehrung (curr_cd_local); SAP-BW: t_odp_itm_we_calc._slash_bic_slash_zkaumwa; ELWIS: t_s_mov_item_receive_wh.house_eco_vat_val'),
customs_val NUMERIC(18,5)
OPTIONS(description='Zoelle in Hauswaehrung (curr_cd_local); SAP-BW: t_odp_itm_we_calc._slash_bic_slash_zkazoll; ELWIS: t_s_mov_item_receive_wh.house_custm_val'),
refunds_val NUMERIC(18,5)
OPTIONS(description='Rueckverguetungen in Hauswaehrung (curr_cd_local); SAP-BW: t_odp_itm_we_calc._slash_bic_slash_zkarueckv; ELWIS: t_s_mov_item_receive_wh.house_rfnd_val'),
carrier_costs_val NUMERIC(18,5)
OPTIONS(description='Speditionskosten in Hauswaehrung (curr_cd_local); SAP-BW: t_odp_itm_we_calc._slash_bic_slash_zkaspedit; ELWIS: t_s_mov_item_receive_wh.house_carr_val'),
pur_development_net_val NUMERIC(18,5)
OPTIONS(description='EK Wert netto aus Bestellentwicklung in Hauswahrung (curr_cd_local); SAP-BW: t_odp_itm_we_calc._slash_bic_slash_zkekbtr; ELWIS: t_s_mov_item_receive_wh.house_curr_pur_ord_hist_val'),
bwcounter BIGNUMERIC(38,0)
OPTIONS(description='bwcounter; inhaltliche Bedeutung nicht klar - Vermutung: enge Beziehung zu deb_cred_cd; Werte: 1 u. 2; SAP-BW: itm_we_calc._slash_bic_slash_zmbwcount'),
dwh_cal_dt DATE NOT NULL
OPTIONS(description='Buchungsdatum; SAP-BW: t_odp_itm_we_calc.calday; ELWIS: t_s_mov_item_receive_wh.booking_dat'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, location_item_receipt_year, location_item_receipt_id, location_item_receipt_pos_id,
 curr_sid_receipt, fisc_year_variant_cd, deb_cred_cd) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id
OPTIONS(description='$Revision: 0000 $. LIRC; WE-Kalkulation aus SAP BW;             SAP-Retail: -;             SAP-BW: t_odp_itm_we_calc;             ELWIS: t_s_mov_item_receive_wh;             WAWI: ');