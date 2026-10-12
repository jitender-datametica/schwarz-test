CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_werk_1 AS SELECT mandant_id,
 werk_id,
 werk_nr,
 werk_name,
 system_id,
 sako_fg,
 buchungskreis_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_werk_1;