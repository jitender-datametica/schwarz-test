CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_lager_bewgrund (grund_id, lager_bewart_id, mandant_id, hist_fg
, retourenart_id, lager_bewart_typ_id) AS SELECT V01.grund_id,
 V01.lager_bewart_id,
 V01.mandant_id,
 V01.hist_fg,
 V01.retourenart_id,
 V02.lager_bewart_typ_id
FROM kfl_production_dbp_view.v_l_lager_bewgrund AS V01
 INNER JOIN kfl_production_dbp_view.v_lager_bewart_typ_zu AS V02 ON V01.mandant_id = V02.mandant_id AND V01.grund_id =
    V02.grund_id AND V01.lager_bewart_id = V02.lager_bewart_id
WHERE V01.hist_fg = 0
 AND V02.hist_fg = 0;