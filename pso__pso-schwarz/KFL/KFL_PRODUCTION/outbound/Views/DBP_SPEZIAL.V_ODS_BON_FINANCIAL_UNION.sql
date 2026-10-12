CREATE OR REPLACE VIEW kfl_production_dbp_spezial.v_ods_bon_financial_union (bon_id, bon_zeile, mandant_id,
umsatz_brutto, financial_grund_id, financial_kommentar, auszahlung_fg, wup_id, start_bon_zeile, bon_dat) AS SELECT
 bon_id,
 bon_zeile,
 mandant_id,
 umsatz_brutto,
 financial_grund_id,
 financial_kommentar,
 auszahlung_fg,
 wup_id,
 start_bon_zeile,
 bon_dat
FROM kfl_production_dbp_ods.ods_bon_financial
UNION ALL
SELECT bon_id,
 bon_zeile,
 mandant_id,
 umsatz_brutto,
 financial_grund_id,
 financial_kommentar,
 auszahlung_fg,
 wup_id,
 start_bon_zeile,
 bon_dat
FROM kfl_production_dbp_ods_archiv.ods_bon_financial;