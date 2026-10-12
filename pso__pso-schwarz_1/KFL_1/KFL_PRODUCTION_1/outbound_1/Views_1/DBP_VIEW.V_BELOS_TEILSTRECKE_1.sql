CREATE OR REPLACE VIEW kfl_production_dbp_view.v_belos_teilstrecke_1 AS SELECT mandant_id,
 belos_vorgang_id,
 teilstrecke_nr,
 belos_adresse_absender_id,
 belos_adresse_empfaenger_id,
 sendung_fg,
 belos_ladung_id,
 teilstrecke_id,
 anz_stellplatz,
 stellplatz_menge_einh_id,
 belosart_fg
FROM kfl_production_dbp_data.belos_teilstrecke_1;