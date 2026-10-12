CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_kostenart_2 AS SELECT LTRIM(COLLATE(kostenart_id, ''), '0') AS
 kostenart_id,
 krk_id,
 kontenplan_id,
 kostenart_altnv_id,
 kostenart_grp_id
FROM kfl_production_dbp_view.v_kostenart_2
WHERE mandant_id = 1
 AND krk_id = 'XX01';