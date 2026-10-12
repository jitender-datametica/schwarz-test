CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_artikeltyp_2 (artikeltyp_id, artikeltyp_bez) AS SELECT
 artikeltyp_id,
 artikeltyp_bez
FROM kfl_production_dbp_view.v_artikeltyp_spr_zu_2
WHERE mandant_id = 1
 AND spr_id = 22;