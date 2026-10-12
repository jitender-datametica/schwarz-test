CREATE OR REPLACE VIEW DBP_VIEW.V_REKL (
   mandant_id                               COMMENT 'Mandant im DWH.'
  ,wup_id                                   COMMENT 'Warenumschlagsplatz, an dem die Reklamation erfasst wurde'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'
  ,dat                                      COMMENT 'Datum des Reklamationsvorgangs.'
  ,art_id                                   COMMENT 'Artikelnummer im DWH. Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'
  ,kasse_nr                                 COMMENT 'Nummer der Kasse - wird für Eindeutigkeit der Daten benötigt. Nur bei Datenquelle Bondaten gefüllt, sonst -1.'
  ,bon_nr                                   COMMENT 'Nummer des Kassenbons - wird für Eindeutigkeit der Daten benötigt. Nur bei Datenquelle Bondaten gefüllt, sonst -1.'
  ,pos_nr                                   COMMENT 'Position auf dem Kassenbon - wird für Eindeutigkeit der Daten benötigt. Nur bei Datenquelle Bondaten gefüllt, sonst -1.'
  ,reklamationsgrund_id                     COMMENT 'Reklamationskennzeichen, z.Bsp. 30.'
  ,ean_kasse                                COMMENT 'Die EAN des Artikels.
Ein Kauflandartikel im System existiert unter einer Artikelnummer, welche mehrere GTINs zugeordnet haben kann. Beispiel: Alle Ravensburger Puzzle laufen unter einer einzigen Artikelnummer in SAP, da einfach nur allgemein "Puzzle" eingekauft wird und der Lieferant selbst entscheidet welche verschiedenen Arten er bereitstellt. Jede Puzzleart hat eine eigene GTIN, aber läuft in SAP unter einer gemeinsamen Nummer (Haupt-GTIN). Die genaue GTIN (EAN) des betrachteten Artikels lässt sich deshalb nur an der Kasse genau zuordnen.'
  ,wrg_id                                   COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'
  ,vk_brutto_re                             COMMENT 'Reklamierter Verkaufspreis pro Mengeneinheit.'
  ,vk_menge_re                              COMMENT 'Menge des reklamierten Artikels.'
  ,gp_id                                    COMMENT 'Hauptlieferant (Kreditor), 6-stellige Lieferantennummer.'
  ,mhd                                      COMMENT 'Mindesthaltbarkeitsdatum, kommt in verschiedenen Formaten: TTMMJJ oder MMJJ oder JJ.'
  ,los_charge                               COMMENT 'Inhalt vom Erfasser frei vergebbar, z. Bsp. 4014500008844 oder dbb007ewg.'
  ,art_id_ref                               COMMENT 'Referenzartikelnummer. Hier sind filialfremde Kaufland-Artikelnummern hinterlegt, wenn zutreffend, sonst -1.'
  ,kunden_text                              COMMENT 'Freitextfeld, kann bei Rückgabe der Ware befüllt werden.'
  ,bon_storno_fg                            COMMENT 'Markierung für stornierten Satz. 1 = wurde storniert und wird nicht in die Auswertung einbezogen.'
  ,mit_ware_fg                              COMMENT 'Zeigt an, ob die Rückgabe mit oder ohne Ware erfolgt ist. Mit Ware = 1, ohne Ware = 0. Ab KW19/2012 stimmig. Wird im Versorgungsprozess aus Return Reason und Return Type Code befüllt.'
  ,start_bon_zeile                          COMMENT 'Zeitstempel bei Beginn der Bewegung.'
)
COMMENT = 'TP2_AIS - Reklamation QBM - MULTISET'
 AS 
    SELECT 
        mandant_id,
        wup_id,
        nb_id,
        dat,
        art_id,
        kasse_nr,
        bon_nr,
        pos_nr,
        reklamationsgrund_id,
        ean_kasse,
        wrg_id,
        vk_brutto_re,
        vk_menge_re,
        gp_id,
        mhd,
        los_charge,
        art_id_ref,
        kunden_text,
        bon_storno_fg,
        mit_ware_fg,
        start_bon_zeile

FROM DBP_DATA.REKL ;