CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_l_artikeltyp_1 (mandant_id, attyp) AS SELECT mandant_id,
 artikeltyp_id AS attyp
FROM kfl_production_dbp_view.v_l_artikeltyp_1 AS V01;