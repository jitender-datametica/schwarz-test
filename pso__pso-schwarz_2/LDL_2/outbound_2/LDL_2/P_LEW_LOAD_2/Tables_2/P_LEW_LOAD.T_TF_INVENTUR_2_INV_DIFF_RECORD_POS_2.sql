CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_inventur_2_inv_diff_record_pos_2 (
client_id BIGNUMERIC(38) OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
lidl_country STRING(40),
inventur_soursystem STRING(4) NOT NULL,
inventur_doc_year INTEGER NOT NULL,
inventur_mat_item INTEGER NOT NULL,
inventur_zmbwcount INTEGER NOT NULL,
inventur_mat_doc STRING(20) NOT NULL,
inventur_fiscvarnt STRING(4) NOT NULL,
record_year BIGNUMERIC(38) OPTIONS(description='Belegjahr; SAP-BW: inventur.doc_year'),
record_cd STRING(20) COLLATE 'und:ci' OPTIONS(description='Belegnummer; SAP-BW: inventur.mat_doc'),
record_pos_id BIGNUMERIC(38) OPTIONS(description='Belegposition; SAP-BW: inventur.mat_item'),
record_pos_sub_id BIGNUMERIC(38) OPTIONS(description='Belegsubposition; SAP-BW: inventur.zmbwcount'),
src_werks STRING(40),
src_matnr STRING(40),
src_bukrs STRING(40),
src_vkorg STRING(40),
src_msehi STRING(40),
src_waers STRING(40),
move_type_cd STRING(20) OPTIONS(description='Buchungsart (s. t_item_movement_record_pos_2); SAP-BW: inventur.movetyp'),
storage_loc_cd STRING(20) COLLATE 'und:ci'
OPTIONS(description='Lagerort innerhalb der Location_2; SAP-BW: inventur.stor_loc'),
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
OPTIONS(description='Inventurdifferenz bewertet mit durchschnittlichem VK_2-Preis brutto; SAP-BW: inventur.zkibvalu'),
inv_diff_net_val NUMERIC(18,5)
OPTIONS(description='Inventurdifferenz bewertet mit durchschnittlichem VK_2-Preis netto; SAP-BW: inventur.zkinvalu'),
dwh_cal_dt DATE OPTIONS(description='Belegdatum; SAP-BW: inventur.calday'),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);