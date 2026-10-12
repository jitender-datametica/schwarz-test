CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_artkz_posten (posten_id, posten_bez, mandant_id) AS SELECT
 V01.posten_id,
 V01.posten_bez,
 V01.mandant_id
FROM kfl_production_dbp_view.v_artkz_posten AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_spr_zu AS V02 ON V01.spr_id = V02.spr_id
WHERE V01.posten_id IN ('PN', '') AND V01.mandant_id = 1
 OR V01.posten_id IN ('0', '1') AND V01.mandant_id = 2;