CREATE OR REPLACE VIEW kfl_production_dbp_view.v_regalachse_art_zu_2 AS SELECT mandant_id,
 regalachse_id,
 art_id,
 fachboden_nr,
 fachboden_pos,
 regional_kz,
 kapazitaet,
 kapazitaet_menge_einh_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.regalachse_art_zu_2;