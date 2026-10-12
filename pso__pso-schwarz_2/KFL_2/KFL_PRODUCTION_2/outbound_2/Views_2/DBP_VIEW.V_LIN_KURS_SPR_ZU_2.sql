CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lin_kurs_spr_zu_2 AS SELECT lin_kurs_id,
 spr_id,
 mandant_id,
 lin_bericht,
 lin_kurs_bez
FROM kfl_production_dbp_data.lin_kurs_spr_zu_2;