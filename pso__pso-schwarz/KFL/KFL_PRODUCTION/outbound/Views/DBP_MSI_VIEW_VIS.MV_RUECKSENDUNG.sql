CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ruecksendung (mandant_id, ruecksendung_beleg_id, wup_id,
wa_nb_id, dat, anz_palette, gefahrstoff_fg, ruecksendung_typ_kz, ruecksendung_status_id, dat_aenderung, dat_erstellung,
bezugsweg_id) AS SELECT RS.mandant_id,
 RS.ruecksendung_beleg_id,
 WUP.aktuell_wup_id AS wup_id,
 RS.wa_nb_id,
 RS.dat_lief AS dat,
 RS.anz_palette,
 RS.gefahrstoff_fg,
 RS.ruecksendung_typ_kz,
 RS.ruecksendung_status_id,
 RS.dat_aenderung,
 RS.dat_erstellung,
 RS.bezugsweg_id
FROM kfl_production_dbp_view.v_ruecksendung AS RS
 INNER JOIN kfl_production_dbp_view.v_wup AS WUP ON RS.mandant_id = WUP.mandant_id AND RS.wa_wup_id = WUP.wup_id;