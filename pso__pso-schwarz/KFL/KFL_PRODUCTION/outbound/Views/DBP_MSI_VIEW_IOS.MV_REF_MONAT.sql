CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_ref_monat (ref_monat) AS SELECT MIN(dat) AS ref_monat
FROM kfl_production_dbp_view.v_tag
WHERE akt_mo = 0;