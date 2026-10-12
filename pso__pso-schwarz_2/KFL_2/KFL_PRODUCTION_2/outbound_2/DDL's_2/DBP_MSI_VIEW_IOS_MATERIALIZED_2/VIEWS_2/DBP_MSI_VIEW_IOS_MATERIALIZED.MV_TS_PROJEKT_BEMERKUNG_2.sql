CREATE OR REPLACE VIEW dbp_msi_view_ios_materialized.mv_ts_projekt_bemerkung_2 (projekt_id, projekt_nr, projekt_bemerkung
, user_id, dat_aenderung, dat_heute) AS SELECT V02.projekt_id,
 V02.cpr_ext_id AS projekt_nr,
 V01.projekt_bemerkung,
 V01.user_id,
 V01.dat_aenderung,
 CURRENT_DATE AS dat_heute
FROM kfl_production_dbp_view.v_cpr_projekt_per_2 AS V02
 LEFT JOIN dbp_msi_view_ios_materialized.ts_projekt_bemerkung_2 AS V01 ON V02.cpr_ext_id = V01.cpr_ext_id
WHERE V02.dat_bis = DATE '9999-12-31'
 AND V02.cpr_ext_id IS NOT NULL;