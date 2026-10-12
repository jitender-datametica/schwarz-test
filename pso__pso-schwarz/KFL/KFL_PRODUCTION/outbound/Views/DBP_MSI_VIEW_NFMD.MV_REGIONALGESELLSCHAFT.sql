CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_regionalgesellschaft AS SELECT DISTINCT V01.vs_id,
 V01.mandant_id,
 V02.vs_bez
FROM kfl_production_dbp_view.v_wup AS V01
 INNER JOIN kfl_production_dbp_view.v_vs AS V02 ON V01.mandant_id = V02.mandant_id AND V01.vs_id = V02.vs_id AND V02.vk_id
     IN (0, 1) AND (V01.mandant_id <> 1 OR V01.vs_id <> 0);