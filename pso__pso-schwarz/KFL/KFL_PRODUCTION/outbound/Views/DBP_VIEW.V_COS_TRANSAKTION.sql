CREATE OR REPLACE VIEW kfl_production_dbp_view.v_cos_transaktion AS SELECT bonuspunkte_transaktion_id,
 wrg_id,
 mandant_id,
 wup_id,
 umsatz_brutto,
 bon_dat,
 bon_barcode,
 bon_nr,
 umsatz_brutto_loyalty
FROM kfl_production_dbp_data.cos_transaktion;