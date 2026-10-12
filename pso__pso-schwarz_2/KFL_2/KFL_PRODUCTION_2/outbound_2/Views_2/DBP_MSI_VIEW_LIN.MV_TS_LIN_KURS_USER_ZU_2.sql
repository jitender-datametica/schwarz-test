CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_ts_lin_kurs_user_zu_2 (mandant_id, lin_kurs_id, user_id,
loesch_fg) AS SELECT mandant_id,
 lin_kurs_id,
 user_id,
 0 AS loesch_fg
FROM kfl_production_dbp_msi_view_lin.ts_lin_kurs_user_zu_2;