CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_in_werk_2 (mandant_id, werk_id, werk_nr, werk_name, system_id,
sako_fg, buchungskreis_id) AS SELECT mandant_id,
 werk_id,
 werk_nr,
 werk_name,
 system_id,
 sako_fg,
 buchungskreis_id
FROM kfl_production_dbp_view.v_in_werk_2;