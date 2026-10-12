/* 2025-08-06 tekin: Added column BETRAG_VK_NETTO_KUNDENKARTE for K Card Umsatzanteil
2025-08-12 tekin: added wrg_id and lookups for current store and exchange rate */
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wupcal_fakt_2 (mandant_id, nb_id, wup_id, dat, wrg_id,
kunden_gesamt_ist, kunden_gesamt_wvj, kunden_gesamt_kvj, kunden_kcard_ist, kunden_kcard_wvj, kunden_kcard_kvj,
bonanzahl_kundenkarte_payback, bonanzahl_kundenkarte, bonanzahl_frischetheke_ohne_fisch, bonanzahl, bonanzahl_imbiss,
umsatz_brutto_ods_verkauf, umsatz_brutto_ods_kassenabschluss, umsatz_netto_kcard_ist
OPTIONS(description='Umsatz netto mit Kaufland Loyalty Programm (kundenkarte_typ_id =2) auf Markt- und Tagebene - Ist'),
umsatz_netto_kcard_kvj
OPTIONS(description='Umsatz netto mit Kaufland Loyalty Programm (kundenkarte_typ_id =2) auf Markt- und Tagebene - VJ zum Kalendertagsvergleich'),
umsatz_netto_kcard_wvj
OPTIONS(description='Umsatz netto mit Kaufland Loyalty Programm (kundenkarte_typ_id =2) auf Markt- und Tagebene - VJ zum Wochentagsvergleich'))
OPTIONS(DESCRIPTION = `Marktkalender mit Ereignissen für Bonanzahl, Datenlieferung und Umsatz auf Basis von Ist, KT und WT`)
AS WITH WC AS (SELECT WCAL.mandant_id,
   WCAL.nb_id,
   WUP.aktuell_wup_id AS wup_id,
   WCAL.dat,
   WCAL.wrg_id,
   WCAL.bonanzahl_sug,
   WCAL.bonanzahl_kundenkarte,
   WCAL.bonanzahl_kundenkarte_payback,
   WCAL.bonanzahl,
   WCAL.bonanzahl_imbiss,
   WCAL.bonanzahl_frischetheke_ohne_fisch,
   WCAL.umsatz_brutto_ods_verkauf,
   WCAL.umsatz_brutto_ods_kassenabschluss,
   WCAL.betrag_vk_netto_kundenkarte
  FROM kfl_production_dbp_view.v_wupcal_2 AS WCAL
   INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON WCAL.mandant_id = WUP.mandant_id AND WCAL.wup_id = WUP.wup_id) (-- PRIMARY KEY (mandant_id, wup_id, nb_id, dat)

  /* Offizielle Kunden Filiale */ /* Kunden mit K-Card */ /* Historie Payback / Kundenkarte */
  -- convert local currency to EUR
 SELECT wc_ist.mandant_id,
   wc_ist.nb_id,
   wc_ist.wup_id,
   wc_ist.dat,
   K.nach_wrg_id AS wrg_id,
   wc_ist.bonanzahl_sug AS kunden_gesamt_ist,
   wc_wvj.bonanzahl_sug AS kunden_gesamt_wvj,
   wc_kvj.bonanzahl_sug AS kunden_gesamt_kvj,
    wc_ist.bonanzahl_kundenkarte - IFNULL(wc_ist.bonanzahl_kundenkarte_payback, 0) AS kunden_kcard_ist,
    wc_wvj.bonanzahl_kundenkarte - IFNULL(wc_wvj.bonanzahl_kundenkarte_payback, 0) AS kunden_kcard_wvj,
    wc_kvj.bonanzahl_kundenkarte - IFNULL(wc_kvj.bonanzahl_kundenkarte_payback, 0) AS kunden_kcard_kvj,
   wc_ist.bonanzahl_kundenkarte_payback,
   wc_ist.bonanzahl_kundenkarte /* Bons/Kunden Frischetheken (ohne Fisch) - Filialwettbewerb Theke */,
   wc_ist.bonanzahl_frischetheke_ohne_fisch /* Objekte Kassenabschluss (EOD) - nicht geprüft */
   /* Bonanzahl (Gesamt) ungefiltert */,
   wc_ist.bonanzahl /* Bons/Kunden Imbiss */,
   wc_ist.bonanzahl_imbiss /* Umsatz (ODS) ohne WRG_2?! */,
    wc_ist.umsatz_brutto_ods_verkauf * K.umrechnungskurs AS umsatz_brutto_ods_verkauf,
    wc_ist.umsatz_brutto_ods_kassenabschluss * K.umrechnungskurs AS umsatz_brutto_ods_kassenabschluss,
    wc_ist.betrag_vk_netto_kundenkarte * K.umrechnungskurs AS umsatz_netto_kcard_ist,
    wc_kvj.betrag_vk_netto_kundenkarte * K.umrechnungskurs AS umsatz_netto_kcard_kvj,
    wc_wvj.betrag_vk_netto_kundenkarte * K.umrechnungskurs AS umsatz_netto_kcard_wvj
  FROM WC AS wc_ist
   LEFT JOIN WC AS wc_wvj ON wc_ist.mandant_id = wc_wvj.mandant_id AND wc_ist.wup_id = wc_wvj.wup_id AND wc_wvj.dat =
     DATE_SUB(wc_ist.dat, INTERVAL 364 DAY)
   LEFT JOIN WC AS wc_kvj ON wc_ist.mandant_id = wc_kvj.mandant_id AND wc_ist.wup_id = wc_kvj.wup_id AND wc_kvj.dat = IF(wc_ist
       .dat = LAST_DAY(wc_ist.dat), LAST_DAY(DATE_ADD(wc_ist.dat, INTERVAL - 12 MONTH)), DATE_ADD(wc_ist.dat, INTERVAL -
       12 MONTH))
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_kurs_umrechnung_2 AS K ON wc_ist.wrg_id = K.von_wrg_id);