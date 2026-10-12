CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kmr_l_unter_kategorie AS SELECT kmr_unter_kategorie_id,
 kmr_kategorie_id,
 kmr_teilbereich_uk_id,
 kmr_count_fg,
 uk_sw
FROM kfl_production_dbp_data.kmr_l_unter_kategorie;