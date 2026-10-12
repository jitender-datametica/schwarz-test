CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_lagerplatz (mandant_id
OPTIONS(description='Der Mandant 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
wup_id OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), lagernummer_id
OPTIONS(description='ID der Lagernummer - höchste Ebene der Lagerhierarchie'), lagertyp_id
OPTIONS(description='ID des Lagertyps. Zweite Ebene der Lagerhierarchie'), lagerplatz_id
OPTIONS(description='ID des Lagerplatzes. Vierte Ebene der Lagerhierarchie'), lagerbereich_id
OPTIONS(description='Schlüssel für die Lagerbereiche. Dritte Ebene der Lagerhierarchie - nicht in allen Fällen vorhanden'),
dat_von
OPTIONS(description='Gültigkeitbeginn für diesen Datensatz. Es wird dazu das Datum aus dem Dateinamen herangezogen.'),
dat_bis
OPTIONS(description='Gültigkeitsende für diesen Datensatz. Das Datum wird initial mit dem Wert 31.12.9999 belegt.'),
einlager_sperr_fg
OPTIONS(description='Zeigt eine Sperre des Lagerplatzes für Einlagerung an. Kennzeichen ist durch den SAP-User gesetzt.Aus skzue'),
auslager_sperr_fg
OPTIONS(description='Zeigt eine Sperre des Lagerplatzes für Auslagerung an. Kennzeichen ist durch den SAP-User gesetzt.skzua'),
anzahl_quant
OPTIONS(description='Bildet den Inhalt des Feldes anzq aus SAP ab. 0 ist kein Bestand, Bei > 0 ist Bestand vorhanden. Aus anzqu'),
komm_bereich OPTIONS(description='Kommissionierbereich. Zeigt virtuelle Griffzonen an. Aus kober'),
lagerplatz_sortierfeld
OPTIONS(description='Kennzahl für einen Lagerplatz, die bei der Sortierung der Transportauftragspositionen berücksichtigt wird. Aus reihf'),
brand_abschnitt_id OPTIONS(description='ID des Brandabschnitts aus brand'), lagerplatz_typ_id
OPTIONS(description='Lagerplatztyp. Dient zur Einteilung von Lagerplätzen in Gruppen (z.Bsp. R1 = Regal Höhe 1 (105) ) aus lptyp'),
lagerplatz_gewicht_max OPTIONS(description='Tragfähigkeit des Lagerplatzes (Einheit vermutlich KG) aus lgewi'),
lagerplatz_ebene OPTIONS(description='Ebene des Lagerplatzes aus zztm_ebene.Enthält die Werte EG oder OG'),
sperrgrund_id OPTIONS(description='Sperrgrund'))
OPTIONS(DESCRIPTION = `TP408_LVS - LOOKUPTABELLE DER LAGERPLAETZE AUS DER SAP TABELLE LAGP`) AS SELECT mandant_id,
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
FROM kfl_production_dbp_data.l_lagerplatz;