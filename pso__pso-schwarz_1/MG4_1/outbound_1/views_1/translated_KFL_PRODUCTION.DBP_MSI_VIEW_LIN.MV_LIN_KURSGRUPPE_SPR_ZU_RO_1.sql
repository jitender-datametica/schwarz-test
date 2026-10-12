CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_lin_kursgruppe_spr_zu_ro_1 (mandant_id, lin_kursgruppe_id,
lin_kursgruppe_bez) AS SELECT v1.mandant_id,
 v1.lin_kursgruppe_id,
 v2.lin_kursgruppe_bez
FROM kfl_production_dbp_view.v_l_lin_kursgruppe_1 AS v1
 INNER JOIN kfl_production_dbp_view.v_lin_kursgruppe_spr_zu_1 AS v2 ON v1.lin_kursgruppe_id = v2.lin_kursgruppe_id
WHERE v2.spr_id = 95
GROUP BY v1.mandant_id,
 v1.lin_kursgruppe_id,
 v2.lin_kursgruppe_bez;