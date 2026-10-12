CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wup_umlagerung_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH'), wup_id
OPTIONS(description='ID des Warenumschlagsplatz der abgebenden bzw. empfangenden Filiale.'), dat
OPTIONS(description='Datum der Verarbeitung der Umlagerung_1 bei der abgebenden bzw. empfangenden Filiale. Kann bei verzögerter Verarbeitung in wenigen Fällen vom Kalenderjahr des Beleges abweichen.'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'), wa_wup_id
OPTIONS(description='ID des Warenumschlagsplatz der abgebenden Filiale'), we_wup_id
OPTIONS(description='ID des Warenumschlagsplatz der empfangenden Filiale'), dat_buchung_wa
OPTIONS(description='Datum der Verarbeitung der Umlagerung_1 bei der abgebenden Filiale. Kann bei verzögerter Verarbeitung in wenigen Fällen vom Kalenderjahr des Beleges abweichen.'),
dat_buchung_we
OPTIONS(description='Datum der Verarbeitung der Umlagerung_1 bei der empfangenden Filiale. Kann bei verzögerter Verarbeitung in wenigen Fällen vom Kalenderjahr des Beleges abweichen.'),
umlagerung_status_kz
OPTIONS(description='Kennzeichen für den Status_1 der Umlagerung_1: W = Wareneingang gebucht, S = Storniert, O = Offen.'),
anz_beleg_pos_wa OPTIONS(description='Anzahl der Buchungspositionen im Materialbeleg'), anz_beleg_pos_we
OPTIONS(description='Anzahl der Buchungspositionen im Materialbeleg'), vk_brutto_wa
OPTIONS(description='Verkaufswert der Positionen der Umlagerung_1'), vk_brutto_we
OPTIONS(description='Verkaufswert der Positionen der Umlagerung_1'), uml_stat_storniert_fg
OPTIONS(description='Kennzeichen für stornierte Umlagerungen'), uml_stat_offen_fg
OPTIONS(description='Kennzeichen für offene, nicht bestätigte Umlagerungen'), uml_wert_gering_fg
OPTIONS(description='Kennzeichen für Umlagerungen mit einem geringfügigen Nettowert < 100 EUR')) AS WITH UML AS (SELECT
   mandant_id,
   wa_lagerbew_beleg_id,
   wa_lagerbew_beleg_kj,
   wrg_id,
   wa_wup_id,
   we_wup_id,
   dat_buchung_wa,
   dat_buchung_we,
   umlagerung_status_kz,
   anz_beleg_pos,
   vk_brutto
  FROM kfl_production_dbp_view.v_umlagerung_1), WUP_1 AS (SELECT mandant_id,
   wup_id,
   aktuell_wup_id
  FROM kfl_production_dbp_view.v_wup_1), FACT_AGGREGATION AS (SELECT VIS.mandant_id,
   wup.aktuell_wup_id AS wup_id,
   VIS.dat,
   K.nach_wrg_id AS wrg_id,
   wa_wup.aktuell_wup_id AS wa_wup_id,
   we_wup.aktuell_wup_id AS we_wup_id,
   COALESCE(wa.dat_buchung_wa, we.dat_buchung_wa) AS dat_buchung_wa,
   COALESCE(wa.dat_buchung_we, we.dat_buchung_we) AS dat_buchung_we,
   COALESCE(wa.umlagerung_status_kz, we.umlagerung_status_kz) AS umlagerung_status_kz,
   SUM(wa.anz_beleg_pos * -1) AS anz_beleg_pos_wa,
   SUM(we.anz_beleg_pos) AS anz_beleg_pos_we,
   SUM(wa.vk_brutto * -1 * K.umrechnungskurs) AS vk_brutto_wa,
   SUM(we.vk_brutto * K.umrechnungskurs) AS vk_brutto_we
  FROM kfl_production_dbp_msi_view_vis.mv_vis_tag_fakt_wup_1 AS VIS
   LEFT JOIN UML AS wa ON VIS.mandant_id = wa.mandant_id AND VIS.wup_id = wa.wa_wup_id AND VIS.dat = wa.dat_buchung_wa
    AND VIS.wrg_id = wa.wrg_id
   LEFT JOIN UML AS we ON VIS.mandant_id = we.mandant_id AND VIS.wup_id = we.we_wup_id AND VIS.dat = we.dat_buchung_we
    AND VIS.wrg_id = we.wrg_id
   INNER JOIN kfl_production_dbp_data.tag_1 AS ZEIT_1 ON VIS.dat = ZEIT.dat
   INNER JOIN WUP_1 AS wup_1 ON VIS.mandant_id = wup.mandant_id AND VIS.wup_id = wup.wup_id
   INNER JOIN WUP_1 AS wa_wup ON VIS.mandant_id = wa_wup.mandant_id AND COALESCE(wa.wa_wup_id, we.wa_wup_id) = wa_wup.wup_id
     
   INNER JOIN WUP_1 AS we_wup ON VIS.mandant_id = we_wup.mandant_id AND COALESCE(wa.we_wup_id, we.we_wup_id) = we_wup.wup_id
     
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_kurs_umrechnung_1 AS K ON VIS.wrg_id = K.von_wrg_id
  GROUP BY VIS.mandant_id,
   wup_id,
   VIS.dat,
   wrg_id,
   wa_wup_id,
   we_wup_id,
   dat_buchung_wa,
   dat_buchung_we,
   umlagerung_status_kz) (SELECT t7.mandant_id,
   t7.wup_id,
   t7.dat,
   t7.wrg_id,
   t7.wa_wup_id,
   t7.we_wup_id,
   t7.dat_buchung_wa,
   t7.dat_buchung_we,
   t7.umlagerung_status_kz,
   IFNULL(t7.anz_beleg_pos_wa, 0) AS anz_beleg_pos_wa,
   IFNULL(t7.anz_beleg_pos_we, 0) AS anz_beleg_pos_we,
   IFNULL(t7.vk_brutto_wa, 0) AS vk_brutto_wa,
   IFNULL(t7.vk_brutto_we, 0) AS vk_brutto_we,
   IF(t7.umlagerung_status_kz = 'S', 1, 0) AS uml_stat_storniert_fg,
   IF(t7.umlagerung_status_kz = 'O', 1, 0) AS uml_stat_offen_fg,
   IF(t7.wrg_id = 'EUR' AND ABS(t7.vk_brutto_wa) < 100 OR t7.wrg_id <> 'EUR' AND ABS(t7.vk_brutto_wa) * K0.umrechnungskurs
         < 100, 1, 0) AS uml_wert_gering_fg
  FROM FACT_AGGREGATION AS t7
   LEFT JOIN kfl_production_dbp_msi_view_vis.mv_kurs_umrechnung_1 AS K0 ON t7.wrg_id = K0.von_wrg_id AND K0.nach_wrg_id =
     'EUR'
  WHERE (t7.anz_beleg_pos_wa <> 0 OR t7.vk_brutto_wa <> 0 OR t7.anz_beleg_pos_we <> 0 OR t7.vk_brutto_we <> 0)
   AND t7.wup_id = t7.wa_wup_id);