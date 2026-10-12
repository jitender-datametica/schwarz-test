--==============================================================
-- Table: inventur_warenverlust_det_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: inventur_warenverlust_det_1
   generated from Powerdesigner on Freitag, 6. Juni 2025 14:13:59
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.INVENTUR_WARENVERLUST_DET_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH.',
   inventur_id                         INTEGER     NOT NULL COMMENT 'Eindeutige hochgezählte Nummer über alle Felder des Excel-Uploads.',
   art_id                              INTEGER     NOT NULL COMMENT 'Artikelnummer im DWH. Input: Artikel_1-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.',
   wrg_id                              VARCHAR(3)       NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
   betrag_vk_netto                     NUMBER(29,4)     COMMENT 'Umsatz der betroffenen Inventur_1-Artikel_1 im definierten Inventur_1-Zeitraum je Betrieb.',
   betrag_vk_netto_preisabschrift      NUMBER(29,4)     COMMENT 'Wert der Preisabschriften für die betroffenen Inventur_1-Artikel_1 im definierten Inventur_1-Zeitraum je Betrieb.',
   betrag_vk_netto_totalabschrift      NUMBER(29,4)     COMMENT 'Wert der Totalabschriften für die betroffenen Inventur_1-Artikel_1 im definierten Inventur_1-Zeitraum je Betrieb.',
   menge_inventur_diff                 NUMBER(29,3)     COMMENT 'saldierte Inventur_1-Differenz-Mengen je Artikel_1 und Betrieb im definierten Inventur_1-Zeitraum',
   betrag_vk_netto_inventur_diff       NUMBER(29,4)     COMMENT 'saldierte Inventur_1-Differenz-Werte je Artikel_1 und Betrieb im definierten Inventur_1-Zeitraum',
   menge_inventur_diff_diebstahl       NUMBER(29,3)     COMMENT 'Menge Diebstahl als Teilmenge der saldierten Inventur_1-Differenz-Mengen',
   betrag_vk_netto_inventur_diff_diebstahl NUMBER(29,4)     COMMENT 'Betrag Diebstahl als Teilmenge der Inventur_1-Differenz-Werten',
   betrag_vk_netto_inventur_diff_plan  NUMBER(29,4)     COMMENT 'Von der VT Landesorganisation geplante Inventurdifferenz-Werte im definierten Inventur_1-Zeitraum',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_INVENTUR_WARENVERLUST_DET PRIMARY KEY (mandant_id, inventur_id, art_id) NOT ENFORCED
)  COMMENT = 'Die Tabelle enthält die detaillierten Daten zu den Warenverlusten auf Artikelebene. Sie enthält die Ergebnisse der Verlustberechnungen, die auf Basis der in der Steuertabelle inventur_warenverlust_1 definierten Kriterien durchgeführt wurden.';
