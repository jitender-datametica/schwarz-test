-- 2022-12-15, AP0150311, SPEC0174516, dknop, initial, copy of MV_TRANSPORTAUFTRAG_DET but with clusters

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_transportauftrag_det_clusters (art_id,
lagernummer_id, lagerort_id, mandant_id, nach_lagertyp_id, nach_lagerplatz_id, nb_id, transport_beleg_id,
transport_beleg_pos_id, global_von_lagertyp_id, von_lagertyp_id, von_lagerplatz_id, wup_id, dat_erstellung,
dat_quittierung, zeit_quittierung, quittierung_dt, menge_transportauftrag_kolli, dat_entnahme_quittierung,
zeit_entnahme_quittierung, entnahme_quittierung_dt, lager_einheit_id_von, lager_einheit_id_nach, menge_ist_nach,
menge_soll_von, status_quittierung, lager_einheiten_typ, transport_vorgang_id, dat_verfall, bruttogew_kg,
nachschubzeit_sekunden, platz_leer_fg, menge_soll_nach_altnv, min_nachschub_kdr, distanz, menge_ist, einl_ebene,
sap_user, user_flag, handling_unit_id_ext, cluster_element_id, cluster_id) AS SELECT LTAP.art_id,
 LTAP.lagernummer_id,
 LTAP.lagerort_id,
 LTAP.mandant_id,
 LTAP.nach_lagertyp_id,
 LTAP.nach_lagerplatz_id,
 LTAP.nb_id,
 LTAP.transport_beleg_id,
 LTAP.transport_beleg_pos_id,
  CASE
  WHEN SUBSTR(LTAP.von_lagertyp_id, 1, 2) = 'R0'
  THEN 'Regal Erdgeschoss'
  WHEN SUBSTR(LTAP.von_lagertyp_id, 1, 2) = 'R1'
  THEN 'Regal Obergeschoss'
  WHEN LTAP.von_lagertyp_id = 'H01'
  THEN 'Hochregal'
  WHEN LTAP.von_lagertyp_id IN ('RH1', 'RT1')
  THEN 'AKL-Hochregal'
  ELSE 'Sonstige'
  END AS global_von_lagertyp_id,
 LTAP.von_lagertyp_id,
 LTAP.von_lagerplatz_id,
 LTAP.wup_id,
 LTAP.dat_erstellung,
 LTAP.dat_quittierung,
 LTAP.zeit_quittierung,
 DATETIME(LTAP.dat_quittierung, COALESCE(LTAP.zeit_quittierung, TIME '00:00:00')) AS quittierung_dt,
 LTAP.menge_transportauftrag_kolli,
 LTAP.dat_entnahme_quittierung,
 LTAP.zeit_entnahme_quittierung,
 DATETIME(LTAP.dat_entnahme_quittierung, COALESCE(LTAP.zeit_entnahme_quittierung, TIME '00:00:00')) AS
 entnahme_quittierung_dt,
 LTAP.lager_einheit_id_von,
 LTAP.lager_einheit_id_nach,
 LTAP.menge_ist_nach,
 LTAP.menge_soll_von,
 CAST(CASE
   WHEN LTAP.quittierung_fg = 1 AND (LTAP.menge_soll_von = LTAP.menge_ist_nach OR LTAP.menge_soll_von = 0 AND LTAP.menge_ist_nach > 0) AND COALESCE(LTAP.transport_vorgang_id, '') NOT IN ('st', 'sl')
   THEN 'voll quittiert'
   WHEN LTAP.quittierung_fg = 1 AND LTAP.menge_soll_von > LTAP.menge_ist_nach AND COALESCE(LTAP.transport_vorgang_id, '') NOT IN ('st', 'sl')
   THEN 'teil quittiert'
   WHEN LTAP.quittierung_fg = 1 AND LTAP.transport_vorgang_id IN ('st', 'sl')
   THEN 'storniert'
   WHEN LTAP.quittierung_fg = 0
   THEN 'offen'
   ELSE 'sonstiges'
   END AS STRING) AS status_quittierung,
 -- Anf 584954
 LTAP.lager_einheiten_typ,
 LTAP.transport_vorgang_id,
 LTAP.dat_verfall,
 LTAP.bruttogew_kg,
 LTAP.nachschubzeit_sekunden,
 LTAP.platz_leer_fg,
 LTAP.menge_soll_nach_altnv,
 LTAP.min_nachschub_kdr,
 LTAP.distanz,
  CASE
  WHEN LTAP.menge_soll_von <> 0
  THEN LTAP.menge_soll_von
  ELSE LTAP.menge_ist_nach
  END AS menge_ist,
 LTAP.einl_ebene,
 LTAP.sap_user,
  CASE
  WHEN LTAP.sap_user = 'ZBATCHANBRNS'
  THEN 1
  ELSE 0
  END AS user_flag,
 LTAP.handling_unit_id_ext,
 CLUSTERS.cluster_element_id,
 CLUSTERS.cluster_id
FROM kfl_production_dbp_view.v_transportauftrag_det AS LTAP
 LEFT JOIN kfl_production_dbp_msi_data.ts_scm_cluster AS CLUSTERS ON LTAP.nachschubzeit_sekunden BETWEEN CLUSTERS.wert_von
   AND CLUSTERS.wert_bis AND CLUSTERS.cluster_typ_bez = 'Dauer'
WHERE EXTRACT(YEAR FROM LTAP.dat_erstellung) >= EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2
   -- and ltap.transport_beleg_id=137189988  and ltap.art_id=94372200;