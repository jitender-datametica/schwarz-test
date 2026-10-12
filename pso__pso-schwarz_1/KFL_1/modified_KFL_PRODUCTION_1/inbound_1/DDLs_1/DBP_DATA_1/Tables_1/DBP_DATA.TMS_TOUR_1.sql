--==============================================================
-- Table: tms_tour_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_tour_1
   generated from Powerdesigner on Donnerstag, 24. April 2025 10:50:24
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TMS_TOUR_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_tour_id                         INTEGER     NOT NULL COMMENT 'ID des Tours (Tournummer). Eine_1 Tour_1 kann an mehr als einem Datum stattfinden, daher ist die Spalte tms_tour_id allein nicht eindeutig. Aus pltop.tonr',
   dat_tour                            DATE             NOT NULL COMMENT 'Tourdatum',
   tms_tour_lfd_nr                     INTEGER     NOT NULL COMMENT 'SKey für die Tabelle tms_tour_1 im Quellsystem. Aus pltop.top_id',
   transportation_unit_id_ext          VARCHAR(20)      COMMENT 'Externe TU-Nummer',
   tms_tourart_id                      VARCHAR(2)       NOT NULL COMMENT 'die Art_1 der Tour_1, z. B. ob es sich um eine_1 direkte Lieferung zwischen Kunden oder um eine_1 Lieferung zwischen Lager und Kunde/Lager handelt. ''0'' = Kunde-Kunde, ''1'' = Lager-Kunde, ''2'' = Kunde-Lager, ''3'' = Lager-Lager',
   tms_tourtyp_id                      INTEGER     COMMENT 'Die Spalte "tourtyp" dient der detaillierten Kategorisierung von Touren für Reporting und Abrechnung. Je nach Tourart können verschiedene Tourtypen vorkommmen. (105 = "01 - Zutour - keine Abrechnung", 106 = "03 - Internationaler Transport", 201 = "02 - Abholung Lieferant", ...)',
   tms_tourstatus_id                   INTEGER     COMMENT 'Tourstatus (Verladen, Abgerechnet,…)',
   tms_tour_bez                        VARCHAR(30)      COMMENT 'Name der Tour_1',
   anz_stopp                           INTEGER     COMMENT 'Anzahl der Stopps(Geschäftspartner) auf der Tour_1',
   anz_stellplatz                      INTEGER     COMMENT 'Anzahl Stellplätze pro Tour_1',
   tms_fahrzeug_id                     VARCHAR(20)      COMMENT 'Fahrzeugnummer',
   tms_fahrzeugtyp_id                  INTEGER     COMMENT 'Fahrzeugtyp',
   tms_trailer_id                      VARCHAR(20)      COMMENT 'Hängernummer',
   tms_trailer_typ_id                  INTEGER     COMMENT 'Hängertyp',
   spedition_tms_gp_id                 VARCHAR(30)      COMMENT 'ID des tms_gp_1, welcher hier als Spedition auftrifft',
   spedition_tms_gp_typ_cd             VARCHAR(3)       COMMENT 'Code für den tms_gp_1-Typ, welcher hier als Spedition auftrifft',
   temperaturgruppe_id                 VARCHAR(20)      COMMENT 'UK (ungekühlt) / TK (tiefgekühlt) / TE (temperiert) / GK (gekühlt) -> wird nur für Kühlinformation genutzt',
   gutschrift_erstellt_fg              INTEGER     COMMENT 'Kennzeichen, ob eine_1 Gutschrift erstellt wurde',
   startlager_tms_gp_id                VARCHAR(30)      COMMENT 'ID des tms_gp_1, welcher hier als Startlager auftrifft',
   startlager_tms_gp_typ_cd            VARCHAR(3)       COMMENT 'Code für den tms_gp_1-Typ, welcher hier als Startlager auftrifft',
   ziellager_tms_gp_id                 VARCHAR(30)      COMMENT 'ID des tms_gp_1, welcher hier als Ziellager auftrifft',
   ziellager_tms_gp_typ_cd             VARCHAR(3)       COMMENT 'Code für den tms_gp_1-Typ, welcher hier als Ziellager auftrifft',
   maut_km                             INTEGER     COMMENT 'Mautstrecke in Metern (deutsche Autobahnmaut)',
   leer_km                             INTEGER     COMMENT 'Anzahl der Leerfahrten, die von einem Spediteur durchgeführt wurden. Leerfahrten können aus verschiedenen Gründen notwendig werden, z. B. wenn der Markt an einem abgelegenen Ort liegt oder wenn keine Rückladung für eine_1 beladene Fahrt gefunden werden kann.',
   anz_aenderung                       INTEGER     COMMENT 'Anzahl manuellen Änderungen der Tour_1 nach der Optimierung',
   betrag_fixkosten                    NUMBER(29,2)     COMMENT 'Speditionsfixkosten, Rechnung fehlt dann???',
   tms_tour_dispostelle_id             INTEGER     COMMENT 'Dispostelle des Tours',
   tms_tourart_detail_id               INTEGER     COMMENT 'Genauere Unterteilung als die tms_tourart_id (Kunde-Lager, Lager-Lager,...), die direkt von Wanko kommt. Die Spalte wird im ETL-Prozess über die Tourpositionen angereichert.
            1 = Filialbelieferung
            2 = Shuttle (zwischen VZ)
            3 = Hofverkehr
            4 =I ndustrieabholung
            5 = Manuelle Tour_1
            6 = Fleischwerktour
            7 = Fleischwerk Shuttle',
   tms_tour_richtungsart_id            INTEGER     COMMENT 'Gibt an, ob es sich bei der Tour_1 um einen Rundlauf oder eine_1 einfache Fahrt handelt. Die Information wird im ETL-Prozess aus den Tourpositionen ermittelt. 
            1 = OneWay
            2 = Rundlauf
            3 = Industrieabholung
            4 = Sonstige',
   sortiment_temperaturgruppe_id       INTEGER     COMMENT 'Temperaturgruppe aus den Sortimenten, der mit der Tour_1 verknüpften Aufträge. Die Information wird im ETL-Prozess ermittelt. Inhalt besagt, ob die Tour_1 mit einem Kühlfahrzeug durchgeführt werden muss.
            0 = Nicht gesetzt
            1 = TK (Tiefgekühlt)
            2 = GK (Gekühlt)
            3 = TE (Temperiert)
            4 = UK (Ungekühlt)
            5 = TB (Thermobehälter)',
   tms_tour_strategisch_id             INTEGER     COMMENT 'Strategische Tournummer (wird beim Ableiten aus dem Feld tms_tour_id der strategischen Tour_1 gefüllt).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TMS_TOUR PRIMARY KEY (mandant_id, system_id, tms_tour_id, dat_tour) NOT ENFORCED
)  COMMENT = 'TMS - Die Tabelle enthält die Informationen über Touren im System, einschließlich Tourtyp, Start- und Zielort und Fahrzeuge. Aus der Quelle pltop (WANKO)';
