CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_artbew_scanning_2 (wup_id, mandant_id, bewart_id, gp_id,
nb_id, art_id, dat, aktion_id, promo_fg, ean_id, vorgang_scanned, vorgang_keyed, vorgang_scanned_einzeln,
vorgang_keyed_einzeln, anzahl_bon, anzahl_registriert) AS SELECT wup_id,
 mandant_id,
 bewart_id,
 gp_id,
 nb_id,
 art_id,
 dat,
 aktion_id,
 promo_fg,
 gtin_kasse AS ean_id,
 vorgang_scanned,
 vorgang_keyed,
 vorgang_scanned_einzeln,
 vorgang_keyed_einzeln,
 anzahl_bon,
 anzahl_registriert
FROM kfl_production_dbp_data.artbew_scanning_2
WHERE (mandant_id <> 5 OR art_id <> 206731500)
 AND (mandant_id <> 2 OR art_id <> 208124500)
 AND (mandant_id <> 3 OR art_id <> 208113690)
 AND (mandant_id <> 6 OR art_id <> 208131570)
 AND (mandant_id NOT IN (4, 7) OR art_id <> 208114740)
 AND (mandant_id <> 8 OR art_id <> 208131640);