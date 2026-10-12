CREATE OR REPLACE VIEW kfl_production_dbp_view.v_aktion_2 AS SELECT aktion_id,
 mandant_id,
 bewart_id,
 aktionsart_id,
 werbe_kat_id,
 dat_von,
 dat_bis,
 preisaktiviert_fg,
 kjwo_von,
 aktion_typ_id
FROM kfl_production_dbp_data.aktion_2;