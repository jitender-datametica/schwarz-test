--==============================================================
-- Table: rekl_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: rekl_1
   generated from Powerdesigner on Montag, 12. August 2024 18:40:42
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.REKL_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH.',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Warenumschlagsplatz, an dem die Reklamation erfasst wurde',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
   dat                                 DATE             NOT NULL COMMENT 'Datum des Reklamationsvorgangs.',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Artikelnummer im DWH. Input: Artikel_1-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_1-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.',
   kasse_nr                            NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Nummer der Kasse - wird für Eindeutigkeit der Daten benötigt. Nur bei Datenquelle Bondaten gefüllt, sonst -1.',
   bon_nr                              NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Nummer des Kassenbons - wird für Eindeutigkeit der Daten benötigt. Nur bei Datenquelle Bondaten gefüllt, sonst -1.',
   pos_nr                              NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Position auf dem Kassenbon - wird für Eindeutigkeit der Daten benötigt. Nur bei Datenquelle Bondaten gefüllt, sonst -1.',
   reklamationsgrund_id                NUMBER(38,0)     NOT NULL COMMENT 'Reklamationskennzeichen, z.Bsp. 30.',
   ean_kasse                           NUMBER(38,0)     COMMENT 'Die EAN_1 des Artikels.
            Ein Kauflandartikel im System existiert unter einer Artikelnummer, welche mehrere GTINs zugeordnet haben kann. Beispiel: Alle Ravensburger Puzzle laufen unter einer einzigen Artikelnummer in SAP, da einfach nur allgemein "Puzzle" eingekauft wird und der Lieferant selbst entscheidet welche verschiedenen Arten er bereitstellt. Jede Puzzleart hat eine_1 eigene GTIN, aber läuft in SAP unter einer gemeinsamen Nummer (Haupt-GTIN). Die genaue GTIN (EAN_1) des betrachteten Artikels lässt sich deshalb nur an der Kasse genau zuordnen.',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.',
   vk_brutto_re                        NUMBER(38,2)     NOT NULL COMMENT 'Reklamierter Verkaufspreis pro Mengeneinheit.',
   vk_menge_re                         NUMBER(38,3)     NOT NULL COMMENT 'Menge des reklamierten Artikels.',
   gp_id                               NUMBER(38,0)     NOT NULL COMMENT 'Hauptlieferant (Kreditor_1), 6-stellige Lieferantennummer.',
   mhd                                 VARCHAR(6)       COLLATE 'en-ci' COMMENT 'Mindesthaltbarkeitsdatum, kommt in verschiedenen Formaten: TTMMJJ oder MMJJ oder JJ.',
   los_charge                          VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Inhalt vom Erfasser frei vergebbar, z. Bsp. 4014500008844 oder dbb007ewg.',
   art_id_ref                          NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Referenzartikelnummer. Hier sind filialfremde Kaufland-Artikelnummern hinterlegt, wenn zutreffend, sonst -1.',
   kunden_text                         VARCHAR(100)     NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Freitextfeld, kann bei Rückgabe der Ware befüllt werden.',
   bon_storno_fg                       NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Markierung für stornierten Satz. 1 = wurde storniert und wird nicht in die Auswertung einbezogen.',
   mit_ware_fg                         NUMBER(38,0)     NOT NULL DEFAULT 1 COMMENT 'Zeigt an, ob die Rückgabe mit oder ohne Ware erfolgt ist. Mit Ware = 1, ohne Ware = 0. Ab KW19/2012 stimmig. Wird im Versorgungsprozess aus Return Reason und Return Type Code befüllt.',
   start_bon_zeile                     TIMESTAMP_NTZ(9) COMMENT 'Zeitstempel bei Beginn der Bewegung.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_REKL PRIMARY KEY (mandant_id, nb_id, dat, wup_id, art_id, kasse_nr, bon_nr, pos_nr) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Reklamation QBM - MULTISET';
