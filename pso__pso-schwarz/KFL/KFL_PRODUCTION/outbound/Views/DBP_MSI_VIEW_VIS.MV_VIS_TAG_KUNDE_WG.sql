CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_tag_kunde_wg (mandant_id, nb_id, wup_id, wg_id, dat,
anz_kunde_wg, anz_kunde_wg_wvj, anz_kunde_wg_kvj, anz_kunde_sug_wg, anz_kunde_sug_wg_wvj, anz_kunde_sug_wg_kvj) AS
SELECT SUB0.mandant_id,
 SUB0.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 SUB0.wg_id,
 SUB0.dat,
 SUM(SUB0.ist) AS anz_kunde_wg,
 SUM(SUB0.wvj) AS anz_kunde_wg_wvj,
 SUM(SUB0.kvj) AS anz_kunde_wg_kvj,
 SUM(SUB0.sug_ist) AS anz_kunde_sug_wg,
 SUM(SUB0.sug_wvj) AS anz_kunde_sug_wg_wvj,
 SUM(SUB0.sug_kvj) AS anz_kunde_sug_wg_kvj
FROM (SELECT mandant_id,
    nb_id,
    wup_id,
    wg_id,
    dat,
    bonanzahl AS ist,
    0 AS wvj,
    0 AS kvj,
    bonanzahl_sug AS sug_ist,
    0 AS sug_wvj,
    0 AS sug_kvj
   FROM kfl_production_dbp_view.v_wup_dat_wg_sum AS WG1
   UNION ALL
   SELECT mandant_id,
    nb_id,
    wup_id,
    wg_id,
    DATE_ADD(dat, INTERVAL 364 DAY) AS dat,
    0 AS ist,
    bonanzahl AS wvj,
    0 AS kvj,
    0 AS sug_ist,
    bonanzahl_sug AS sug_wvj,
    0 AS sug_kvj
   FROM kfl_production_dbp_view.v_wup_dat_wg_sum AS WG2
   UNION ALL
   SELECT mandant_id,
    nb_id,
    wup_id,
    wg_id,
    IF(dat = LAST_DAY(dat), LAST_DAY(DATE_ADD(dat, INTERVAL 12 MONTH)), DATE_ADD(dat, INTERVAL 12 MONTH)) AS dat,
    0 AS ist,
    0 AS wvj,
    bonanzahl AS kvj,
    0 AS sug_ist,
    0 AS sug_wvj,
    bonanzahl_sug AS sug_kvj
   FROM kfl_production_dbp_view.v_wup_dat_wg_sum AS WG3) AS SUB0
 INNER JOIN kfl_production_dbp_view.v_wup AS WUP ON SUB0.mandant_id = WUP.mandant_id AND SUB0.wup_id = WUP.wup_id
GROUP BY SUB0.mandant_id,
 SUB0.nb_id,
 wup_id,
 SUB0.dat,
 SUB0.wg_id;