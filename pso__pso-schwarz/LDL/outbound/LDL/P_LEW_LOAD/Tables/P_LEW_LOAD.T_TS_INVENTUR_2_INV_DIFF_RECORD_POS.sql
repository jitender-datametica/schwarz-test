CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_inventur_2_inv_diff_record_pos (
record_id INTEGER,
client_id BIGNUMERIC(38) OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
record_year BIGNUMERIC(38) OPTIONS(description='Belegjahr; SAP-BW: inventur.doc_year'),
record_cd STRING(20) COLLATE 'und:ci' OPTIONS(description='Belegnummer; SAP-BW: inventur.mat_doc'),
record_pos_id BIGNUMERIC(38) OPTIONS(description='Belegposition; SAP-BW: inventur.mat_item'),
record_pos_sub_id BIGNUMERIC(38) OPTIONS(description='Belegsubposition; SAP-BW: inventur.zmbwcount'),
loc_sid BIGNUMERIC(38) OPTIONS(description='WH / Filiale; SAP-BW: inventur.plant'),
item_sid BIGNUMERIC(38) OPTIONS(description='Artikel; SAP-BW: inventur.material'),
comp_sid BIGNUMERIC(38) OPTIONS(description='Buchungskreis; FK auf COMPANY; SAP-BW: inventur.comp_code'),
sales_org_sid BIGNUMERIC(38) OPTIONS(description='Verkaufsorganisation; FK auf SALES ORG; SAP-BW: inventur.salesorg'),
uom_sid BIGNUMERIC(38)
OPTIONS(description='Mengeneinheit der Inventurdifferenz; FK auf lew_core.t_unit_of_measurement; SAP-BW: inventur.zustvarme'),
curr_sid BIGNUMERIC(38)
OPTIONS(description='Belegwaehrung: Waehrung der bewerteten Inventurdifferenz; FK auf lew_core.t_currency; SAP-BW: inventur.doc_currcy'),
move_type_cd STRING(20) OPTIONS(description='Buchungsart (s. t_item_movement_record_pos); SAP-BW: inventur.movetyp'),
storage_loc_cd STRING(20) COLLATE 'und:ci'
OPTIONS(description='Lagerort innerhalb der Location; SAP-BW: inventur.stor_loc'),
inv_nr STRING(20) COLLATE 'und:ci'
OPTIONS(description='zugehoerige Inventurnummer (falls vorhanden); SAP-BW: inventur.zminvnu1'),
inv_record_cd STRING(20) COLLATE 'und:ci'
OPTIONS(description='zugehoerige Inventurbelegnummer (falls vorhanden); SAP-BW: inventur.zmiblnr'),
inv_dt DATE OPTIONS(description='zugehoeriges Inventurdatum; SAP-BW: inventur.zmdzldat'),
inv_type_cd STRING(20) COLLATE 'und:ci'
OPTIONS(description='Inventurtyp (A=Vollinventur; B=Teilinventur; C=Gesellschaftsinitiierte Einzelinventur; D=Filialinitiierte Einzelinventur); SAP-BW: inventur.zmpidtype'),
uom_cd STRING(20) OPTIONS(description='Mengeneinheit der Inventurdifferenz; SAP-BW: inventur.zustvarme'),
inv_diff_qty NUMERIC(18,5) OPTIONS(description='Inventurdifferenz in Mengeneinheit uom_cd; SAP-BW: inventur.zaquantst'),
curr_cd STRING(20)
OPTIONS(description='Belegwaehrung: Waehrung der bewerteten Inventurdifferenz; SAP-BW: inventur.doc_currcy'),
inv_diff_gross_val NUMERIC(18,5)
OPTIONS(description='Inventurdifferenz bewertet mit durchschnittlichem VK-Preis brutto; SAP-BW: inventur.zkibvalu'),
inv_diff_net_val NUMERIC(18,5)
OPTIONS(description='Inventurdifferenz bewertet mit durchschnittlichem VK-Preis netto; SAP-BW: inventur.zkinvalu'),
dwh_cal_dt DATE OPTIONS(description='Belegdatum; SAP-BW: inventur.calday'),
dwh_load_id BIGNUMERIC(38)
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);