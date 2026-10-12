CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_wup_listung_kjwo_2 AS SELECT mandant_id,
 art_id,
 wg_id,
 wup_id,
 nb_id,
 kjwo,
 kreistyp_gruppe_id,
 listung_id
FROM kfl_production_dbp_data.art_wup_listung_kjwo_2;