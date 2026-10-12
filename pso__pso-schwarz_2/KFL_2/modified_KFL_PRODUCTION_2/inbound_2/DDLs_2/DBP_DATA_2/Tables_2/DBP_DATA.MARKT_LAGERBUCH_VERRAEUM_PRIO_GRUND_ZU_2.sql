--==============================================================
-- Table: markt_lagerbuch_verraeum_prio_grund_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: markt_lagerbuch_verraeum_prio_grund_zu_2
   generated from Powerdesigner on Mittwoch, 29. Oktober 2025 13:29:50
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.MARKT_LAGERBUCH_VERRAEUM_PRIO_GRUND_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Warenumschlagsplatz-ID der Filiale, in der der Artikel_2 verkauft wird.',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des abgebenden WUP. Es betrifft sich nur Filiale, deshalb immer 0.',
   stellplatz_nr                       VARCHAR(20)      NOT NULL COMMENT 'Stellplatznummer im Filiallagerbereich. Z.B. 1-F1-1-3',
   markt_lagerbereich_id               INTEGER     NOT NULL COMMENT 'ID des Lagerbereichs in der Filiale.',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.',
   dat_mhd                             DATE             NOT NULL COMMENT 'Mindesthaltbarkeitsdatum des Artikels.',
   betrag_vk_brutto                    NUMBER(29,4)     NOT NULL COMMENT 'VK_2 Brutto Einzelpreis des Artikels.',
   dat_lagerbuch                       DATE             NOT NULL COMMENT 'Datum der Lagerbuchdaten.',
   verraeumung_prio_grund_id           VARCHAR(2)       NOT NULL COMMENT 'ID des Priogrunds. Wichtig führende 0 beibehalten. Z.B. 02',
   wrg_id                              VARCHAR(3)       NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_MARKT_LAGERBUCH_VERRAEUM_PRIO_GRUND_ZU PRIMARY KEY (mandant_id, wup_id, nb_id, stellplatz_nr, markt_lagerbereich_id, art_id, dat_mhd, betrag_vk_brutto, dat_lagerbuch, verraeumung_prio_grund_id) NOT ENFORCED
)  COMMENT = 'Zuordnungstabelle für Lagerbuch in der Filiale zu Verräumungs-Prioritätsgründen. Quellsystem: Couchbase. Diese Tabelle stellt die Verbindung zwischen den Artikeln im Lagerbuch der Filiale und den Gründen her, die diese Artikel_2 als "kritisch" für die Verräumung auf die Verkaufsfläche einstufen. Es ist möglich, dass ein bestimmter Artikel_2 im Lagerbuch mehrere Prioritätsgründe aufweist.';
