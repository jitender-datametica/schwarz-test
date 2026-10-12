CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_wewa_grp_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT V.wewa_gruppe_id,
 V.vorgangsart_id,
 V.open_fg,
 V.gemeldet_fg,
 V.teilgebucht_fg,
 S.wewa_gruppe_bez AS wewa_grp_bez
FROM kfl_production_dbp_view.v_vorgangsart_wewa_gruppe_zu_1 AS V
 INNER JOIN kfl_production_dbp_view.v_wewa_gruppe_spr_zu_1 AS S ON V.mandant_id = S.mandant_id AND V.wewa_gruppe_id = S.wewa_gruppe_id
     AND S.spr_id = 22
WHERE V.mandant_id = 1;