CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_lin_kursgruppe_spr_zu_bg_2 (mandant_id, lin_kursgruppe_id,
lin_kursgruppe_bez) AS SELECT V1.mandant_id,
 V1.lin_kursgruppe_id,
 V2.lin_kursgruppe_bez
FROM kfl_production_dbp_view.v_l_lin_kursgruppe_2 AS V1
 INNER JOIN kfl_production_dbp_view.v_lin_kursgruppe_spr_zu_2 AS V2 ON V1.lin_kursgruppe_id = V2.lin_kursgruppe_id
WHERE V2.spr_id = 18
GROUP BY V1.mandant_id,
 V1.lin_kursgruppe_id,
 V2.lin_kursgruppe_bez;