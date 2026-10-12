CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_user_sec_2 AS SELECT mandant_id,
 wrg_id,
 kurs_2,
 wrg_typ_id
FROM kfl_production_dbp_msi_view_ios.mv_user_kurs_2 AS K
GROUP BY mandant_id,
 wrg_id,
 kurs_2,
 wrg_typ_id;