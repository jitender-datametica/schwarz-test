CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_kostenart_spr_zu_1 AS SELECT LTRIM(COLLATE(kostenart_id, ''),
  '0') AS kostenart_id,
 krk_id,
 kostenart_bez
FROM kfl_production_dbp_view.v_kostenart_spr_zu_1
WHERE mandant_id = 1
 AND krk_id = 'XX01'
 AND spr_id = 22;