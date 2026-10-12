CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_altersstruktur_spr_zu_1 AS SELECT altersstruktur_id,
 altersstruktur_bez,
 spr_id
FROM kfl_production_dbp_view.v_altersstruktur_spr_zu_1 AS V01
WHERE spr_id = 22;