CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_lin_kurs_1 AS SELECT lin_kurs_id,
 mandant_id,
 sortkz,
 lin_kursgruppe_id,
 lin_bericht,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_lin_kurs_1;