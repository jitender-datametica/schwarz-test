/* --------------------------------------------------------------------------------
   DDL for table: t_inv_diff_record_pos_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:09 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_inv_diff_record_pos_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
record_year BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Belegjahr; SAP-BW: inventur.doc_year'),
record_cd STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Belegnummer; SAP-BW: inventur.mat_doc'),
record_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Belegposition; SAP-BW: inventur.mat_item'),
record_pos_sub_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Belegsubposition; SAP-BW: inventur.zmbwcount'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='WH / Filiale; SAP-BW: inventur.plant'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel_2; SAP-BW: inventur.material'),
comp_sid BIGNUMERIC(38,0) OPTIONS(description='Buchungskreis; FK auf COMPANY; SAP-BW: inventur.comp_code'),
sales_org_sid BIGNUMERIC(38,0) OPTIONS(description='Verkaufsorganisation; FK auf SALES_2 ORG; SAP-BW: inventur.salesorg'),
uom_sid BIGNUMERIC(38,0)
OPTIONS(description='Mengeneinheit der Inventurdifferenz; FK auf lew_core.t_unit_of_measurement_2; SAP-BW: inventur.zustvarme'),
curr_sid BIGNUMERIC(38,0)
OPTIONS(description='Belegwaehrung: Waehrung der bewerteten Inventurdifferenz; FK auf lew_core.t_currency_2; SAP-BW: inventur.doc_currcy'),
move_type_cd STRING(20) OPTIONS(description='Buchungsart (s. t_item_movement_record_pos_2); SAP-BW: inventur.movetyp'),
storage_loc_cd STRING(20) COLLATE 'und:ci' NOT NULL
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
dwh_cal_dt DATE NOT NULL OPTIONS(description='Belegdatum; SAP-BW: inventur.calday'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (client_id, record_year, record_pos_id, record_pos_sub_id) NOT ENFORCED
) CLUSTER BY client_id, dwh_cal_dt
OPTIONS(description='$Revision: 0000 $. Differenzwert im Vergleich zu einer Inventur_2;             Jeder Eintrag repraesentiert eine_2 Inventurwertveraenderung eines Artikels in einem WH/Filiale;             SAP-Sprech: Materialbelege mit Inventurbezug             SAP-Retail: mseg + weiteres;             SAP-BW:  inventur_2');