CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_aktion_wme_ame_status_spr_zu_1 AS SELECT a1 AS
 aktion_wme_ame_status_fg,
 a2 AS aktion_wme_ame_status_bez
FROM (SELECT 0 AS a1,
    'Mengeneinholung' AS a2
   FROM UNNEST(GENERATE_ARRAY(0, 0)) AS SEQ
   UNION ALL
   SELECT 1,
    'Bekanntmachung'
   FROM UNNEST(GENERATE_ARRAY(0, 0)) AS SEQ) AS sub00;