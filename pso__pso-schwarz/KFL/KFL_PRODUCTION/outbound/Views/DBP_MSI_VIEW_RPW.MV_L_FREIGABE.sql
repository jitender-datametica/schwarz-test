CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_freigabe (freigabe, freigabe_bez) AS SELECT freigabe,
 freigabe_bez
FROM (SELECT 'update' AS freigabe,
    'Ändern ' AS freigabe_bez
   UNION ALL
   SELECT 'delete' AS freigabe,
    'Löschen' AS freigabe_bez);