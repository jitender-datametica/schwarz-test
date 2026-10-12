CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_artbew_scanning_2 (in_kunde_id, mandant_id, bewart_id, gp_id,
art_id, dat, in_art_id, in_art_nr, gtin_kasse, vorgang_scanned, vorgang_keyed, vorgang_scanned_einzeln,
vorgang_keyed_einzeln, anzahl_bon, anzahl_registriert) AS SELECT V04.flw_kunde_id AS in_kunde_id,
 V01.mandant_id,
 V01.bewart_id,
 V01.gp_id,
 V01.art_id,
 V01.dat,
 V03.in_art_id,
 V03.in_art_nr,
 V01.gtin_kasse,
 V01.vorgang_scanned,
 V01.vorgang_keyed,
 V01.vorgang_scanned_einzeln,
 V01.vorgang_keyed_einzeln,
 V01.anzahl_bon,
 V01.anzahl_registriert
FROM kfl_production_dbp_view.v_artbew_scanning_2 AS V01
 INNER JOIN kfl_production_dbp_msi_view_flw.mv_l_in_art_2 AS V03 ON V01.art_id = V03.art_id AND V01.mandant_id = V03.mandant_id
   
 LEFT JOIN kfl_production_dbp_view.v_flw_kunde_2 AS V04 ON V01.wup_id = V04.wup_id AND V01.mandant_id = V04.mandant_id
WHERE V01.mandant_id IN (1, 2);