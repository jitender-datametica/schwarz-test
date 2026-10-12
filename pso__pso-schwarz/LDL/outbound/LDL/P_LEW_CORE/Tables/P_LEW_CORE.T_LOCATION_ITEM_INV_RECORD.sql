/* --------------------------------------------------------------------------------
   DDL for table: t_location_item_inv_record
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_location_item_inv_record (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Betrieb; FK auf LOCATION; SAP-BW: xxx.plant'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel; FK auf ITEM; SAP-BW: xxx.material'),
comp_sid BIGNUMERIC(38,0) OPTIONS(description='Buchungskreis; FK auf COMPANY; SAP-BW: t_odp_inventur_agg.comp_code'),
curr_sid BIGNUMERIC(38,0) OPTIONS(description='Belegwahrung; FK auf CURRENCY; SAP-BW: t_odp_inventur_agg.doc_currcy'),
uom_sid BIGNUMERIC(38,0)
OPTIONS(description='Mengeneinheit Stuckvariante fur Inventurdifferenz; FK auf UNIT OF MEASUREMENT; SAP-BW: t_odp_inventur_agg._slash_bic_slash_zustvarme'),
sales_org_sid BIGNUMERIC(38,0)
OPTIONS(description='Verkaufsorganisation; FK auf SALES ORG; SAP-BW: t_odp_inventur_agg.salesorg'),
discriminator_src_cd STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Herkunftsmarkierung der Saetze: MM,WM,EWM; "MM": SAP-Retail.t_odp_inventur_agg, "WM": SAP-Retail.t_odp_inventur_wh, "EWM":SAP-EWM.t_odp_inventur_ewh'),
storage_loc_cd STRING(20) NOT NULL OPTIONS(description='Lagerort; SAP-BW: xxx.stor_loc; ELWIS: storage_loc_cd'),
storage_atom_cd STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='kuenstl Schluessel; MM/WM: "-"; EWM: String-Concat:("wm_storage_nr"-"ewm_storage_task_id"-"ewm_storage_task_pos_id"-"ewm_storage_task_sub_pos_id")'),
wm_storage_nr STRING(20) COLLATE 'und:ci'
OPTIONS(description='Lagernummer (SAP-Retail-WM; SAP-EWM); SAP-BW: t_odp_inventur_wh.whse_num; t_odp_inventur_ewh.wm_lgnum; ELWIS: t_s_inv_ewh_record.wm_storage_cd; t_s_inv_wh_record.storage_nr'),
ewm_storage_task_id NUMERIC(20,0)
OPTIONS(description='Lageraufgabe (SAP-EWM);  SAP-BW: t_odp_inventur_ewh.wm_tanum; ELWIS: t_s_inv_ewh_record.storage_task_id'),
ewm_storage_task_pos_id BIGNUMERIC(38,0)
OPTIONS(description='Lageraufgabenposition (SAP-EWM); SAP-BW: t_odp_inventur_ewh.wm_tapos; ELWIS: t_s_inv_ewh_record.storage_task_pos_id'),
ewm_storage_task_sub_pos_id BIGNUMERIC(38,0)
OPTIONS(description='Unterposition einer Lageraufgabe (SAP-EWM); SAP-BW: t_odp_inventur_ewh.wm_wtsubit; ELWIS: t_s_inv_ewh_record.storage_task_sub_pos_id'),
fisc_year BIGNUMERIC(38,0) OPTIONS(description='Geschaeftsjahr; SAP-BW: xxx.fiscyear; ELWIS: -'),
fisc_year_variant_cd STRING(20) OPTIONS(description='Geschaeftsjahr - Variante; SAP-BW: xxx.fiscvarnt; ELWIS: -'),
inv_nr STRING(20)
OPTIONS(description='Inventurnummer; SAP-BW: t_odp_inventur_agg/wh/ewh._slash_bic_slash_zminvnu1; ELWIS: inv_nr'),
inv_id NUMERIC(20,0) NOT NULL
OPTIONS(description='Inventurbelegnummer; SAP-BW: t_odp_inventur_agg/wh._slash_bic_slash_zmiblnr; t_odp_inventur_ewh.zmnumber; ELWIS: inv_id'),
inv_type_mark STRING(20)
OPTIONS(description='Herkunft - Code (A, B, C, D); SAP-BW: t_odp_inventur_agg._slash_bic_slash_zmpidtype; ELWIS: inv_type_cd'),
inv_type_label STRING(100) COLLATE 'und:ci'
OPTIONS(description='Herkunft - Beschreibung: A=Vollinventur; B=Teilinventur; C=Gesellschaftsinitiierte Einzelinventur; D=Filialinitiierte Einzelinventur; '),
inv_period_start_dt DATE
OPTIONS(description='Vorheriges Inventurdatum + 1; SAP-BW: t_odp_inventur_agg/wh._slash_bic_slash_zmdvorinv + 1; ELWIS: inv_valid_from_dat'),
inv_record_dt DATE OPTIONS(description='Belegdatum; SAP-BW: t_odp_inventur_agg/wh.calday; ELWIS: dat_formdate'),
inv_record_year BIGNUMERIC(38,0)
OPTIONS(description='Belegjahr; SAP-BW: t_odp_inventur_agg.doc_year; ELWIS: inv_record_year'),
inv_record_id NUMERIC(20,0)
OPTIONS(description='Matrialbelegnummer; SAP-BW: t_odp_inventur_agg.mat_doc; ELWIS: inv_record_id'),
inv_record_pos_id BIGNUMERIC(38,0)
OPTIONS(description='Material Document Item; SAP-BW: t_odp_inventur_agg.mat_item; ELWIS: inv_record_pos_id'),
inv_move_type_mark STRING(20)
OPTIONS(description='Bewegungsart - Code (701,702); SAP-BW: t_odp_inventur_agg.movetyp; ELWIS: inv_mov_type_cd'),
inv_move_type_label STRING(100) COLLATE 'und:ci'
OPTIONS(description='Bewegungsart - Beschreibung; 701=Wareneingang Inventur Lager; 702=Warenausgang Inventur Lager;'),
uom_cd STRING(20)
OPTIONS(description='Mengeneinheit Stuckvariante fur Inventurdifferenz; SAP-BW: t_odp_inventur_agg._slash_bic_slash_zustvarme'),
sales_qty NUMERIC(18,5)
OPTIONS(description='Abverkaufsmenge im Inventurzeitraum in ST/KG; SAP-BW: t_odp_inventur_agg._slash_bic_slash_zaamengst; ELWIS: qty_piece_sold'),
sales_case_qty NUMERIC(18,5)
OPTIONS(description='Abverkaufsmenge im Inventurzeitraum in Kolli; SAP-BW: t_odp_inventur_agg._slash_bic_slash_zaamengka; ELWIS: qty_case_sold'),
inv_diff_qty NUMERIC(18,5)
OPTIONS(description='Inventurdifferenz aus Mat-Beleg in ST/KG; SAP-BW: t_odp_inventur_agg._slash_bic_slash_zaindifst; ELWIS: qty_inv_diff_piece'),
inv_diff_case_qty NUMERIC(18,5)
OPTIONS(description='Inventurdifferenz aus Mat-Beleg in Kolli; SAP-BW: t_odp_inventur_agg._slash_bic_slash_zaindifka; ELWIS: qty_inv_diff_case'),
curr_cd STRING(20) OPTIONS(description='Belegwahrung; SAP-BW: t_odp_inventur_agg.doc_currcy'),
gross_val NUMERIC(18,5)
OPTIONS(description='Brutto-Verkaufswert in Hauswahrung; SAP-BW: t_odp_inventur_agg.cpstlc; ELWIS: gross_val'),
net_val NUMERIC(18,5)
OPTIONS(description='Netto-Verkaufswert in Hauswahrung; SAP-BW: t_odp_inventur_agg.cpsvlc; ELWIS: sales_net_val'),
inv_diff_gross_val NUMERIC(18,5)
OPTIONS(description='Inventurdifferenzwert durch. VK brutto; SAP-BW: t_odp_inventur_agg._slash_bic_slash_zkibvalu; ELWIS: gross_val_inv_diff'),
inv_diff_net_val NUMERIC(18,5)
OPTIONS(description='Inventurdifferenzwert durch. VK netto; SAP-BW: t_odp_inventur_agg._slash_bic_slash_zkinvalu; ELWIS: net_val_inv_diff'),
sales_gross_val NUMERIC(18,5)
OPTIONS(description='Brutto-Umsatz im Inventurzeitraum; SAP-BW: t_odp_inventur_agg._slash_bic_slash_zkuminb; ELWIS: val_rtl_inv'),
sales_net_val NUMERIC(18,5)
OPTIONS(description='Netto-Umsatz im Inventurzeitraum; SAP-BW: t_odp_inventur_agg._slash_bic_slash_zkuminv; ELWIS: val_rtl_net_inv'),
dwh_cal_dt DATE NOT NULL
OPTIONS(description='Inventurdatum; SAP-BW: t_odp_inventur_agg._slash_bic_slash_zmdzldat; ELWIS: inv_valid_to_dat'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (loc_sid, item_sid, storage_loc_cd, inv_id, dwh_cal_dt) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id
OPTIONS(description='$Revision: 0000 $. Ums z. Inv.zeitraeumen .(In SAP-BW berechnet/aufbereitet);             SAP-Retail: z_ds_mm(wm)_inventure;              SAP-EWM: 0wm_wt (Lageraufgaben);             SAP-BW: MM=t_odp_inventur_agg WM=..tur_wh EWM=..tur_ewh;             ELWIS: t_s_inv_(wh/ewh)_record');