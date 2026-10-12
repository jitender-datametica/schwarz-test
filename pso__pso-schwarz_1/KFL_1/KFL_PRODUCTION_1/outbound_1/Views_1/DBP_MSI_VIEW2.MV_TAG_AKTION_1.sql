CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_tag_aktion_1 (dat, wtag_id, kjwo, akt_wo) AS SELECT dat,
 wtag_id,
 kjwo,
 akt_wo
FROM kfl_production_dbp_view.v_tag_1;