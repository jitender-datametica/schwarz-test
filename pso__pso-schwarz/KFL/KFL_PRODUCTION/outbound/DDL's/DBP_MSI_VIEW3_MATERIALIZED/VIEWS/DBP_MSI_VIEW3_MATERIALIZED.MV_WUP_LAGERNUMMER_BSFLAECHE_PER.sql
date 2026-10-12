CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_wup_lagernummer_bsflaeche_per (mandant_id,
lagernummer_id, wup_id, nb_id, bsflaeche_id, doppelbelegung_fg, dat_zeit, warenempfaenger_id, warenempfaenger_orig,
status_verplant_fg, status_fixe_einplanung_fg, referenznummer, maximale_kapazitaet, verplante_kapazitaet, bestand_bsf,
bestandsart, anz_paletten_bsf, we_kapazitaet, tor_id_zugeordnet, status_verplant_ign_fg, anz_sammelpaletten_bsf,
anz_bigbox_bsf, belegte_stp_bsf, bsf_status_id, bsf_zone_id, bsf_sperrgrund_id, erhoehte_kapazitaet, kapa_check_ign_fg,
tor_blocken_ign_fg, bsf_sperrgrund_manuell, lagerplatz_id, bsf_virtuell_id) AS SELECT T01.mandant_id,
 T01.lagernummer_id,
 T01.wup_id,
 T01.nb_id,
 T01.bsflaeche_id,
 T01.doppelbelegung_fg,
 T02.dat_zeit,
 T01.warenempfaenger_id,
 T01.warenempfaenger_orig,
 T01.status_verplant_fg,
 T01.status_fixe_einplanung_fg,
 CAST(T01.referenznummer AS STRING) AS referenznummer,
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
 T01.lagerplatz_id,
 COALESCE(T03.bsf_virtuell_fg, 0) AS bsf_virtuell_id
FROM kfl_production_dbp_view.v_wup_lagernummer_bsflaeche_per AS T01
 INNER JOIN kfl_production_dbp_view.v_tag_stunde AS T02 ON T01.datzeit_von <= T02.dat_zeit AND T01.datzeit_bis > T02.dat_zeit
   
 LEFT JOIN kfl_production_dbp_view.v_wup_lagernummer_bsflaeche_virtuell_per AS T03 ON T01.mandant_id = T03.mandant_id
     AND T01.wup_id = T03.wup_id AND T01.lagernummer_id = T03.lagernummer_id AND T01.bsflaeche_id = T03.bsflaeche_id AND
   DATE(T02.dat_zeit) BETWEEN T03.dat_von AND T03.dat_bis
WHERE CAST(T02.dat_zeit AS DATE) <= CURRENT_DATE
 AND EXISTS (SELECT 1
  FROM kfl_production_dbp_data.l_vz_sap_system_zu AS SVZ
   INNER JOIN kfl_production_dbp_data.l_system AS S ON SVZ.mandant_id = S.mandant_id AND SVZ.system_id = S.system_id
  WHERE S.system_gruppe = 'SAP LVS'
   AND SVZ.mandant_id = T01.mandant_id
   AND SVZ.wup_id = T01.wup_id
   AND SVZ.system_id = T01.system_id);