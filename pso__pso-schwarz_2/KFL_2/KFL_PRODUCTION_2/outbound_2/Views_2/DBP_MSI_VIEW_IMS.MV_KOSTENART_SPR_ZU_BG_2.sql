CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_kostenart_spr_zu_bg_2 AS SELECT COLLATE(LTRIM(COLLATE(DE.kostenart_id
    , ''), '0'), 'und:ci') AS kostenart_id,
 DE.krk_id,
 COALESCE(ls.kostenart_bez, DE.kostenart_bez) AS kostenart_bez
FROM kfl_production_dbp_view.v_kostenart_spr_zu_2 AS DE
 LEFT JOIN (SELECT *
  FROM kfl_production_dbp_view.v_kostenart_spr_zu_2
  WHERE spr_id = 18
   AND krk_id = 'XX01'
   AND mandant_id = 1) AS ls ON DE.kostenart_id = ls.kostenart_id
WHERE DE.spr_id = 22
 AND DE.krk_id = 'XX01'
 AND DE.mandant_id = 1;