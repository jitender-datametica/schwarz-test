-- 21.06.2017 hmue: Flag anlegen -> (1 für Benutzer = ZBATCHANBRNS, Else 0). siehe user_flag und sap_user

-- 2022-11-18, AP0149040_SPEC0173503, dknop, updates to pick_type_id logic
 -- 04.05.2015 twie: neues Feld einl_ebene

-- 21.06.2017 hmue: neues Feld 'sap_user'
 -- 2022-10-18, AP0149040_SPEC0173503, dknop, adding pick_type_id logic

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_transportauftrag_det_2 (art_id, lagernummer_id,
lagerort_id, mandant_id, nach_lagertyp_id, nach_lagerplatz_id, nb_id, transport_beleg_id, transport_beleg_pos_id,
global_von_lagertyp_id, von_lagertyp_id, von_lagerplatz_id, wup_id, dat_erstellung, dat_quittierung, zeit_quittierung,
quittierung_dt, menge_transportauftrag_kolli, dat_entnahme_quittierung, zeit_entnahme_quittierung,
entnahme_quittierung_dt, lager_einheit_id_von, lager_einheit_id_nach, menge_ist_nach, menge_soll_von, status_quittierung
, lager_einheiten_typ, transport_vorgang_id, dat_verfall, bruttogew_kg, nachschubzeit_sekunden, platz_leer_fg,
menge_soll_nach_altnv, min_nachschub_kdr, distanz, menge_ist, einl_ebene, sap_user, user_flag, handling_unit_id_ext,
pick_type_id) AS
/* alter Zweig **
     CASE WHEN quittierung_fg = 1 AND menge_soll_von = menge_ist_nach
     THEN 'voll quittiert'
     WHEN quittierung_fg = 1 AND menge_soll_von > menge_ist_nach
     THEN 'teil quittiert'
     WHEN quittierung_fg = 1 AND transport_vorgang_id IN ('st', 'sl')
     THEN 'storniert'
     WHEN quittierung_fg = 0
     THEN 'offen'
     ELSE 'sonstiges'
     END   AS status_quittierung
     * */
-- Änderung lt. Mail vom 18.07.2013
 SELECT LTAP.art_id,
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
  CASE
  WHEN LTAP.transport_vorgang_id = 'LF' AND LTAP.platz_leer_fg = 0
  THEN 1 -- pick all

  WHEN LTAP.transport_vorgang_id = 'LF' AND LTAP.platz_leer_fg = 1 AND ltap_agg_fg0.anz_pos = 1
  THEN 2 -- skip+pick all

  WHEN LTAP.transport_vorgang_id = 'SP' AND LTAP.platz_leer_fg = 1 AND ltap_agg_fg0.anz_pos > 1
  THEN 3 -- skip+pick part

  WHEN LTAP.transport_vorgang_id = 'LF' AND LTAP.platz_leer_fg = 1 AND ltap_agg_fg0.anz_pos > 1
  THEN 4 -- pick rest

  WHEN LTAP.transport_vorgang_id = 'ST' AND LTAP.platz_leer_fg = 1 AND ltap_agg_fg0.anz_pos >= 1 AND ltap_agg_fg0.dist_vor
     = 1
  THEN 5 -- skip + storno

  WHEN LTAP.transport_vorgang_id = 'ST' AND LTAP.platz_leer_fg = 1 AND ltap_agg_st_sp.anz_pos > 1 AND ltap_agg_st_sp.dist_vor
     > 1
  THEN 6 -- storno after pick part

  WHEN LTAP.transport_vorgang_id = 'ST' AND LTAP.platz_leer_fg = 0
  THEN 7 -- storno general AS pick_type_id

  WHEN LTAP.transport_vorgang_id IN ('SP') AND LTAP.platz_leer_fg = 0 AND ltap_agg_lf_sp.anz_pos > 1
  THEN 8 -- pick part (without skip confirmation)

  WHEN LTAP.transport_vorgang_id IN ('SP') AND LTAP.platz_leer_fg = 0 AND ltap_agg_st_sp.anz_pos > 1
  THEN 9 -- pick part (without skip confirmation) + storno

  WHEN LTAP.transport_vorgang_id = ''
  THEN 10 -- kein Transportvorgang

  ELSE 0
  END AS pick_type_id
FROM kfl_production_dbp_view.v_transportauftrag_det_2 AS LTAP
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   transport_beleg_id,
   art_id,
   COUNT(*) AS anz_pos,
   COUNT(DISTINCT transport_vorgang_id) AS dist_vor
  FROM kfl_production_dbp_view.v_transportauftrag_det_2
  WHERE transport_vorgang_id IN ('SP', 'LF', 'ST')
   AND (transport_vorgang_id NOT IN ('LF', 'ST') OR platz_leer_fg <> 0)
  GROUP BY mandant_id,
   transport_beleg_id,
   wup_id,
   art_id) AS ltap_agg_fg0 ON LTAP.mandant_id = ltap_agg_fg0.mandant_id AND LTAP.transport_beleg_id = ltap_agg_fg0.transport_beleg_id
      AND LTAP.art_id = ltap_agg_fg0.art_id AND LTAP.wup_id = ltap_agg_fg0.wup_id
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   transport_beleg_id,
   art_id,
   COUNT(*) AS anz_pos
  FROM kfl_production_dbp_view.v_transportauftrag_det_2
  WHERE transport_vorgang_id IN ('LF', 'SP')
  GROUP BY mandant_id,
   transport_beleg_id,
   wup_id,
   art_id) AS ltap_agg_lf_sp ON LTAP.mandant_id = ltap_agg_lf_sp.mandant_id AND LTAP.transport_beleg_id = ltap_agg_lf_sp
     .transport_beleg_id AND LTAP.art_id = ltap_agg_lf_sp.art_id AND LTAP.wup_id = ltap_agg_lf_sp.wup_id
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   transport_beleg_id,
   art_id,
   COUNT(*) AS anz_pos,
   COUNT(DISTINCT transport_vorgang_id) AS dist_vor
  FROM kfl_production_dbp_view.v_transportauftrag_det_2
  WHERE transport_vorgang_id IN ('ST', 'SP')
  GROUP BY mandant_id,
   transport_beleg_id,
   wup_id,
   art_id) AS ltap_agg_st_sp ON LTAP.mandant_id = ltap_agg_st_sp.mandant_id AND LTAP.transport_beleg_id = ltap_agg_st_sp
     .transport_beleg_id AND LTAP.art_id = ltap_agg_st_sp.art_id AND LTAP.wup_id = ltap_agg_st_sp.wup_id
WHERE EXTRACT(YEAR FROM LTAP.dat_erstellung) >= EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2
   -- and ltap.transport_beleg_id=137189988  and ltap.art_id=94372200;