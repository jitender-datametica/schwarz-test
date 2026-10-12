CREATE OR REPLACE VIEW kfl_production_dbp_view.v_brand_abschnitt_spr_zu_1 AS SELECT brand_abschnitt_id,
 mandant_id,
 lagernummer_id,
 spr_id,
 brand_abschnitt_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.brand_abschnitt_spr_zu_1;