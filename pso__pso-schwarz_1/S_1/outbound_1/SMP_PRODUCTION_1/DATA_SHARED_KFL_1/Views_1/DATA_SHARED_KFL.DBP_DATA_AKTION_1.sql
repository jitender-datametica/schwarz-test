CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_aktion_1 (aktion_id, mandant_id, bewart_id, aktionsart_id,
werbe_kat_id, dat_von, dat_bis, preisaktiviert_fg, kjwo_von, aktion_typ_id, td_update, td_insert) AS SELECT aktion_id,
 mandant_id,
 bewart_id,
 aktionsart_id,
 werbe_kat_id,
 dat_von,
 dat_bis,
 preisaktiviert_fg,
 kjwo_von,
 aktion_typ_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.aktion_1;