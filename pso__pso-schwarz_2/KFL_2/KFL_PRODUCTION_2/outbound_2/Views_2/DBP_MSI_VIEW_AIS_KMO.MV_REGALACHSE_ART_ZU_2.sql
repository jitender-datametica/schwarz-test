CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_regalachse_art_zu_2 (mandant_id, regalachse_id, art_id,
fachboden_nr, fachboden_pos, regional_kz, kapazitaet, kapazitaet_menge_einh_id) AS SELECT mandant_id,
 regalachse_id,
 art_id,
 fachboden_nr,
 fachboden_pos,
 regional_kz,
 kapazitaet,
 kapazitaet_menge_einh_id
FROM kfl_production_dbp_view.v_regalachse_art_zu_2 AS V01
WHERE mandant_id <> 1;