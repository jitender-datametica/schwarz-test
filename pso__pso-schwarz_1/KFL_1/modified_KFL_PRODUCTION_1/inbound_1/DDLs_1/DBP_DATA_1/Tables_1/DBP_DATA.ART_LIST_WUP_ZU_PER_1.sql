--==============================================================
-- Table: art_list_wup_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_list_wup_zu_per_1
   generated from Powerdesigner on Mittwoch, 23. April 2025 13:03:58
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_LIST_WUP_ZU_PER_1 CLUSTER BY (MANDANT_ID) (
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat_von                             DATE             NOT NULL COMMENT 'Datum wann ein Artikel_1 zum ersten Mal in einem Markt gelistet ist',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   list_quelle_id                      VARCHAR(1)       NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Listungsquelle aus der SAP-Tabelle wlk1. Z.Bsp 5 = Bausteinlistung. Eine_1 Lookup-Tabelle existiert im DWH nicht.',
   struktur_art_id                     INTEGER     NOT NULL COMMENT 'Artikel_1 ID des strukturierten Artikels, dessen Bestandteil der gelistete Artikel_1 ist. Falls es sich bei dem Artikel_1 nicht um einen strukturierten Artikel_1 handelt, ist die Artikel_1 ID des Artikels selbst enthalten. Achtung! Hier schreibt die Versorgung eine_1 kl_art_id rein!',
   dat_bis                             DATE             NOT NULL COMMENT 'Ende des Gültigkeitszeitraums',
   baustein_id                         INTEGER     NOT NULL COMMENT 'ID eines Sortimentsbausteins',
   list_sap_id                         INTEGER     NOT NULL COMMENT 'in SAP zusammen mit Markt / Artikel_1 / gilt-ab ein eindeutiger Schlüssel. Wird benötigt, um Updates aus SAP eindeutig zuordnen zu können. Wertebereich von 1 - 999, Standard ist 1',
   list_komponente_fg                  INTEGER     NOT NULL DEFAULT 0 COMMENT 'Sagt ob die Listung des Artikels eigenständig erfolgt ist (0) oder als Komponente eines Display (1) gelistet wurde.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_LIST_WUP_ZU_PER PRIMARY KEY (art_id, wup_id, nb_id, mandant_id, list_quelle_id, struktur_art_id, dat_von) NOT ENFORCED
)  COMMENT = 'TP2/7 AIS - Zuordnung Artikel_1 zu Listung, Baustein und Wup_1 - MULTISET. Enthält Informationen, aus welchen Listungsquellen Artikel_1 und Markt zugeordnet sind, d.h. welcher Artikel_1 in welchem Markt in den jeweiligen Bausteinen gelistet ist.';
