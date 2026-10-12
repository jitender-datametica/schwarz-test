CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_kostenstelle_per_2 AS SELECT mandant_id,
 kostenstelle_id,
 krk_id,
 dat_von,
 dat_bis,
 pc_id,
 buchungskreis_id,
 geschaeftsbereich_id,
 kostenstellenart_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_kostenstelle_per_2;