CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_tag_kunde_abt (mandant_id, nb_id, wup_id, abt_id, dat,
anz_kunde_abt, anz_kunde_abt_wvj, anz_kunde_abt_kvj, anz_kunde_sug_abt, anz_kunde_sug_abt_wvj, anz_kunde_sug_abt_kvj) AS
SELECT sub0.mandant_id,
 sub0.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 sub0.abt_id,
 sub0.dat,
 SUM(sub0.ist) AS anz_kunde_abt,
 SUM(sub0.wvj) AS anz_kunde_abt_wvj,
 SUM(sub0.kvj) AS anz_kunde_abt_kvj,
 SUM(sub0.sug_ist) AS anz_kunde_sug_abt,
 SUM(sub0.sug_wvj) AS anz_kunde_sug_abt_wvj,
 SUM(sub0.sug_kvj) AS anz_kunde_sug_abt_kvj
FROM (SELECT mandant_id,
    nb_id,
    wup_id,
    abt_id,
    dat,
    bonanzahl AS ist,
    0 AS wvj,
    0 AS kvj,
    bonanzahl_sug AS sug_ist,
    0 AS sug_wvj,
    0 AS sug_kvj
   FROM kfl_production_dbp_view.v_wup_dat_abt_sum AS ABT1
   UNION ALL
   SELECT mandant_id,
    nb_id,
    wup_id,
    abt_id,
    DATE_ADD(dat, INTERVAL 364 DAY) AS dat,
    0 AS ist,
    bonanzahl AS wvj,
    0 AS kvj,
    0 AS sug_ist,
    bonanzahl_sug AS sug_wvj,
    0 AS sug_kvj
   FROM kfl_production_dbp_view.v_wup_dat_abt_sum AS ABT2
   UNION ALL
   SELECT mandant_id,
    nb_id,
    wup_id,
    abt_id,
    IF(dat = LAST_DAY(dat), LAST_DAY(DATE_ADD(dat, INTERVAL 12 MONTH)), DATE_ADD(dat, INTERVAL 12 MONTH)) AS dat,
    0 AS ist,
    0 AS wvj,
    bonanzahl AS kvj,
    0 AS sug_ist,
    0 AS sug_wvj,
    bonanzahl_sug AS sug_kvj
   FROM kfl_production_dbp_view.v_wup_dat_abt_sum AS ABT3) AS sub0
 INNER JOIN kfl_production_dbp_view.v_wup AS WUP ON sub0.mandant_id = WUP.mandant_id AND sub0.wup_id = WUP.wup_id
GROUP BY sub0.mandant_id,
 sub0.nb_id,
 wup_id,
 sub0.dat,
 sub0.abt_id;