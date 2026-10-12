-- 17.11.2020, AP0070828, NWAG2310, B01/BF1 INTO COLUMNS TO AVOID DUPLICATION / REMOVE LAGERPLATZ+TYP

-- 24.04.2025, INC, NWAG2310, Filter out irrelevant systems

-- 27.10.2020, AP0070828, NWAG2310, INTIAL FROM MV_WUP_LAGERNUMMER_BSFLAECHE_PER+MV_WUP_LAGEREINHEIT_PER

-- 16.11.2020, AP0070828, NWAG2310, IMPROVED CROSS JOIN CRITERIA T02

-- 12.11.2020, AP0070828, SROM0404, ADDED STUNDE_MINUTEN
 -- 12.11.2020, AP0070828, NWAG2310, ADDED DAT

-- 11.11.2020, AP0070828, NWAG2310, UMSTELLUNG AUF PERSISTENTE TAG-STUNDE-TABELLE (PERFORMANCE)

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_wup_lagernummer_bsf AS SELECT T01.mandant_id,
 T01.lagernummer_id,
 T01.wup_id,
 T01.nb_id,
 T01.bsflaeche_id,
 T01.doppelbelegung_fg,
 T02.dat_zeit,
 T02.dat,
 T02.stunde_minuten,
 T01.warenempfaenger_id,
 T01.warenempfaenger_orig,
 T01.status_verplant_fg,
 T01.status_fixe_einplanung_fg,
 T01.referenznummer,
 T01.maximale_kapazitaet,
 T01.verplante_kapazitaet,
 T01.bestand_bsf,
 T01.bestandsart,
 T01.anz_paletten_bsf,
 T01.we_kapazitaet,
 T01.tor_id_zugeordnet,
 T01.status_verplant_ign_fg,
 T01.anz_sammelpaletten_bsf,
 T01.anz_bigbox_bsf,
 T01.belegte_stp_bsf,
 T01.bsf_status_id,
 T01.bsf_zone_id,
 T01.bsf_sperrgrund_id,
 T01.erhoehte_kapazitaet,
 T01.kapa_check_ign_fg,
 T01.tor_blocken_ign_fg,
 T01.bsf_sperrgrund_manuell,
 COALESCE(T03.bsf_virtuell_fg, 0) AS bsf_virtuell_id,
 COALESCE(LEIN_B01.anz_lagereinheit_b01, 0) AS anz_lagereinheit_b01,
 COALESCE(LEIN_BF1.anz_lagereinheit_bf1, 0) AS anz_lagereinheit_bf1,
 COALESCE(LEIN_B01.anz_spuren_b01, 0) AS anz_spuren_b01,
 COALESCE(LEIN_BF1.anz_spuren_bf1, 0) AS anz_spuren_bf1
FROM kfl_production_dbp_view.v_wup_lagernummer_bsflaeche_per AS T01
 INNER JOIN kfl_production_dbp_view.v_tag_stunde AS T02 ON T01.datzeit_von <= T02.dat_zeit AND T01.datzeit_bis /* B01 */
   > T02.dat_zeit
 LEFT JOIN (SELECT T010.mandant_id,
   T020.dat_zeit,
   T010.lagernummer_id,
   T010.wup_id,
   T010.nb_id,
   T010.spurnummer,
   T010.lagerplatz_id,
   COUNT(DISTINCT CASE
     WHEN T010.lagertyp_id = 'B01'
     THEN T010.lagereinheit_id
     ELSE NULL
     END) AS anz_lagereinheit_b01,
   COUNT(DISTINCT CASE
     WHEN T010.lagertyp_id = 'B01'
     THEN T010.spurnummer
     ELSE NULL
     END) AS anz_spuren_b01
  FROM kfl_production_dbp_view.v_wup_lagereinheit_per AS T010
   INNER JOIN kfl_production_dbp_view.v_tag_stunde AS T020 ON T010.datzeit_von <= T020.dat_zeit AND T010.datzeit_bis >
     T020.dat_zeit
  GROUP BY T010.mandant_id,
   T020.dat_zeit,
   T010.lagernummer_id,
   T010.wup_id,
   T010.nb_id,
   T010.spurnummer,
   T010.lagerplatz_id) AS LEIN_B01 ON T02.dat_zeit = LEIN_B01.dat_zeit AND T01.mandant_id = LEIN_B01.mandant_id AND T01
      .wup_id = LEIN_B01.wup_id AND T01.lagernummer_id = LEIN_B01.lagernummer_id AND T01.bsflaeche_id
    -- FÜR B01 MUSS LAGERPLATZ IN LEIN UND ZLVBSFLAECHE IDENTISCH SEIN!
 = LEIN_B01.spurnummer AND T01.lagerplatz_id
   /* BF1 */ = LEIN_B01.lagerplatz_id
 LEFT JOIN (SELECT T011.mandant_id,
   T021.dat_zeit,
   T011.lagernummer_id,
   T011.wup_id,
   T011.nb_id,
   T011.spurnummer,
   COUNT(DISTINCT CASE
     WHEN T011.lagertyp_id = 'BF1'
     THEN T011.lagereinheit_id
     ELSE NULL
     END) AS anz_lagereinheit_bf1,
   COUNT(DISTINCT CASE
     WHEN T011.lagertyp_id = 'BF1'
     THEN T011.spurnummer
     ELSE NULL
     END) AS anz_spuren_bf1
  FROM kfl_production_dbp_view.v_wup_lagereinheit_per AS T011
   INNER JOIN kfl_production_dbp_view.v_tag_stunde AS T021 ON T011.datzeit_von <= T021.dat_zeit AND T011.datzeit_bis >
     T021.dat_zeit
  GROUP BY T011.mandant_id,
   T021.dat_zeit,
   T011.lagernummer_id,
   T011.wup_id,
   T011.nb_id,
   T011.spurnummer) AS LEIN_BF1 ON T02.dat_zeit = LEIN_BF1.dat_zeit AND T01.mandant_id = LEIN_BF1.mandant_id AND T01.wup_id
      = LEIN_BF1.wup_id AND T01.lagernummer_id = LEIN_BF1.lagernummer_id AND T01.bsflaeche_id = LEIN_BF1.spurnummer
 LEFT JOIN kfl_production_dbp_view.v_wup_lagernummer_bsflaeche_virtuell_per AS T03 ON T01.mandant_id = T03.mandant_id
     AND T01.wup_id = T03.wup_id AND T01.lagernummer_id = T03.lagernummer_id AND T01.bsflaeche_id = T03.bsflaeche_id AND
   T02.dat BETWEEN T03.dat_von AND T03.dat_bis
WHERE T02.dat <= CURRENT_DATE
 AND EXISTS (SELECT 1
  FROM kfl_production_dbp_data.l_vz_sap_system_zu AS SVZ
   INNER JOIN kfl_production_dbp_data.l_system AS S ON SVZ.mandant_id = S.mandant_id AND SVZ.system_id = S.system_id
  WHERE S.system_gruppe = 'SAP LVS'
   AND SVZ.mandant_id = T01.mandant_id
   AND SVZ.wup_id = T01.wup_id
   AND SVZ.system_id = T01.system_id);