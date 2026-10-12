CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_beleg_typ_spr_zu_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT 7 AS system_id,
 mandant_id,
 spr_id AS spr_zu,
 beleg_typ_id,
 beleg_typ_bez
FROM kfl_production_dbp_view.v_beleg_typ_spr_zu_2
WHERE mandant_id = 1;