--==============================================================
-- Table: inventur_warenverlust_det
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: inventur_warenverlust_det
   generated from Powerdesigner on Freitag, 6. Juni 2025 14:13:59
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.INVENTUR_WARENVERLUST_DET (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   inventur_id                         INTEGER     NOT NULL COMMENT 'Eindeutige hochgezählte Nummer über alle Felder des Excel-Uploads.',
   art_id                              INTEGER     NOT NULL COMMENT 'Artikelnummer im DWH. Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.',
   wrg_id                              VARCHAR(3)       NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
   betrag_vk_netto                     NUMBER(29,4)     COMMENT 'Umsatz der betroffenen Inventur-Artikel im definierten Inventur-Zeitraum je Betrieb.',
   betrag_vk_netto_preisabschrift      NUMBER(29,4)     COMMENT 'Wert der Preisabschriften für die betroffenen Inventur-Artikel im definierten Inventur-Zeitraum je Betrieb.',
   betrag_vk_netto_totalabschrift      NUMBER(29,4)     COMMENT 'Wert der Totalabschriften für die betroffenen Inventur-Artikel im definierten Inventur-Zeitraum je Betrieb.',
   menge_inventur_diff                 NUMBER(29,3)     COMMENT 'saldierte Inventur-Differenz-Mengen je Artikel und Betrieb im definierten Inventur-Zeitraum',
   betrag_vk_netto_inventur_diff       NUMBER(29,4)     COMMENT 'saldierte Inventur-Differenz-Werte je Artikel und Betrieb im definierten Inventur-Zeitraum',
   menge_inventur_diff_diebstahl       NUMBER(29,3)     COMMENT 'Menge Diebstahl als Teilmenge der saldierten Inventur-Differenz-Mengen',
   betrag_vk_netto_inventur_diff_diebstahl NUMBER(29,4)     COMMENT 'Betrag Diebstahl als Teilmenge der Inventur-Differenz-Werten',
   betrag_vk_netto_inventur_diff_plan  NUMBER(29,4)     COMMENT 'Von der VT Landesorganisation geplante Inventurdifferenz-Werte im definierten Inventur-Zeitraum',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_INVENTUR_WARENVERLUST_DET PRIMARY KEY (mandant_id, inventur_id, art_id) NOT ENFORCED
)  COMMENT = 'Die Tabelle enthält die detaillierten Daten zu den Warenverlusten auf Artikelebene. Sie enthält die Ergebnisse der Verlustberechnungen, die auf Basis der in der Steuertabelle inventur_warenverlust definierten Kriterien durchgeführt wurden.';
