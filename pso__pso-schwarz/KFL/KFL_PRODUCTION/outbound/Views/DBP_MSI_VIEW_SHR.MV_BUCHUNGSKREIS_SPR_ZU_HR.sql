CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_buchungskreis_spr_zu_hr (mandant_id, buchungskreis_id,
system_id, buchungskreis_bez) AS SELECT mandant_id,
 buchungskreis_id,
 system_id,
 buchungskreis_bez
FROM kfl_production_dbp_view.v_buchungskreis_spr_zu AS V01
WHERE system_id IN (85, 87, 95)
 AND spr_id = 65;