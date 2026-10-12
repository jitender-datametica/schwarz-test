CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_ma_geschlecht_spr_zu_hr_1 (mandant_id, geschlecht_id, spr_id,
geschlecht_bez, anrede_bez) AS SELECT mandant_id,
 geschlecht_id,
 spr_id,
 geschlecht_bez,
 anrede_bez
FROM kfl_production_dbp_view.v_ma_geschlecht_spr_zu_1 AS V01
WHERE spr_id = 65;