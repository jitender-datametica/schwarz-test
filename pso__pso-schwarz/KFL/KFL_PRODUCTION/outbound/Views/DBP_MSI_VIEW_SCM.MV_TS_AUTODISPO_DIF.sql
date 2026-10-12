CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_ts_autodispo_dif (mandant_id_kunde, wup_id_kunde, nb_id_kunde
, mandant_id_vz, wup_id_vz, nb_id_vz, frische_manager_id, art_id, vs_id, vkl_id, wg_id, art_gruppe_id, dat_von, dat_bis
, sa_af_fg, art_cluster_id, wup_cluster_id, werbegruppe_fleisch, dif_funktion_id, dif_typ_id, menge_einh_id,
dif_status_id, dif_wert, dif_kommentar, dif_timestamp, delete_fg, dateiname, decoded_dateiname) AS SELECT V01.mandant_id_kunde
 ,
 COALESCE(V05.aktuell_wup_id, V01.wup_id_kunde) AS wup_id_kunde,
 V01.nb_id_kunde,
 V01.mandant_id_vz,
 V01.wup_id_vz,
 V01.nb_id_vz,
 V01.frische_manager_id,
 V01.art_id,
 V01.vs_id,
 V01.vkl_id,
 V01.wg_id,
 V01.art_gruppe_id,
 V01.dat_von,
 V01.dat_bis,
 V01.sa_af_fg,
 V01.art_cluster_id,
 V01.wup_cluster_id,
 V01.werbegruppe_fleisch,
 V01.dif_funktion_id,
 V01.dif_typ_id,
 V01.menge_einh_id,
 V01.dif_status_id,
 V01.dif_wert,
 V01.dif_kommentar,
 V01.dif_timestamp,
 0 AS delete_fg,
 V01.dateiname,
 REPLACE(V01.dateiname, '%20', ' ') AS decoded_dateiname
FROM kfl_production_dbp_view.v_ts_autodispo_dif AS V01
 LEFT JOIN kfl_production_dbp_view.v_wup AS V05 ON V01.mandant_id_kunde = V05.mandant_id AND V01.wup_id_kunde = V05.wup_id
     AND (V05.nb_id IN (2, 0, - 111) AND V05.wup_id > 0 OR V05.nb_id = - 1 AND V05.wup_id = 0);