CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_werbe_medium_spr_zu (mandant_id, medien_kz, spr_id,
werbe_medium_bez) AS SELECT mandant_id,
 medien_kz,
 spr_id,
 werbe_medium_bez
FROM kfl_production_dbp_view.v_werbe_medium_spr_zu
WHERE mandant_id = 1
 AND spr_id = 22;