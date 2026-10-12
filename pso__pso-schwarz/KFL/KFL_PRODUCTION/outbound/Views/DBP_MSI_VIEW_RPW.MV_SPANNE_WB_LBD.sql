-- 24.04.2024 prescherad; SPEC0211574, EK Preis mit Komponentenmenge multipilizieren

-- bei allen anderen Belastungsarten sollen die Daten mit empfaenger_id = NULL weiterhin ausgefiltert werden,deshalb ohne Coalesce

-- 17.08.2023 twie: SPEC0211574 Die beiden Joins auf art_gp_wup_zu_per und art_gp_nm_zu_per auf LEFT OUTER umstellen statt INNER, da sonst Daten für Bericht 6.04 rausfallen

-- 30.04.2024 prescherad; SPEC0211574, Sonderlogik für Pfand OWG 1092 einbauen

-- empfaenger_id in Tabelle kann NULL sein, deshalb Coalesce um sie nicht auszufiltern

-- 07.02.2019 msag:SPEC0047906 Ergänzung von Sachkonten ,316001 bis 312020

-- 15.03.2024 prescherad: SPEC0211574, menge_erf durch menge_lagerbew_bme aus Quelle v_lagerbew_det ersetzen

-- 17.01.2019 msag:NSR0486412 bei row_grund 158 und 159 Faktor ergänzt

-- 22.03.2023 twie: SPEC0064436 Da es in der art_gp_wup_zu_per mehre Lieferanten pro Zeitraum geben kann, den führenden Lieferant über die art_gp_nm_zu_per ermitteln

-- 19.10.2018 twie: SPEC0041626 Im 3. Select die Sachkonten pro MWSt ID auf eigenen Artikel aufgeteilt, dem die jeweilige mwst_id zugeordnet ist.

-- aber nur für Belastungsarten (lager_beart_id) 317 - 320
 -- 26.10.2018 twie: SPEC0041626 sap_mwst_id ist STRING

-- 09.03.2023 twie: SPEC0064436 ek_netto Sonderlogik geändert, wird jetzt für bestimmte Bewegungsarten aus art_gp_wup_zu_per geholt

-- Teil für Bewegungsarten ('317','318','319','320') für Bericht 6.12 Metrik EK Preis Netto

-- 06.10.2023 prescherad: SPEC0211574, aufteilen auf 2 getrennte Statements (jeweils für Bericht 6.4 und 6.12)

-- MCan: Folgender derived table wird per CROSS JOIN-Index optimiert. Bei Änderung sollten der CROSS JOIN-Index angepasst werden!

-- 29.06.2020 msag SPEC0079605 Ergänzung der MWST ID's '53' und '94" bei Leistungsdatum im Zeitraum 01.07.2020 - 31.12.2020

-- 23.02.2023 twie: SPEC0064436 Filter vom 21.12.2022 nochmal aufgeteilt, Coalesce nur bei lager_bewart_id 317-320, sonst vorherige Logik behalten

-- 04.12.2017 twie: SPEC0028737 row_grund_id 158 ergänzt

-- 21.12.2022 twie: SPEC0064436 Bei Filter auf empfaenger_id in der lagerbew_det ein Coalesce eingebaut, damit NULL Einträge nicht rausfallen

-- 15.12.2023 prescherad: SPEC0211574, Preisfindungslogik analog AIS implementieren

-- 05.11.2018 twie: SPEC0041626 Aktualisierung der MWSt ID

-- 27.02.2019 lwei: SPEC0067463 Buchungsdatum gegen Leistungsdatum ausgetauscht. Betrifft nur die ROWs daher letzter union.

-- 01.03.2023 twie: SPEC0064436 ek_netto Sonderlogik für Hybridbericht, dafür eigenes Feld ek_netto_hyb

-- Als dauerhafte Lösung ist zu überlegen in 2 Selects aufzuteilen mit getrennter Logik, für 6.12 mit Bewegungsarten 317-320 und für 6.04 mit den restlichen Bew.arten

-- Sonderlogik für Hybridbericht für diese Bewart

-- Dies hat wahrscheinlich zur Folge dass die Ermittlung für Bericht 6.12 nicht mehr korrekt funktioniert, wird aber in Kauf genommen da es ein produktives Problem mit 6.04 gibt

-- 05.11.2013 twie: als 3. Teil die besch_rech_det_kont dazu, um GOW (Gutschrift ohne Waren)- und ROW (Rechnung ohne Waren) -Buchungen mit auszugeben

-- 07.09.2018 msag SPEC0039852 row_grund_id 159 ergänzt
 -- 01.12.2017 twie: NSR0041699 row_grund_id ist char

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_spanne_wb_lbd (dat, beleg_wb_id, beleg_wb_pos_id, mandant_id,
system_id, abs_id, rcv_id, art_id, bew_art_wb_id, vk_brutto, ek_netto, ek_netto_hyb, mwst, mwst_id,
spanne_wb_herkunft_id, menge, belastungsart_id, belastungsart_vd_id) AS SELECT V01.dat,
 TRUNC(CAST(V01.bsch_id / 10000 AS BIGNUMERIC)) AS beleg_wb_id,
 CAST(V01.bsch_pos_id AS BIGNUMERIC) AS beleg_pos_id,
 V01.mandant_id,
 7 AS system_id,
 V01.gp_id AS abs_id,
 V01.wup_id AS rcv_id,
 V01.art_id,
 V01.lager_bewart_id AS bew_art_wb_id,
  CASE
  WHEN V01.menge_rech = 0
  THEN 0
  ELSE V01.vk_n * (100 + V03.mwst) / 100
  END AS vk_brutto,
 V01.ek_n AS ek_netto,
 V01.ek_n AS ek_netto_hyb,
 V03.mwst,
 V03.mwst_id,
 2 AS spanne_wb_herkunft_id,
 V01.menge_rech AS menge,
 V01.lager_bewart_id AS belastungsart_id,
 1 AS belastungsart_vd_id
FROM kfl_production_dbp_view.v_bsch_rech_det AS V01
 INNER JOIN kfl_production_dbp_view.v_art AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mwst_per AS V03 ON V02.mwst_id = V03.mwst_id AND V02.mandant_id = V03.mandant_id
  AND V01.dat BETWEEN V03.dat_von AND V03.dat_bis
WHERE V01.mandant_id = 1
UNION ALL
SELECT v01.dat_buch,
 v01.lagerbew_beleg_id,
 v01.lagerbew_beleg_pos_id,
 v01.mandant_id,
 7 AS system_id,
 COALESCE(v01.empfaenger_id, 0) AS abs_id,
 v01.wup_id AS rcv_id,
 v01.art_id,
 v01.lager_bewart_id AS bew_art_wb_id,
  CASE
  WHEN v01.betrag_verkauf = 0
  THEN v01.betrag_verkauf_ist
  ELSE v01.betrag_verkauf
  END AS vk_brutto,
  CASE
  WHEN V02.wg_art_fg = 1
  THEN v01.betrag_verkauf * 0.90
  ELSE v01.betrag_lagerbew
  END AS ek_netto,
  CASE
  WHEN v01.lager_bewart_id IN ('317', '318', '319', '320') AND v01.bezugsweg_id = 1 AND v01.owg_id <> 1092
  THEN v01.ek_netto_bnk_gp * v01.komponentenmenge_gp * v01.menge_lagerbew_bme
  WHEN v01.lager_bewart_id IN ('317', '318', '319', '320') AND v01.bezugsweg_id <> 1 AND v01.owg_id <> 1092
  THEN COALESCE(v01.ek_netto_bnk_vz, v01.ek_netto_bnk_gp) * COALESCE(v01.komponentenmenge_vz, v01.komponentenmenge_gp) *
   v01.menge_lagerbew_bme
  WHEN v01.lager_bewart_id IN ('317', '318', '319', '320') AND v01.owg_id = 1092
  THEN v01.betrag_verkauf -- sonst Standardlogik für ek_netto wie oben

  WHEN v01.lager_bewart_id NOT IN ('317', '318', '319', '320') AND V02.wg_art_fg = 1
  THEN v01.betrag_verkauf * 0.90
  ELSE v01.betrag_lagerbew
  END AS ek_netto_hyb,
 V03.mwst,
 V03.mwst_id,
 2 AS spanne_wb_herkunft_id,
 v01.menge_lagerbew_bme,
 v01.lager_bewart_id AS belastungsart_id,
 1 AS belastungsart_vd_id
FROM (SELECT V11.dat_buch,
    V11.mandant_id,
    V11.lagerbew_beleg_id,
    V11.lagerbew_beleg_pos_id,
    V11.wup_id,
    V11.empfaenger_id,
    V11.art_id,
    V11.lager_bewart_id,
    V11.betrag_verkauf,
    V11.betrag_verkauf_ist,
    V11.betrag_vk_netto,
    V11.betrag_lagerbew,
    V11.menge_lagerbew_bme,
    EK_MAPPING.bezugsweg_id,
    EK_VZ.ek_netto_bnk AS ek_netto_bnk_vz,
    EK_GP.ek_netto_bnk AS ek_netto_bnk_gp,
    EK_VZ.komponentenmenge AS komponentenmenge_vz,
    EK_GP.komponentenmenge AS komponentenmenge_gp,
    OWG.owg_id
   FROM kfl_production_dbp_view.v_lagerbew_det AS V11
    LEFT JOIN kfl_production_dbp_data.art_wg_zu_per AS WG ON V11.mandant_id = WG.mandant_id AND V11.art_id = WG.art_id
      AND V11.dat_buch BETWEEN WG.dat_von AND WG.dat_bis AND WG.arthiertyp_id = 2
    INNER JOIN kfl_production_dbp_data.wg_per AS OWG ON V11.mandant_id = OWG.mandant_id AND WG.wg_id = OWG.wg_id AND V11
      .dat_buch BETWEEN OWG.dat_von AND OWG.dat_bis
    INNER JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per AS EK_MAPPING ON V11.mandant_id = EK_MAPPING.mandant_id AND
        V11.art_id = EK_MAPPING.art_id AND V11.wup_id = EK_MAPPING.wup_id AND V11.dat_buch BETWEEN EK_MAPPING.dat_von
      AND EK_MAPPING.dat_bis
    LEFT JOIN kfl_production_dbp_view.v_art_gp_wup_zu_per AS EK_VZ ON EK_MAPPING.mandant_id = EK_VZ.mandant_id AND
          EK_MAPPING.art_id = EK_VZ.art_id AND EK_MAPPING.gp_id = EK_VZ.gp_id AND V11.dat_buch BETWEEN EK_VZ.dat_von AND
        EK_VZ.dat_bis -- ermittelt den auf VZ Ebene güliten EK Preis, Lieferung über Verteilzentrum
 AND EK_MAPPING.vz_wup_id
        = EK_VZ.wup_id AND EK_VZ.wup_id > - 1
    LEFT JOIN kfl_production_dbp_view.v_art_gp_wup_zu_per AS EK_GP ON EK_MAPPING.mandant_id = EK_GP.mandant_id AND
         EK_MAPPING.art_id = EK_GP.art_id AND EK_MAPPING.gp_id = EK_GP.gp_id AND V11.dat_buch BETWEEN EK_GP.dat_von AND
       EK_GP.dat_bis -- ermittelt den denzetralen EK_Preis, Direktlieferung von Lieferant an Filiale
 AND EK_GP.wup_id =
      - 1
   WHERE V11.lager_bewart_id IN ('317', '318', '319', '320')
    AND V11.mandant_id = 1 -- Teil für alle Bewegungsarten ungleich ('317','318','319','320') für Bericht 6.04

   UNION ALL
   SELECT dat_buch,
    mandant_id,
    lagerbew_beleg_id,
    lagerbew_beleg_pos_id,
    wup_id,
    empfaenger_id,
    art_id,
    lager_bewart_id,
    betrag_verkauf,
    betrag_verkauf_ist,
    betrag_vk_netto,
    betrag_lagerbew,
    menge_lagerbew_bme,
    ROUND(CAST('0' AS BIGNUMERIC), 0),
    ROUND(CAST('0' AS NUMERIC), 4),
    ROUND(CAST('0' AS NUMERIC), 4),
    ROUND(CAST('0' AS NUMERIC), 4),
    ROUND(CAST('0' AS NUMERIC), 4),
    ROUND(CAST('0' AS BIGNUMERIC), 0)
   FROM kfl_production_dbp_view.v_lagerbew_det AS V11
   WHERE lager_bewart_id IN ('101', '102', '161', '162', '301', '302', '303', '304', '901', '902', '905', '906', '907',
      '908', '912', '915', '916')
    AND mandant_id = 1) AS v01
 INNER JOIN kfl_production_dbp_view.v_art AS V02 ON v01.mandant_id = V02.mandant_id AND v01.art_id = V02.art_id
 INNER JOIN kfl_production_dbp_view.v_mwst_per AS V03 ON V02.mwst_id = V03.mwst_id AND V02.mandant_id = V03.mandant_id
  AND v01.dat_buch BETWEEN V03.dat_von AND V03.dat_bis
WHERE v01.wup_id <> 9201
 AND (CAST(v01.lager_bewart_id AS INTEGER) BETWEEN 317 AND 320 AND COALESCE(v01.empfaenger_id, 0) <> 9201 AND NOT
     COALESCE(v01.empfaenger_id, 0) BETWEEN 6900 AND 6914 OR CAST(v01.lager_bewart_id AS INTEGER) NOT BETWEEN 317 AND
      320 AND v01.empfaenger_id <> 9201 AND NOT v01.empfaenger_id BETWEEN 6900 AND 6914)
 AND NOT v01.wup_id BETWEEN 6900 AND 6914
UNION ALL
SELECT -- bzw. ROW-Gründe nur das Leistungserstellungsdatum.

 -- Aenderung nach Ruecksprache mit Barbara Koehler; jetzt fuer RBCO-Datensaetze
 -- br.dat_buch
 BR.dat_leist_erstellung
 ,
 BRDK.rech_beleg_id AS beleg_wb_id,
 BRDK.kontierungsblock_nr AS beleg_wb_pos_id,
 BRDK.mandant_id,
 7 AS system_id,
 BR.gp_id AS abs_id,
 BR.wup_id AS rcv_id,
   -- eigener Artikel pro mwst_id, dafür mwst_id abziehen
 BRDK.wg_id * - 1000 - V03.mwst_id AS art_id,
 'ROW' AS bew_art_wb_id,
  CASE
  WHEN CAST(BRDK.row_grund_id AS FLOAT64) = 158
  THEN BRDK.betrag_beleg * 1.23 * (1 + V03.mwst / 100)
  WHEN CAST(BRDK.row_grund_id AS FLOAT64) = 159
  THEN BRDK.betrag_beleg * 0.8 * (1 + V03.mwst / 100)
  ELSE BRDK.betrag_beleg
  END AS vk_brutto,
 BRDK.betrag_beleg AS ek_netto,
 BRDK.betrag_beleg AS ek_netto_hyb,
 V03.mwst,
 V03.mwst_id,
 2 AS spanne_wb_herkunft_id,
 BRDK.menge,
 'ROW' AS belastungsart_id,
 1 AS belastungsart_vd_id
FROM kfl_production_dbp_view.v_besch_rech_det_kont AS BRDK
 INNER JOIN kfl_production_dbp_view.v_besch_rech AS BR ON BRDK.mandant_id = BR.mandant_id AND BRDK.rech_beleg_id = BR.rech_beleg_id
     AND BRDK.gj -- zur SAP MWSt. ID der Fakttabelle die DWH MWSt. ID mappen und den MWSt. Satz ermitteln
 = BR.gj
 INNER JOIN kfl_production_dbp_view.v_mwst_per AS V03 ON CASE
     WHEN BRDK.sap_mwst_id IN ('76', '78', '95', '96')
     THEN 1
     WHEN BRDK.sap_mwst_id IN ('53', '55', '94', '97')
     THEN 2
     WHEN BRDK.sap_mwst_id IN ('71', '74')
     THEN 3
     WHEN BRDK.sap_mwst_id IN ('99')
     THEN 9
     ELSE 1
     END = V03.mwst_id AND BRDK.mandant_id = V03.mandant_id AND BR.dat_buch BETWEEN V03.dat_von AND V03.dat_bis
WHERE BRDK.mandant_id = 1
 AND RIGHT(BRDK.sachkonto_id, 6) IN ('314602', '314603', '314604', '314605', '314606', '314607', '314608', '314609',
   '314610', '314611', '314612', '314616', '314617', '314621', '314622', '314623', '314624', '316001', '316002',
   '316003', '316004', '316005', '316006', '316007', '316008', '316009', '316010', '316011', '316012', '316013',
   '316014', '312006', '312007', '312008', '312009', '312010', '312011', '312012', '312013', '312014', '312015',
   '312016', '312017', '312018', '312019', '312020')
 AND BRDK.row_grund_id IN ('100', '101', '103', '104', '105', '106', '107', '108', '109', '110', '111', '112', '114',
   '116', '119', '120', '142', '158', '159', '160', '161', '199');