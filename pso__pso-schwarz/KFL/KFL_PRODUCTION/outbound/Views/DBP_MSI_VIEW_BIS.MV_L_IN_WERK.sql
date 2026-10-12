CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_l_in_werk (werk_id, mandant_id, werk_nr, werk_name, sako_fg,
buchungskreis_id) AS SELECT werk_id,
 mandant_id,
 werk_nr,
 werk_name,
 sako_fg,
 buchungskreis_id
FROM kfl_production_dbp_view.v_in_werk
WHERE sako_fg = 1;