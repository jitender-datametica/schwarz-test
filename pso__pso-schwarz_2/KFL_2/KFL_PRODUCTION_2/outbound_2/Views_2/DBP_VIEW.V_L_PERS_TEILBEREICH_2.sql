CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_pers_teilbereich_2 AS SELECT mandant_id,
 pers_teilbereich_id,
 buchungskreis_id,
 pers_bereich_id,
 modsz
FROM kfl_production_dbp_data.l_pers_teilbereich_2;