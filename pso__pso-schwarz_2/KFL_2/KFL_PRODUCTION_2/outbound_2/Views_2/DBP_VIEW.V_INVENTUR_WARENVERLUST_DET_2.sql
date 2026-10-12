CREATE OR REPLACE VIEW kfl_production_dbp_view.v_inventur_warenverlust_det_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH.'), inventur_id
OPTIONS(description='Eindeutige hochgezählte Nummer über alle Felder des Excel-Uploads.'), art_id
OPTIONS(description='Artikelnummer im DWH. Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'), betrag_vk_netto
OPTIONS(description='Umsatz der betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb.'),
betrag_vk_netto_preisabschrift
OPTIONS(description='Wert der Preisabschriften für die betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb.'),
betrag_vk_netto_totalabschrift
OPTIONS(description='Wert der Totalabschriften für die betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb.'),
menge_inventur_diff
OPTIONS(description='saldierte Inventur_2-Differenz-Mengen je Artikel_2 und Betrieb im definierten Inventur_2-Zeitraum'),
betrag_vk_netto_inventur_diff
OPTIONS(description='saldierte Inventur_2-Differenz-Werte je Artikel_2 und Betrieb im definierten Inventur_2-Zeitraum'),
menge_inventur_diff_diebstahl
OPTIONS(description='Menge Diebstahl als Teilmenge der saldierten Inventur_2-Differenz-Mengen'),
betrag_vk_netto_inventur_diff_diebstahl
OPTIONS(description='Betrag Diebstahl als Teilmenge der Inventur_2-Differenz-Werten'), betrag_vk_netto_inventur_diff_plan
OPTIONS(description='Von der VT Landesorganisation geplante Inventurdifferenz-Werte im definierten Inventur_2-Zeitraum'))
OPTIONS(DESCRIPTION = `DIE TABELLE ENTHÄLT DIE DETAILLIERTEN DATEN ZU DEN WARENVERLUSTEN AUF ARTIKELEBENE. SIE ENTHÄLT DIE ERGEBNISSE DER VERLUSTBERECHNUNGEN, DIE AUF BASIS DER IN DER STEUERTABELLE INVENTUR_WARENVERLUST_2 DEFINIERTEN KRITERIEN DURCHGEFÜHRT WURDEN.`)
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
FROM kfl_production_dbp_data.inventur_warenverlust_det_2;