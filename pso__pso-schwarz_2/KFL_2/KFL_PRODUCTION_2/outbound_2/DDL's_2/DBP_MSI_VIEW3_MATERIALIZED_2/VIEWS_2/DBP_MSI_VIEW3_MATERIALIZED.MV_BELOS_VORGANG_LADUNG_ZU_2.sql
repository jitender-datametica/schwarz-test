CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_belos_vorgang_ladung_zu_2 (mandant_id,
belos_vorgang_id, teilstrecke_nr, belos_adresse_absender_id, belos_adresse_empfaenger_id, sendung_fg, belos_ladung_id,
teilstrecke_id) AS SELECT mandant_id,
 belos_vorgang_id,
 teilstrecke_nr,
 belos_adresse_absender_id,
 belos_adresse_empfaenger_id,
 sendung_fg,
 belos_ladung_id,
 teilstrecke_id
FROM kfl_production_dbp_view.v_belos_teilstrecke_2
WHERE sendung_fg = 0;