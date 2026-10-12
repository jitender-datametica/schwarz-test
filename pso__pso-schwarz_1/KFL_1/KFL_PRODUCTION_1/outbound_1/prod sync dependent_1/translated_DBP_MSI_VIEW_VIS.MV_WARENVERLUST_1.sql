CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_warenverlust_1 (mandant_id OPTIONS(description='Mandant_1 im DWH'),
wup_id
OPTIONS(description='Der\""WUP_1\"" beinhaltet Märkte und Lager. WUP_1 = WarenUmschlagsPlatz. Mutter WUP_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
art_id
OPTIONS(description='Artikelnummer im DWH. Input: Artikel_1-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.'),
wg_hist_id OPTIONS(description='ID der Warengruppe'), owg_hist_id OPTIONS(description='ID der Oberwarengruppe'),
hwg_hist_id OPTIONS(description='ID der Hauptwarengruppe'), abt_hist_id
OPTIONS(description='Abteilungs-ID, negative Werte: im DWH generierte IDs; positive Werte: aus Stammdatensystem übernommen.'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'), inventurart_id
OPTIONS(description='Inventurarten aus SAP. Unterscheidung, ob bsp. Jahres-, Frische- oder Sonderinventur. Siehe Inventurart_spr_zu.'),
dat_inventur_von
OPTIONS(description='Start des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land_1 unterscheiden.'),
dat_inventur_bis
OPTIONS(description='Ende des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land_1 unterscheiden.'),
gj
OPTIONS(description='Geschäftsjahr, dem Inventurzeitraum zugeordnet werden soll. 28.02.2024 kann beispielsweise in der Betrachtung zum Inventurzeitraum des GJ 2024 statt 2023 gehören.'),
inventur_id OPTIONS(description='Eindeutige hochgezählte Nummer über alle Felder des Excel-Uploads'), wv_umsatz_netto
OPTIONS(description='Umsatz der betroffenen Inventur_1-Artikel_1 im definierten Inventur_1-Zeitraum je Betrieb'),
wv_preisabschrift_netto
OPTIONS(description='Wert der Preisabschriften für die betroffenen Inventur_1-Artikel_1 im definierten Inventur_1-Zeitraum je Betrieb'),
wv_totalabschrift_netto
OPTIONS(description='Wert der Totalabschriften für die betroffenen Inventur_1-Artikel_1 im definierten Inventur_1-Zeitraum je Betrieb'),
wv_inventur_netto
OPTIONS(description='Saldierte Inventur_1-Differenz-Werte je Artikel_1 und Betrieb im definierten Inventur_1-Zeitraum'),
wv_menge_inventur
OPTIONS(description='Saldierte Inventur_1-Differenz-Mengen je Artikel_1 und Betrieb im definierten Inventur_1-Zeitraum'),
wv_inventur_diebstahl_netto OPTIONS(description='Betrag Diebstahl als Teilmenge der Inventur_1-Differenz-Werten'),
wv_umsatz_netto_aufg
OPTIONS(description='Aufgelaufener Umsatz der betroffenen Inventur_1-Artikel_1 im definierten Inventur_1-Zeitraum je Betrieb'),
wv_preisabschrift_netto_aufg
OPTIONS(description='Aufgelaufener Wert der Preisabschriften für die betroffenen Inventur_1-Artikel_1 im definierten Inventur_1-Zeitraum je Betrieb'),
wv_totalabschrift_netto_aufg
OPTIONS(description='Aufgelaufener Wert der Totalabschriften für die betroffenen Inventur_1-Artikel_1 im definierten Inventur_1-Zeitraum je Betrieb'),
wv_inventur_netto_aufg
OPTIONS(description='Aufgelaufene Saldierte Inventur_1-Differenz-Werte je Artikel_1 und Betrieb im definierten Inventur_1-Zeitraum'),
wv_menge_inventur_aufg
OPTIONS(description='Aufgelaufene Saldierte Inventur_1-Differenz-Mengen je Artikel_1 und Betrieb im definierten Inventur_1-Zeitraum'),
wv_inventur_diebstahl_netto_aufg
OPTIONS(description='Aufgelaufener Betrag Diebstahl als Teilmenge der Inventur_1-Differenz-Werten')) AS WITH
 INVENTUR_WARENVERLUST_1 AS (SELECT mandant_id,
   inventur_id,
   wup_id,
   nb_id,
   inventurart_id,
   dat_inventur_von,
   dat_inventur_bis,
   dat_inventur_buchung_von,
   dat_inventur_buchung_bis,
   gj,
   art_id,
   wg_id,
   owg_id,
   hwg_id,
   abt_id,
   loesch_fg,
   IF((ROW_NUMBER() OVER (PARTITION BY mandant_id, wup_id, abt_id, hwg_id, owg_id, wg_id, art_id, gj, inventurart_id
       ORDER BY dat_inventur_bis NULLS LAST)) = 1, 1, 0) AS first_row_fg,
   DATE_ADD(LAG(dat_inventur_bis) OVER (PARTITION BY mandant_id, wup_id, abt_id, hwg_id, owg_id, wg_id, art_id, gj,
       inventurart_id ORDER BY dat_inventur_bis NULLS LAST), INTERVAL 1 DAY) AS dat_inventur_von_calc,
   IF(IF((ROW_NUMBER() OVER (PARTITION BY mandant_id, wup_id, abt_id, hwg_id, owg_id, wg_id, art_id, gj, inventurart_id
          ORDER BY dat_inventur_bis NULLS LAST)) = 1, 1, 0) = 0 AND dat_inventur_von <> DATE_ADD((LAG(dat_inventur_bis)
        OVER (PARTITION BY mandant_id, wup_id, abt_id, hwg_id, owg_id, wg_id, art_id, gj, inventurart_id ORDER BY
           dat_inventur_bis NULLS LAST)), INTERVAL 1 DAY), DATE_ADD(LAG(dat_inventur_bis) OVER (PARTITION BY mandant_id
        , wup_id, abt_id, hwg_id, owg_id, wg_id, art_id, gj, inventurart_id ORDER BY dat_inventur_bis NULLS LAST),
     INTERVAL 1 DAY), dat_inventur_von) AS dat_inventur_von_corr
  FROM kfl_production_dbp_view.v_inventur_warenverlust_1), KUMULATION AS (SELECT w.mandant_id,
   WUP.aktuell_wup_id AS wup_id,
   WD.art_id,
   WG.wg_id AS wg_hist_id,
   OWG.owg_id AS owg_hist_id,
   HWG.hwg_id AS hwg_hist_id,
   HWG.abt_id AS abt_hist_id,
   K.nach_wrg_id AS wrg_id,
   w.inventurart_id,
   w.dat_inventur_von_corr AS dat_inventur_von,
   w.dat_inventur_bis,
   w.gj,
   w.inventur_id,
    WD.betrag_vk_netto * K.umrechnungskurs AS wv_umsatz_netto,
    WD.betrag_vk_netto_preisabschrift * K.umrechnungskurs AS wv_preisabschrift_netto,
    WD.betrag_vk_netto_totalabschrift * K.umrechnungskurs AS wv_totalabschrift_netto,
    WD.betrag_vk_netto_inventur_diff * K.umrechnungskurs AS wv_inventur_netto,
   WD.menge_inventur_diff AS wv_menge_inventur,
    WD.betrag_vk_netto_inventur_diff_diebstahl * K.umrechnungskurs AS wv_inventur_diebstahl_netto,
   SUM(IFNULL(WD.betrag_vk_netto * K.umrechnungskurs, 0)) OVER (PARTITION BY w.mandant_id, WUP.aktuell_wup_id, K.nach_wrg_id
      , HWG.abt_id, HWG.hwg_id, OWG.owg_id, WG.wg_id, WD.art_id, w.gj, w.inventurart_id ORDER BY w.dat_inventur_bis
      NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS wv_umsatz_netto_aufg,
   SUM(IFNULL(WD.betrag_vk_netto_preisabschrift * K.umrechnungskurs, 0)) OVER (PARTITION BY w.mandant_id, WUP.aktuell_wup_id
      , K.nach_wrg_id, HWG.abt_id, HWG.hwg_id, OWG.owg_id, WG.wg_id, WD.art_id, w.gj, w.inventurart_id ORDER BY w.dat_inventur_bis
      NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS wv_preisabschrift_netto_aufg,
   SUM(IFNULL(WD.betrag_vk_netto_totalabschrift * K.umrechnungskurs, 0)) OVER (PARTITION BY w.mandant_id, WUP.aktuell_wup_id
      , K.nach_wrg_id, HWG.abt_id, HWG.hwg_id, OWG.owg_id, WG.wg_id, WD.art_id, w.gj, w.inventurart_id ORDER BY w.dat_inventur_bis
      NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS wv_totalabschrift_netto_aufg,
   SUM(IFNULL(WD.betrag_vk_netto_inventur_diff * K.umrechnungskurs, 0)) OVER (PARTITION BY w.mandant_id, WUP.aktuell_wup_id
      , K.nach_wrg_id, HWG.abt_id, HWG.hwg_id, OWG.owg_id, WG.wg_id, WD.art_id, w.gj, w.inventurart_id ORDER BY w.dat_inventur_bis
      NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS wv_inventur_netto_aufg,
   SUM(IFNULL(WD.menge_inventur_diff, 0)) OVER (PARTITION BY w.mandant_id, WUP.aktuell_wup_id, K.nach_wrg_id, HWG.abt_id
      , HWG.hwg_id, OWG.owg_id, WG.wg_id, WD.art_id, w.gj, w.inventurart_id ORDER BY w.dat_inventur_bis NULLS LAST
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS wv_menge_inventur_aufg,
   SUM(IFNULL(WD.betrag_vk_netto_inventur_diff_diebstahl * K.umrechnungskurs, 0)) OVER (PARTITION BY w.mandant_id, WUP.aktuell_wup_id
      , K.nach_wrg_id, HWG.abt_id, HWG.hwg_id, OWG.owg_id, WG.wg_id, WD.art_id, w.gj, w.inventurart_id ORDER BY w.dat_inventur_bis
      NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS wv_inventur_diebstahl_netto_aufg
  FROM INVENTUR_WARENVERLUST_1 AS w
   INNER JOIN kfl_production_dbp_view.v_inventur_warenverlust_det_1 AS WD ON w.mandant_id = WD.mandant_id AND w.inventur_id
      = WD.inventur_id
   INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON w.mandant_id = WUP.mandant_id AND w.wup_id = WUP.wup_id
   INNER JOIN kfl_production_dbp_view.v_art_1 AS A ON w.mandant_id = A.mandant_id AND WD.art_id = A.art_id
   INNER JOIN kfl_production_dbp_data.art_wg_zu_per_1 AS WGART ON w.mandant_id = WGART.mandant_id AND WD.art_id = WGART.art_id
        AND w.dat_inventur_bis BETWEEN WGART.dat_von AND WGART.dat_bis AND WGART.arthiertyp_id = 2
   INNER JOIN kfl_production_dbp_data.wg_per_1 AS WG ON WGART.mandant_id = WG.mandant_id AND WGART.wg_id = WG.wg_id AND w
      .dat_inventur_bis BETWEEN WG.dat_von AND WG.dat_bis AND WG.arthiertyp_id = 2
   INNER JOIN kfl_production_dbp_data.owg_per_1 AS OWG ON WGART.mandant_id = OWG.mandant_id AND WG.owg_id = OWG.owg_id AND
      w.dat_inventur_bis BETWEEN OWG.dat_von AND OWG.dat_bis AND OWG.arthiertyp_id = 2
   INNER JOIN kfl_production_dbp_data.hwg_per_1 AS HWG ON WGART.mandant_id = HWG.mandant_id AND OWG.hwg_id = HWG.hwg_id
     AND w.dat_inventur_bis BETWEEN HWG.dat_von AND HWG.dat_bis AND HWG.arthiertyp_id = 2
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_kurs_umrechnung_1 AS K ON WD.wrg_id = K.von_wrg_id
  WHERE w.loesch_fg = 0) (SELECT mandant_id,
   wup_id,
   art_id,
   wg_hist_id,
   owg_hist_id,
   hwg_hist_id,
   abt_hist_id,
   wrg_id,
   inventurart_id,
   dat_inventur_von,
   dat_inventur_bis,
   gj,
   inventur_id,
   wv_umsatz_netto,
   wv_preisabschrift_netto,
   wv_totalabschrift_netto,
   wv_inventur_netto,
   wv_menge_inventur,
   wv_inventur_diebstahl_netto,
   wv_umsatz_netto_aufg,
   wv_preisabschrift_netto_aufg,
   wv_totalabschrift_netto_aufg,
   wv_inventur_netto_aufg,
   wv_menge_inventur_aufg,
   wv_inventur_diebstahl_netto_aufg
  FROM KUMULATION);