CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_ts_projekt_qs AS SELECT V02.projekt_id,
 V02.cpr_ext_id AS projekt_nr,
 V01.qs_fg,
 V01.user_id,
 V01.dat_aenderung,
 CURRENT_DATE AS dat_heute
FROM kfl_production_dbp_view.v_cpr_projekt_per AS V02
 LEFT JOIN kfl_production_dbp_msi_view_ios.ts_projekt_qs AS V01 ON V02.cpr_ext_id = V01.cpr_ext_id
WHERE V02.dat_bis = DATE '9999-12-31'
 AND V02.cpr_ext_id IS NOT NULL;