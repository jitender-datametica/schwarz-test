-- 2022-08-03, AP0125093, SPEC0164838, dknop, max for ANZ_WUP_DIS, ANZ_WUP_KDIS

/* * Name = für den Fall dass noch andere Kennzahlen oder Attribute aus den Dispo 2020-Tabellen auf Ebene 
* Verteilzentrum/Artikel_2/Tag_2 [=PK] dazukommen sollten) */
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_art_wup_dispo_tag_2 (mandant_id, art_id, wup_id,
nb_id, dat, anz_wup_dis, anz_wup_kdis) AS SELECT V1.mandant_id,
 V1.art_id,
 V2.wup_id,
 V2.nb_id,
 V1.dat_plan AS dat,
 MAX(V1.anz_wup_dis) AS anz_wup_dis,
 MAX(V1.anz_wup_kdis) AS anz_wup_kdis
FROM kfl_production_dbp_view.v_art_gp_dispo_tag_2 AS V1
 INNER JOIN kfl_production_dbp_view.v_gp_dispo_vz_tag_2 AS V2 ON V1.mandant_id = V2.mandant_id AND V1.gp_dispo_id = V2.gp_dispo_id
     AND V1.dat_plan = V2.dat_plan
GROUP BY V1.mandant_id,
 V1.art_id,
 V2.wup_id,
 V2.nb_id,
 dat;