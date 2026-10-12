CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_user_sec AS SELECT mandant_id,
 wrg_id,
 kurs,
 wrg_typ_id
FROM kfl_production_dbp_msi_view_ios.mv_user_kurs AS K
GROUP BY mandant_id,
 wrg_id,
 kurs,
 wrg_typ_id;