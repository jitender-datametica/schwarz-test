CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_art_wup_pruefung_2 (mandant_id, pruef_prozess_typ_kz, wup_id,
nb_id, art_id, dat, dat_erstellung, pruef_id, z_arbeitsgebiet_id, pruef_status_id, dat_pruefung) AS SELECT V01.mandant_id
 ,
 V01.pruef_prozess_typ_kz,
 WUP.aktuell_wup_id AS wup_id,
 V01.nb_id,
 V01.art_id,
 V01.dat_erstellung AS dat,
 V01.dat_erstellung,
 V01.pruef_id,
 V01.z_arbeitsgebiet_id,
 V01.pruef_status_id,
 V01.dat_pruefung
FROM kfl_production_dbp_data.art_wup_pruefung_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id;