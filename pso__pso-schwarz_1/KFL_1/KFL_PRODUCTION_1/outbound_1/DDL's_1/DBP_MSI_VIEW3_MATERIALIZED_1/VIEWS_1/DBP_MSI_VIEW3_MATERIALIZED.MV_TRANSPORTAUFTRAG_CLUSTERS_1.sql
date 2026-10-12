-- 2023-01-05, AP0150311, SPEC0174516, dknop, initial, copy of MV_TRANSPORTAUFTRAG_1 but with clusters
 -- 

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_transportauftrag_clusters_1 (dat_erstellung,
zeit_erstellung, erstellung_dt, dat_quittierung, dat_lief_soll, dat_bereitstellung, datzeit_bereitstellung,
datzeit_start_ta, datzeit_end_ta, lagernummer_id, mandant_id, transport_beleg_id, transportart_id, lvs_bewart_id,
lief_beleg_id, ta_prio, dat_prio_upd, zeit_prio_upd, nb_id, wup_id, kj_lief_beleg, werbeware_id, lief_pal_typ_id,
referenznummer, cluster_element_id, cluster_id) AS SELECT v_transportauftrag.dat_erstellung,
 v_transportauftrag.zeit_erstellung,
 DATETIME(v_transportauftrag.dat_erstellung, COALESCE(v_transportauftrag.zeit_erstellung, TIME '00:00:00')) AS
 erstellung_dt,
 v_transportauftrag.dat_quittierung,
 v_transportauftrag.dat_lief_soll,
 v_transportauftrag.dat_bereitstellung,
 v_transportauftrag.datzeit_bereitstellung,
 v_transportauftrag.datzeit_start_ta,
 v_transportauftrag.datzeit_end_ta,
 v_transportauftrag.lagernummer_id,
 v_transportauftrag.mandant_id,
 v_transportauftrag.transport_beleg_id,
 v_transportauftrag.transportart_id,
 v_transportauftrag.lvs_bewart_id,
 v_transportauftrag.lief_beleg_id,
 v_transportauftrag.ta_prio,
 v_transportauftrag.dat_prio_upd,
 v_transportauftrag.zeit_prio_upd,
 v_transportauftrag.nb_id,
 v_transportauftrag.wup_id,
 v_transportauftrag.kj_lief_beleg,
 v_transportauftrag.werbeware_id,
 v_transportauftrag.lief_pal_typ_id,
 v_transportauftrag.referenznummer,
  CASE
  WHEN CLUSTERS.cluster_element_id = 4 AND CLUSTERS.cluster_id = 4
  THEN 3
  ELSE CLUSTERS.cluster_element_id
  END AS cluster_element_id,
 CLUSTERS.cluster_id
FROM kfl_production_dbp_view.v_transportauftrag_1
 LEFT JOIN kfl_production_dbp_msi_data.ts_scm_cluster_1 AS CLUSTERS ON v_transportauftrag.zeit_erstellung BETWEEN CLUSTERS
   .zeit_von AND CLUSTERS.zeit_bis AND CLUSTERS.cluster_typ_bez = 'Uhrzeit'
WHERE EXTRACT(YEAR FROM v_transportauftrag.dat_erstellung) >= EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2
   -- and (zeit_erstellung between '00:00:00' and '05:59:59')
 -- and transport_beleg_id=64053630 and cluster_id=4;