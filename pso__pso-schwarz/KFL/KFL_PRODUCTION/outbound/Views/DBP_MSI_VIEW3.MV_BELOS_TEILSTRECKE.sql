CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_belos_teilstrecke (mandant_id, belos_vorgang_id,
belos_leistungsart_id, belos_adresse_absender_id, belos_adresse_empfaenger_id, sendung_fg, belos_ladung_id,
teilstrecke_id, anz_stellplatz, stellplatz_menge_einh_id) AS SELECT mandant_id,
 belos_vorgang_id,
 teilstrecke_nr AS belos_leistungsart_id,
 belos_adresse_absender_id,
 belos_adresse_empfaenger_id,
 sendung_fg,
 belos_ladung_id,
 teilstrecke_id,
 anz_stellplatz,
 stellplatz_menge_einh_id
FROM kfl_production_dbp_view.v_belos_teilstrecke
WHERE sendung_fg = 1
 AND belosart_fg = 0;