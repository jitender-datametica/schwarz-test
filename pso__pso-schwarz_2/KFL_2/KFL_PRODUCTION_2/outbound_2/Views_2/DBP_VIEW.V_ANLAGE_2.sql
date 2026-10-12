CREATE OR REPLACE VIEW kfl_production_dbp_view.v_anlage_2 AS SELECT anlage_id,
 anlage_sub_id,
 mandant_id,
 buchungskreis_id,
 dat_erstellung,
 in_lief_id,
 eigentum_fg,
 anlage_id_alt,
 anlage_sub_id_alt,
 dat_erstellung_alt,
 anlage_bez
FROM kfl_production_dbp_data.anlage_2;