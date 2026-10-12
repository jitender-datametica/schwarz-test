CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_ma_geschlecht_spr_zu_sk_2 (mandant_id, geschlecht_id, spr_id,
geschlecht_bez, anrede_bez) AS SELECT mandant_id,
 geschlecht_id,
 spr_id,
 geschlecht_bez,
 anrede_bez
FROM kfl_production_dbp_view.v_ma_geschlecht_spr_zu_2 AS V01
WHERE spr_id = 108;