CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_flw_ek_notierung (mandant_id, ek_notierung_id, dat,
plan_fg, pjwo, default_wrg, wrg_id, betrag) AS SELECT V01.mandant_id,
 V01.flw_art_id AS ek_notierung_id,
 V01.dat,
 V01.plan_fg,
 V01.pjwo,
 V100.default_wrg,
 V01.wrg_id,
 V01.betrag
FROM kfl_production_dbp_view.v_flw_ek_notierung AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant AS V100 ON V01.mandant_id = V100.mandant_id;