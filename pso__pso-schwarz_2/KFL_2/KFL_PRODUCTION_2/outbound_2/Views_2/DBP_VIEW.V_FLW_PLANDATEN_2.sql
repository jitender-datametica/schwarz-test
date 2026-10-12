CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_plandaten_2 AS SELECT gjmo,
 wup_id,
 nb_id,
 mandant_id,
 umsatz_anlieferung_plan,
 rohertrag_anlieferung_plan,
 abschrift_inventur_plan,
 wrg_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_plandaten_2;