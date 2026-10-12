CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_umbewertung (mandant_id, pae_beleg_id, kj, dat_beleg,
dat_erfasst, zeit_erfasst, dat_zeit_erfasst, beleg_user_name) AS SELECT mandant_id,
 CAST(pae_beleg_id AS NUMERIC) AS pae_beleg_id,
 kj,
 dat_beleg,
 dat_erfasst,
 zeit_erfasst,
 DATETIME(dat_erfasst, zeit_erfasst) AS dat_zeit_erfasst,
 beleg_user_name
FROM kfl_production_dbp_view.v_umbewertung AS V01;