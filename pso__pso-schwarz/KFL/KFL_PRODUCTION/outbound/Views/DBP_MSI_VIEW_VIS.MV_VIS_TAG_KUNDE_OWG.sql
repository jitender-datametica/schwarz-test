CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_tag_kunde_owg (mandant_id, nb_id, wup_id, owg_id, dat,
anz_kunde_owg, anz_kunde_owg_wvj, anz_kunde_owg_kvj, anz_kunde_sug_owg, anz_kunde_sug_owg_wvj, anz_kunde_sug_owg_kvj) AS
SELECT SUB0.mandant_id,
 SUB0.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 SUB0.owg_id,
 SUB0.dat,
 SUM(SUB0.ist) AS anz_kunde_owg,
 SUM(SUB0.wvj) AS anz_kunde_owg_wvj,
 SUM(SUB0.kvj) AS anz_kunde_owg_kvj,
 SUM(SUB0.sug_ist) AS anz_kunde_sug_owg,
 SUM(SUB0.sug_wvj) AS anz_kunde_sug_owg_wvj,
 SUM(SUB0.sug_kvj) AS anz_kunde_sug_owg_kvj
FROM (SELECT mandant_id,
    nb_id,
    wup_id,
    owg_id,
    dat,
    bonanzahl AS ist,
    0 AS wvj,
    0 AS kvj,
    bonanzahl_sug AS sug_ist,
    0 AS sug_wvj,
    0 AS sug_kvj
   FROM kfl_production_dbp_view.v_wup_dat_owg_sum AS OWG1
   UNION ALL
   SELECT mandant_id,
    nb_id,
    wup_id,
    owg_id,
    DATE_ADD(dat, INTERVAL 364 DAY) AS dat,
    0 AS ist,
    bonanzahl AS wvj,
    0 AS kvj,
    0 AS sug_ist,
    bonanzahl_sug AS sug_wvj,
    0 AS sug_kvj
   FROM kfl_production_dbp_view.v_wup_dat_owg_sum AS OWG2
   UNION ALL
   SELECT mandant_id,
    nb_id,
    wup_id,
    owg_id,
    IF(dat = LAST_DAY(dat), LAST_DAY(DATE_ADD(dat, INTERVAL 12 MONTH)), DATE_ADD(dat, INTERVAL 12 MONTH)) AS dat,
    0 AS ist,
    0 AS wvj,
    bonanzahl AS kvj,
    0 AS sug_ist,
    0 AS sug_wvj,
    bonanzahl_sug AS sug_kvj
   FROM kfl_production_dbp_view.v_wup_dat_owg_sum AS OWG3) AS SUB0
 INNER JOIN kfl_production_dbp_view.v_wup AS WUP ON SUB0.mandant_id = WUP.mandant_id AND SUB0.wup_id = WUP.wup_id
GROUP BY SUB0.mandant_id,
 SUB0.nb_id,
 wup_id,
 SUB0.dat,
 SUB0.owg_id;