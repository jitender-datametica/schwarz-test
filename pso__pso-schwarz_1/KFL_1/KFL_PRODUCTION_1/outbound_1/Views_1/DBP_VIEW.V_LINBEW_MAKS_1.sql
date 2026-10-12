CREATE OR REPLACE VIEW kfl_production_dbp_view.v_linbew_maks_1 AS SELECT mandant_id,
 lin_kurs_id,
 kjmo,
 maks_id,
 learning_historie_fg,
 dat_ausbildung_von,
 dat_ausbildung_bis,
 wup_id,
 rate_group,
 ausbildung_id
FROM kfl_production_dbp_data.linbew_maks_1;