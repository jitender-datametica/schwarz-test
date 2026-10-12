CREATE OR REPLACE VIEW DBP_VIEW.V_L_LAGERPLATZ_1 (
   mandant_id                               COMMENT 'Der Mandant_1 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'
  ,wup_id                                   COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'
  ,lagernummer_id                           COMMENT 'ID der Lagernummer - höchste Ebene der Lagerhierarchie'
  ,lagertyp_id                              COMMENT 'ID des Lagertyps. Zweite Ebene der Lagerhierarchie'
  ,lagerplatz_id                            COMMENT 'ID des Lagerplatzes. Vierte Ebene der Lagerhierarchie'
  ,lagerbereich_id                          COMMENT 'Schlüssel für die Lagerbereiche. Dritte Ebene der Lagerhierarchie - nicht in allen Fällen vorhanden'
  ,dat_von                                  COMMENT 'Gültigkeitbeginn für diesen Datensatz. Es wird dazu das Datum aus dem Dateinamen herangezogen.'
  ,dat_bis                                  COMMENT 'Gültigkeitsende für diesen Datensatz. Das Datum wird initial mit dem Wert 31.12.9999 belegt.'
  ,einlager_sperr_fg                        COMMENT 'Zeigt eine_1 Sperre des Lagerplatzes für Einlagerung an. Kennzeichen ist durch den SAP-User gesetzt.Aus skzue'
  ,auslager_sperr_fg                        COMMENT 'Zeigt eine_1 Sperre des Lagerplatzes für Auslagerung an. Kennzeichen ist durch den SAP-User gesetzt.skzua'
  ,anzahl_quant                             COMMENT 'Bildet den Inhalt des Feldes anzq aus SAP ab. 0 ist kein Bestand, Bei > 0 ist Bestand vorhanden. Aus anzqu'
  ,komm_bereich                             COMMENT 'Kommissionierbereich. Zeigt virtuelle Griffzonen an. Aus kober'
  ,lagerplatz_sortierfeld                   COMMENT 'Kennzahl für einen Lagerplatz, die bei der Sortierung der Transportauftragspositionen berücksichtigt wird. Aus reihf'
  ,brand_abschnitt_id                       COMMENT 'ID des Brandabschnitts aus brand_1'
  ,lagerplatz_typ_id                        COMMENT 'Lagerplatztyp. Dient zur Einteilung von Lagerplätzen in Gruppen (z.Bsp. R1 = Regal Höhe 1 (105) ) aus lptyp'
  ,lagerplatz_gewicht_max                   COMMENT 'Tragfähigkeit des Lagerplatzes (Einheit vermutlich KG) aus lgewi'
  ,lagerplatz_ebene                         COMMENT 'Ebene des Lagerplatzes aus zztm_ebene.Enthält die Werte EG oder OG'
  ,sperrgrund_id                            COMMENT 'Sperrgrund'
)
COMMENT = 'TP408_LVS - Lookuptabelle der Lagerplaetze aus der SAP Tabelle lagp'
 AS 
    SELECT 
        mandant_id,
        wup_id,
        nb_id,
        lagernummer_id,
        lagertyp_id,
        lagerplatz_id,
        lagerbereich_id,
        dat_von,
        dat_bis,
        einlager_sperr_fg,
        auslager_sperr_fg,
        anzahl_quant,
        komm_bereich,
        lagerplatz_sortierfeld,
        brand_abschnitt_id,
        lagerplatz_typ_id,
        lagerplatz_gewicht_max,
        lagerplatz_ebene,
        sperrgrund_id

FROM DBP_DATA.L_LAGERPLATZ_1 ;