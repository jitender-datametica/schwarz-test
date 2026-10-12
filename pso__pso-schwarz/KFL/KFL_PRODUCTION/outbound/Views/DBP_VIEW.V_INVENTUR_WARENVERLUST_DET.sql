CREATE OR REPLACE VIEW kfl_production_dbp_view.v_inventur_warenverlust_det (mandant_id
OPTIONS(description='Mandant im DWH.'), inventur_id
OPTIONS(description='Eindeutige hochgezählte Nummer über alle Felder des Excel-Uploads.'), art_id
OPTIONS(description='Artikelnummer im DWH. Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'), betrag_vk_netto
OPTIONS(description='Umsatz der betroffenen Inventur-Artikel im definierten Inventur-Zeitraum je Betrieb.'),
betrag_vk_netto_preisabschrift
OPTIONS(description='Wert der Preisabschriften für die betroffenen Inventur-Artikel im definierten Inventur-Zeitraum je Betrieb.'),
betrag_vk_netto_totalabschrift
OPTIONS(description='Wert der Totalabschriften für die betroffenen Inventur-Artikel im definierten Inventur-Zeitraum je Betrieb.'),
menge_inventur_diff
OPTIONS(description='saldierte Inventur-Differenz-Mengen je Artikel und Betrieb im definierten Inventur-Zeitraum'),
betrag_vk_netto_inventur_diff
OPTIONS(description='saldierte Inventur-Differenz-Werte je Artikel und Betrieb im definierten Inventur-Zeitraum'),
menge_inventur_diff_diebstahl
OPTIONS(description='Menge Diebstahl als Teilmenge der saldierten Inventur-Differenz-Mengen'),
betrag_vk_netto_inventur_diff_diebstahl
OPTIONS(description='Betrag Diebstahl als Teilmenge der Inventur-Differenz-Werten'), betrag_vk_netto_inventur_diff_plan
OPTIONS(description='Von der VT Landesorganisation geplante Inventurdifferenz-Werte im definierten Inventur-Zeitraum'))
OPTIONS(DESCRIPTION = `DIE TABELLE ENTHÄLT DIE DETAILLIERTEN DATEN ZU DEN WARENVERLUSTEN AUF ARTIKELEBENE. SIE ENTHÄLT DIE ERGEBNISSE DER VERLUSTBERECHNUNGEN, DIE AUF BASIS DER IN DER STEUERTABELLE INVENTUR_WARENVERLUST DEFINIERTEN KRITERIEN DURCHGEFÜHRT WURDEN.`)
AS SELECT mandant_id,
 inventur_id,
 art_id,
 wrg_id,
 betrag_vk_netto,
 betrag_vk_netto_preisabschrift,
 betrag_vk_netto_totalabschrift,
 menge_inventur_diff,
 betrag_vk_netto_inventur_diff,
 menge_inventur_diff_diebstahl,
 betrag_vk_netto_inventur_diff_diebstahl,
 betrag_vk_netto_inventur_diff_plan
FROM kfl_production_dbp_data.inventur_warenverlust_det;