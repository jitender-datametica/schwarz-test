--==============================================================
-- Table: l_lagerplatz
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_lagerplatz
   generated from Powerdesigner on Montag, 26. Mai 2025 15:27:22
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_LAGERPLATZ CLUSTER BY (
     MANDANT_ID,
     WUP_ID,
     DAT_BIS
) (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Der Mandant 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   lagernummer_id                      VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Lagernummer - höchste Ebene der Lagerhierarchie',
   lagertyp_id                         VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'ID des Lagertyps. Zweite Ebene der Lagerhierarchie',
   lagerplatz_id                       VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'ID des Lagerplatzes. Vierte Ebene der Lagerhierarchie',
   lagerbereich_id                     VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Schlüssel für die Lagerbereiche. Dritte Ebene der Lagerhierarchie - nicht in allen Fällen vorhanden',
   dat_von                             DATE             NOT NULL COMMENT 'Gültigkeitbeginn für diesen Datensatz. Es wird dazu das Datum aus dem Dateinamen herangezogen.',
   dat_bis                             DATE             NOT NULL COMMENT 'Gültigkeitsende für diesen Datensatz. Das Datum wird initial mit dem Wert 31.12.9999 belegt.',
   einlager_sperr_fg                   NUMBER(38,0)     COMMENT 'Zeigt eine Sperre des Lagerplatzes für Einlagerung an. Kennzeichen ist durch den SAP-User gesetzt.Aus skzue',
   auslager_sperr_fg                   NUMBER(38,0)     COMMENT 'Zeigt eine Sperre des Lagerplatzes für Auslagerung an. Kennzeichen ist durch den SAP-User gesetzt.skzua',
   anzahl_quant                        NUMBER(38,0)     COMMENT 'Bildet den Inhalt des Feldes anzq aus SAP ab. 0 ist kein Bestand, Bei > 0 ist Bestand vorhanden. Aus anzqu',
   komm_bereich                        VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Kommissionierbereich. Zeigt virtuelle Griffzonen an. Aus kober',
   lagerplatz_sortierfeld              VARCHAR(6)       NOT NULL COLLATE 'en-ci' DEFAULT '      ' COMMENT 'Kennzahl für einen Lagerplatz, die bei der Sortierung der Transportauftragspositionen berücksichtigt wird. Aus reihf',
   brand_abschnitt_id                  VARCHAR(2)       COLLATE 'en-ci' COMMENT 'ID des Brandabschnitts aus brand',
   lagerplatz_typ_id                   VARCHAR(2)       NOT NULL COLLATE 'en-ci' DEFAULT '  ' COMMENT 'Lagerplatztyp. Dient zur Einteilung von Lagerplätzen in Gruppen (z.Bsp. R1 = Regal Höhe 1 (105) ) aus lptyp',
   lagerplatz_gewicht_max              NUMBER(18,3)     NOT NULL DEFAULT 0 COMMENT 'Tragfähigkeit des Lagerplatzes (Einheit vermutlich KG) aus lgewi',
   lagerplatz_ebene                    VARCHAR(2)       COLLATE 'en-ci' COMMENT 'Ebene des Lagerplatzes aus zztm_ebene.Enthält die Werte EG oder OG',
   sperrgrund_id                       VARCHAR(1)       COMMENT 'Sperrgrund',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_LAGERPLATZ PRIMARY KEY (mandant_id, wup_id, nb_id, lagernummer_id, lagertyp_id, lagerplatz_id) NOT ENFORCED
)  COMMENT = 'TP408_LVS - Lookuptabelle der Lagerplaetze aus der SAP Tabelle lagp';
