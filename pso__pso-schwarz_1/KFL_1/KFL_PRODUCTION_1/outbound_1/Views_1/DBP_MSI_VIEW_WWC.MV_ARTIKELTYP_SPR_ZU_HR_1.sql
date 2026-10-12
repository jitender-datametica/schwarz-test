CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_artikeltyp_spr_zu_hr_1 (mandant_id, attyp, spr_id,
artikeltyp_bez) AS SELECT mandant_id,
 artikeltyp_id AS attyp,
 spr_id,
 artikeltyp_bez
FROM kfl_production_dbp_view.v_artikeltyp_spr_zu_1 AS V01
WHERE spr_id = 65;