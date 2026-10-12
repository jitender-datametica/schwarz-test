CREATE OR REPLACE VIEW kfl_production_dbp_view.v_artbew_konto_1 AS SELECT mandant_id,
 wup_id,
 konto_id,
 bewart_id,
 nb_id,
 arthiertyp_id,
 umsatz_brutto,
 umsatz_netto,
 umsatz_wrg,
 umsatz_brutto_konz,
 umsatz_netto_konz,
 kjmo
FROM kfl_production_dbp_data.artbew_konto_1;