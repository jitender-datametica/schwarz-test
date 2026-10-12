CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_buchungskreis_spr_zu_cz_2 (mandant_id, bukrs, spr_id,
buchungskreis_bez) AS SELECT mandant_id,
 buchungskreis_id AS bukrs,
 spr_id,
 buchungskreis_bez
FROM kfl_production_dbp_view.v_buchungskreis_spr_zu_2 AS V01
WHERE spr_id = 124;