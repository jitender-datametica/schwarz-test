--==============================================================
-- Table: inventur_warenverlust_det_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: inventur_warenverlust_det_1
   generated from Powerdesigner on Freitag, 6. Juni 2025 14:13:59
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.inventur_warenverlust_det_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
inventur_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige hochgezählte Nummer über alle Felder des Excel-Uploads.'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikelnummer im DWH. Input: Artikel_1-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'),
betrag_vk_netto BIGNUMERIC(38,4)
OPTIONS(description='Umsatz der betroffenen Inventur_1-Artikel_1 im definierten Inventur_1-Zeitraum je Betrieb.'),
betrag_vk_netto_preisabschrift BIGNUMERIC(38,4)
OPTIONS(description='Wert der Preisabschriften für die betroffenen Inventur_1-Artikel_1 im definierten Inventur_1-Zeitraum je Betrieb.'),
betrag_vk_netto_totalabschrift BIGNUMERIC(38,4)
OPTIONS(description='Wert der Totalabschriften für die betroffenen Inventur_1-Artikel_1 im definierten Inventur_1-Zeitraum je Betrieb.'),
menge_inventur_diff BIGNUMERIC(38,3)
OPTIONS(description='saldierte Inventur_1-Differenz-Mengen je Artikel_1 und Betrieb im definierten Inventur_1-Zeitraum'),
betrag_vk_netto_inventur_diff BIGNUMERIC(38,4)
OPTIONS(description='saldierte Inventur_1-Differenz-Werte je Artikel_1 und Betrieb im definierten Inventur_1-Zeitraum'),
menge_inventur_diff_diebstahl BIGNUMERIC(38,3)
OPTIONS(description='Menge Diebstahl als Teilmenge der saldierten Inventur_1-Differenz-Mengen'),
betrag_vk_netto_inventur_diff_diebstahl BIGNUMERIC(38,4)
OPTIONS(description='Betrag Diebstahl als Teilmenge der Inventur_1-Differenz-Werten'),
betrag_vk_netto_inventur_diff_plan BIGNUMERIC(38,4)
OPTIONS(description='Von der VT Landesorganisation geplante Inventurdifferenz-Werte im definierten Inventur_1-Zeitraum'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, inventur_id, art_id) NOT ENFORCED
)
OPTIONS(description='Die Tabelle enthält die detaillierten Daten zu den Warenverlusten auf Artikelebene. Sie enthält die Ergebnisse der Verlustberechnungen, die auf Basis der in der Steuertabelle inventur_warenverlust_1 definierten Kriterien durchgeführt wurden.');