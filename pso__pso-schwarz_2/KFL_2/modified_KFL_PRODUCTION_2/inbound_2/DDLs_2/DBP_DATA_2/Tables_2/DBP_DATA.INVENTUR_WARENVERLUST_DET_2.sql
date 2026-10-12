--==============================================================
-- Table: inventur_warenverlust_det_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: inventur_warenverlust_det_2
   generated from Powerdesigner on Freitag, 6. Juni 2025 14:13:59
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.INVENTUR_WARENVERLUST_DET_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH.',
   inventur_id                         INTEGER     NOT NULL COMMENT 'Eindeutige hochgezählte Nummer über alle Felder des Excel-Uploads.',
   art_id                              INTEGER     NOT NULL COMMENT 'Artikelnummer im DWH. Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.',
   wrg_id                              VARCHAR(3)       NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
   betrag_vk_netto                     NUMBER(29,4)     COMMENT 'Umsatz der betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb.',
   betrag_vk_netto_preisabschrift      NUMBER(29,4)     COMMENT 'Wert der Preisabschriften für die betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb.',
   betrag_vk_netto_totalabschrift      NUMBER(29,4)     COMMENT 'Wert der Totalabschriften für die betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb.',
   menge_inventur_diff                 NUMBER(29,3)     COMMENT 'saldierte Inventur_2-Differenz-Mengen je Artikel_2 und Betrieb im definierten Inventur_2-Zeitraum',
   betrag_vk_netto_inventur_diff       NUMBER(29,4)     COMMENT 'saldierte Inventur_2-Differenz-Werte je Artikel_2 und Betrieb im definierten Inventur_2-Zeitraum',
   menge_inventur_diff_diebstahl       NUMBER(29,3)     COMMENT 'Menge Diebstahl als Teilmenge der saldierten Inventur_2-Differenz-Mengen',
   betrag_vk_netto_inventur_diff_diebstahl NUMBER(29,4)     COMMENT 'Betrag Diebstahl als Teilmenge der Inventur_2-Differenz-Werten',
   betrag_vk_netto_inventur_diff_plan  NUMBER(29,4)     COMMENT 'Von der VT Landesorganisation geplante Inventurdifferenz-Werte im definierten Inventur_2-Zeitraum',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_INVENTUR_WARENVERLUST_DET PRIMARY KEY (mandant_id, inventur_id, art_id) NOT ENFORCED
)  COMMENT = 'Die Tabelle enthält die detaillierten Daten zu den Warenverlusten auf Artikelebene. Sie enthält die Ergebnisse der Verlustberechnungen, die auf Basis der in der Steuertabelle inventur_warenverlust_2 definierten Kriterien durchgeführt wurden.';
