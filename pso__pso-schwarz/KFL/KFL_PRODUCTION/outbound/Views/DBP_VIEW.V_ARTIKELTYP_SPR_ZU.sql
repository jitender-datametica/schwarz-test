CREATE OR REPLACE VIEW kfl_production_dbp_view.v_artikeltyp_spr_zu AS SELECT mandant_id,
 artikeltyp_id,
 spr_id,
 artikeltyp_bez
FROM kfl_production_dbp_data.artikeltyp_spr_zu;