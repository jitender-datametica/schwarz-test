CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.tbl_mv_lager_bewgrund_spr_zu_1 AS SELECT grund_id,
 spr_id,
 lager_bewart_id,
 mandant_id,
 hist_fg,
 grund_bez
FROM kfl_production_dbp_view.v_lager_bewgrund_spr_zu_1 AS V01
WHERE hist_fg = 0;