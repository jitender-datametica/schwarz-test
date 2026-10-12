--==============================================================
-- Table: markt_lagerbuch
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: markt_lagerbuch
   generated from Powerdesigner on Mittwoch, 29. Oktober 2025 13:29:50
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.MARKT_LAGERBUCH (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Warenumschlagsplatz-ID der Filiale, in der der Artikel verkauft wird.',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des abgebenden WUP. Es betrifft sich nur Filiale, deshalb immer 0.',
   stellplatz_nr                       VARCHAR(20)      NOT NULL COMMENT 'Stellplatznummer im Filiallagerbereich. Z.B. 1-F1-1-3',
   markt_lagerbereich_id               INTEGER     NOT NULL COMMENT 'ID des Lagerbereichs in der Filiale.',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.',
   dat_mhd                             DATE             NOT NULL COMMENT 'Mindesthaltbarkeitsdatum des Artikels.',
   betrag_vk_brutto                    NUMBER(29,4)     NOT NULL COMMENT 'VK Brutto Einzelpreis des Artikels.',
   dat_lagerbuch                       DATE             NOT NULL COMMENT 'Datum der Lagerbuchdaten.',
   menge_lagerbestand_stellplatz       NUMBER(29,3)     COMMENT 'Lagerbestand auf dem Stellplatz.',
   menge_lagerbestand_gesamt           NUMBER(29,3)     COMMENT 'Gesamter Bestand im Filiallager.',
   menge_filialbestand                 NUMBER(29,3)     COMMENT 'Gesamter Filialbestand. Enthält die Summe des aktuellen Lagerbestands und des Bestands im Verkaufsregal für die zugehörige Filiale.',
   menge_opt_bestand                   NUMBER(29,3)     COMMENT 'Maximaler oder optischer Bestand des Artikels im Regal.',
   rate_verraeumung                    NUMBER(29,2)     COMMENT 'Für jeden Artikel im Lager wird geprüft wieviel % des Bestandes ins Verkaufsregal verräumt werden können. Hierfür wird aus dem Filialbestand minus Lagerbestand minus Wareneingangs-Bestand der Regalbestand ermittelt. ',
   dat_aenderung                       DATE             NOT NULL COMMENT 'letzte Änderung auf dem Stellplatz.',
   wrg_id                              VARCHAR(3)       NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_MARKT_LAGERBUCH PRIMARY KEY (mandant_id, wup_id, nb_id, stellplatz_nr, markt_lagerbereich_id, art_id, dat_mhd, betrag_vk_brutto, dat_lagerbuch) NOT ENFORCED
)  COMMENT = 'Die Tabelle enthält einen Überblick über die Bestandsituation in einer Filiale (Lager, Verkaufsfläche). Sie wird aus dem System Couchbase versorgt.';
