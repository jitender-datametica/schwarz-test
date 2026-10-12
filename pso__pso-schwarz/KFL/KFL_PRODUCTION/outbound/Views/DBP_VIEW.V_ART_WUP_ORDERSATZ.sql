CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_wup_ordersatz AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 dat_von,
 dat_bis,
 bezugsvorschrift_kz,
 bezugsquelle_kz,
 status_f_aenderungen_fg,
 kdis_zzsopomvke_fg,
 kdis_auslistungsprozess_fg,
 archivierungs_kz
FROM kfl_production_dbp_data.art_wup_ordersatz;