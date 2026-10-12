CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_f_umsatz_tag_wup_2 AS SELECT V01.mandant_id,
 V01.nb_id,
 V01.wup_id,
 V01.wrg_id,
 V01.dat,
 V01.ums_netto_plan
FROM kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup_2 AS V01
 INNER JOIN kfl_production_dbp_msi_view_wwc.mv_mandant_2 AS V02 ON V01.mandant_id = V02.mandant_id
WHERE V01.wrg_id = V02.wrg_id;