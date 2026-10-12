CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_werk_2 AS SELECT mandant_id,
 werk_id,
 werk_nr,
 werk_name,
 system_id,
 flw_fg,
 buchungskreis_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_werk_2;