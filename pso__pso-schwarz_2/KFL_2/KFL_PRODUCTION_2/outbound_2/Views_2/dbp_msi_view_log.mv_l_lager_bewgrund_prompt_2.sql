CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_lager_bewgrund_prompt_2 (grund_id, lager_bewart_id, hist_fg,
retourenart_id) AS SELECT grund_id,
 lager_bewart_id,
 MAX(hist_fg) AS hist_fg,
 MAX(retourenart_id) AS retourenart_id
FROM kfl_production_dbp_view.v_l_lager_bewgrund_2 AS V01
WHERE hist_fg = 0
GROUP BY grund_id,
 lager_bewart_id;