CREATE OR REPLACE VIEW dbp_msi_view_rpw_dt.mv_l_freigabe_2 (freigabe, freigabe_bez) AS SELECT 'update' AS freigabe,
 'Ändern ' AS freigabe_bez
UNION ALL
SELECT 'delete' AS freigabe,
 'Löschen' AS freigabe_bez;