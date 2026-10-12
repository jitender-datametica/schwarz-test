CREATE OR REPLACE VIEW kfl_production_dbp_v_ods.v_ods_bon_financial AS SELECT bon_id,
 bon_zeile,
 mandant_id,
 umsatz_brutto,
 financial_grund_id,
 financial_kommentar,
 auszahlung_fg,
 wup_id,
 start_bon_zeile,
 bon_dat,
 td_insert,
 td_update
FROM kfl_production_dbp_ods.ods_bon_financial;