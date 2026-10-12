CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_buchungsperiode_1 AS SELECT buchungsperiode_id,
 gj_variante_id,
 spr_id,
 buchungsperiode_bez,
 krk_id
FROM kfl_production_dbp_data.l_buchungsperiode_1;