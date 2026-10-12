CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_lin_kursgruppe_1 AS SELECT lin_kursgruppe_id,
 mandant_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_lin_kursgruppe_1;