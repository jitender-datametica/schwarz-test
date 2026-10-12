CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_mhd_erfassung_wup_art_2 (mandant_id, wup_id, dat_erfassung,
dat_mhd, art_id, art_anz, basismenge_einh_id, mhd_erfassung_pruef_fg, listung_fg, dat_erstellung, dat_aenderung) AS
SELECT EWA.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 EWA.dat_erfassung,
 EWA.dat_mhd,
 EWA.art_id,
 EWA.art_anz,
 EWA.basismenge_einh_id,
 EWA.mhd_erfassung_pruef_fg,
 EWA.listung_fg,
 EWA.dat_erstellung,
 EWA.dat_aenderung
FROM kfl_production_dbp_view.v_mhd_erfassung_wup_art_2 AS EWA
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON EWA.mandant_id = WUP.mandant_id AND EWA.wup_id = WUP.wup_id;