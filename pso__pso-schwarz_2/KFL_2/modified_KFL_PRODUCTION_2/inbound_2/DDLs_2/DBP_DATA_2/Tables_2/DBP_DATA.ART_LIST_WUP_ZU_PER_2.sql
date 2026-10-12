--==============================================================
-- Table: art_list_wup_zu_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_list_wup_zu_per_2
   generated from Powerdesigner on Mittwoch, 23. April 2025 13:03:58
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_LIST_WUP_ZU_PER_2 CLUSTER BY (MANDANT_ID) (
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat_von                             DATE             NOT NULL COMMENT 'Datum wann ein Artikel_2 zum ersten Mal in einem Markt gelistet ist',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   list_quelle_id                      VARCHAR(1)       NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Listungsquelle aus der SAP-Tabelle wlk1. Z.Bsp 5 = Bausteinlistung. Eine_2 Lookup-Tabelle existiert im DWH nicht.',
   struktur_art_id                     INTEGER     NOT NULL COMMENT 'Artikel_2 ID des strukturierten Artikels, dessen Bestandteil der gelistete Artikel_2 ist. Falls es sich bei dem Artikel_2 nicht um einen strukturierten Artikel_2 handelt, ist die Artikel_2 ID des Artikels selbst enthalten. Achtung! Hier schreibt die Versorgung eine_2 kl_art_id rein!',
   dat_bis                             DATE             NOT NULL COMMENT 'Ende des Gültigkeitszeitraums',
   baustein_id                         INTEGER     NOT NULL COMMENT 'ID eines Sortimentsbausteins',
   list_sap_id                         INTEGER     NOT NULL COMMENT 'in SAP zusammen mit Markt / Artikel_2 / gilt-ab ein eindeutiger Schlüssel. Wird benötigt, um Updates aus SAP eindeutig zuordnen zu können. Wertebereich von 1 - 999, Standard ist 1',
   list_komponente_fg                  INTEGER     NOT NULL DEFAULT 0 COMMENT 'Sagt ob die Listung des Artikels eigenständig erfolgt ist (0) oder als Komponente eines Display (1) gelistet wurde.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_LIST_WUP_ZU_PER PRIMARY KEY (art_id, wup_id, nb_id, mandant_id, list_quelle_id, struktur_art_id, dat_von) NOT ENFORCED
)  COMMENT = 'TP2/7 AIS - Zuordnung Artikel_2 zu Listung, Baustein und Wup_2 - MULTISET. Enthält Informationen, aus welchen Listungsquellen Artikel_2 und Markt zugeordnet sind, d.h. welcher Artikel_2 in welchem Markt in den jeweiligen Bausteinen gelistet ist.';
