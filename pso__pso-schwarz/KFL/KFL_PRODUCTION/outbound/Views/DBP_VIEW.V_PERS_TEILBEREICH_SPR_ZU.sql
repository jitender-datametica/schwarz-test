CREATE OR REPLACE VIEW kfl_production_dbp_view.v_pers_teilbereich_spr_zu AS SELECT mandant_id,
 pers_teilbereich_id,
 spr_id,
 buchungskreis_id,
 pers_bereich_id,
 persteilbereich_bez
FROM kfl_production_dbp_data.pers_teilbereich_spr_zu;