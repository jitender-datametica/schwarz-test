CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_kompensation_2 AS SELECT art_id,
 mandant_id,
 komp_basismenge_einh_id,
 art_id_ref,
 td_update,
 td_insert
FROM kfl_production_dbp_data.art_kompensation_2;