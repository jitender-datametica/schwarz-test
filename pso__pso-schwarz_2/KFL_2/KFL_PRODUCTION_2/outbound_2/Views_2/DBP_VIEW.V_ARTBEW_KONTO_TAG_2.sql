CREATE OR REPLACE VIEW kfl_production_dbp_view.v_artbew_konto_tag_2 AS SELECT konto_id,
 arthiertyp_id,
 mandant_id,
 wup_id,
 nb_id,
 bewart_id,
 dat,
 umsatz_brutto,
 umsatz_netto,
 umsatz_wrg,
 umsatz_brutto_konz,
 umsatz_netto_konz
FROM kfl_production_dbp_data.artbew_konto_tag_2;