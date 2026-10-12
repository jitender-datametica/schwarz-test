CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_buch_grund_ext_grp_spr_zu_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT 7 AS system_id,
 mandant_id,
 spr_id,
 buch_grund_ext_gruppe_id,
 buch_grund_ext_gruppe_bez
FROM kfl_production_dbp_view.v_buch_grund_ext_gruppe_spr_zu_1
WHERE spr_id = 22
 AND mandant_id = 1;