CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ma_pers_teilbereich_zu_per_2 AS SELECT mandant_id,
 pers_teilbereich_id,
 mitarbeiter_id,
 kjmo,
 buchungskreis_id,
 pers_bereich_id
FROM kfl_production_dbp_data.ma_pers_teilbereich_zu_per_2;