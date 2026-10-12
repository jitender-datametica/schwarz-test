--==============================================================
-- Table: l_lagerplatz_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_lagerplatz_2
   generated from Powerdesigner on Montag, 26. Mai 2025 15:27:22
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_lagerplatz_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Mandant_2 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID der Lagernummer - höchste Ebene der Lagerhierarchie'),
lagertyp_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID des Lagertyps. Zweite Ebene der Lagerhierarchie'),
lagerplatz_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID des Lagerplatzes. Vierte Ebene der Lagerhierarchie'),
lagerbereich_id STRING(3) COLLATE 'und:ci'
OPTIONS(description='Schlüssel für die Lagerbereiche. Dritte Ebene der Lagerhierarchie - nicht in allen Fällen vorhanden'),
dat_von DATE NOT NULL
OPTIONS(description='Gültigkeitbeginn für diesen Datensatz. Es wird dazu das Datum aus dem Dateinamen herangezogen.'),
dat_bis DATE NOT NULL
OPTIONS(description='Gültigkeitsende für diesen Datensatz. Das Datum wird initial mit dem Wert 31.12.9999 belegt.'),
einlager_sperr_fg BIGNUMERIC(38,0)
OPTIONS(description='Zeigt eine_2 Sperre des Lagerplatzes für Einlagerung an. Kennzeichen ist durch den SAP-User gesetzt.Aus skzue'),
auslager_sperr_fg BIGNUMERIC(38,0)
OPTIONS(description='Zeigt eine_2 Sperre des Lagerplatzes für Auslagerung an. Kennzeichen ist durch den SAP-User gesetzt.skzua'),
anzahl_quant BIGNUMERIC(38,0)
OPTIONS(description='Bildet den Inhalt des Feldes anzq aus SAP ab. 0 ist kein Bestand, Bei > 0 ist Bestand vorhanden. Aus anzqu'),
komm_bereich STRING(3) COLLATE 'und:ci'
OPTIONS(description='Kommissionierbereich. Zeigt virtuelle Griffzonen an. Aus kober'),
lagerplatz_sortierfeld STRING(6) COLLATE 'und:ci' DEFAULT '      ' NOT NULL
OPTIONS(description='Kennzahl für einen Lagerplatz, die bei der Sortierung der Transportauftragspositionen berücksichtigt wird. Aus reihf'),
brand_abschnitt_id STRING(2) COLLATE 'und:ci' OPTIONS(description='ID des Brandabschnitts aus brand_2'),
lagerplatz_typ_id STRING(2) COLLATE 'und:ci' DEFAULT '  ' NOT NULL
OPTIONS(description='Lagerplatztyp. Dient zur Einteilung von Lagerplätzen in Gruppen (z.Bsp. R1 = Regal Höhe 1 (105) ) aus lptyp'),
lagerplatz_gewicht_max NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Tragfähigkeit des Lagerplatzes (Einheit vermutlich KG) aus lgewi'),
lagerplatz_ebene STRING(2) COLLATE 'und:ci'
OPTIONS(description='Ebene des Lagerplatzes aus zztm_ebene.Enthält die Werte EG oder OG'),
sperrgrund_id STRING(1) OPTIONS(description='Sperrgrund'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id) NOT ENFORCED
) CLUSTER BY mandant_id, wup_id, dat_bis
OPTIONS(description='TP408_LVS - Lookuptabelle der Lagerplaetze aus der SAP Tabelle lagp');