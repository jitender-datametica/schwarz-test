CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw_materialized.mv_l_artkz_discount_2 (discount_id, discount_bez,
mandant_id) AS SELECT V01.discount_id,
 V01.discount_bez,
 V01.mandant_id
FROM kfl_production_dbp_view.v_artkz_discount_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu_2 AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.mandant_id = 1
UNION ALL
SELECT 0 AS discount_id,
 '' AS discount_bez,
 mandant_id
FROM kfl_production_dbp_view.v_mandant_2
WHERE mandant_id = 2;