--==============================================================
-- Table: tms_tour
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_tour
   generated from Powerdesigner on Donnerstag, 24. April 2025 10:50:24
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tms_tour (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_tour_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Tours (Tournummer). Eine Tour kann an mehr als einem Datum stattfinden, daher ist die Spalte tms_tour_id allein nicht eindeutig. Aus pltop.tonr'),
dat_tour DATE NOT NULL OPTIONS(description='Tourdatum'),
tms_tour_lfd_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='SKey für die Tabelle tms_tour im Quellsystem. Aus pltop.top_id'),
transportation_unit_id_ext STRING(20) OPTIONS(description='Externe TU-Nummer'),
tms_tourart_id STRING(2) NOT NULL
OPTIONS(description='die Art der Tour, z. B. ob es sich um eine direkte Lieferung zwischen Kunden oder um eine Lieferung zwischen Lager und Kunde/Lager handelt.\'0\' = Kunde-Kunde,\'1\' = Lager-Kunde,\'2\' = Kunde-Lager,\'3\' = Lager-Lager'),
tms_tourtyp_id BIGNUMERIC(38,0)
OPTIONS(description='Die Spalte "tourtyp" dient der detaillierten Kategorisierung von Touren für Reporting und Abrechnung. Je nach Tourart können verschiedene Tourtypen vorkommmen. (105 = "01 - Zutour - keine Abrechnung", 106 = "03 - Internationaler Transport", 201 = "02 - Abholung Lieferant", ...)'),
tms_tourstatus_id BIGNUMERIC(38,0) OPTIONS(description='Tourstatus (Verladen, Abgerechnet,…)'),
tms_tour_bez STRING(30) OPTIONS(description='Name der Tour'),
anz_stopp BIGNUMERIC(38,0) OPTIONS(description='Anzahl der Stopps(Geschäftspartner) auf der Tour'),
anz_stellplatz BIGNUMERIC(38,0) OPTIONS(description='Anzahl Stellplätze pro Tour'),
tms_fahrzeug_id STRING(20) OPTIONS(description='Fahrzeugnummer'),
tms_fahrzeugtyp_id BIGNUMERIC(38,0) OPTIONS(description='Fahrzeugtyp'),
tms_trailer_id STRING(20) OPTIONS(description='Hängernummer'),
tms_trailer_typ_id BIGNUMERIC(38,0) OPTIONS(description='Hängertyp'),
spedition_tms_gp_id STRING(30) OPTIONS(description='ID des tms_gp, welcher hier als Spedition auftrifft'),
spedition_tms_gp_typ_cd STRING(3) OPTIONS(description='Code für den tms_gp-Typ, welcher hier als Spedition auftrifft'),
temperaturgruppe_id STRING(20)
OPTIONS(description='UK (ungekühlt) / TK (tiefgekühlt) / TE (temperiert) / GK (gekühlt) -> wird nur für Kühlinformation genutzt'),
gutschrift_erstellt_fg BIGNUMERIC(38,0) OPTIONS(description='Kennzeichen, ob eine Gutschrift erstellt wurde'),
startlager_tms_gp_id STRING(30) OPTIONS(description='ID des tms_gp, welcher hier als Startlager auftrifft'),
startlager_tms_gp_typ_cd STRING(3) OPTIONS(description='Code für den tms_gp-Typ, welcher hier als Startlager auftrifft'),
ziellager_tms_gp_id STRING(30) OPTIONS(description='ID des tms_gp, welcher hier als Ziellager auftrifft'),
ziellager_tms_gp_typ_cd STRING(3) OPTIONS(description='Code für den tms_gp-Typ, welcher hier als Ziellager auftrifft'),
maut_km BIGNUMERIC(38,0) OPTIONS(description='Mautstrecke in Metern (deutsche Autobahnmaut)'),
leer_km BIGNUMERIC(38,0)
OPTIONS(description='Anzahl der Leerfahrten, die von einem Spediteur durchgeführt wurden. Leerfahrten können aus verschiedenen Gründen notwendig werden, z. B. wenn der Markt an einem abgelegenen Ort liegt oder wenn keine Rückladung für eine beladene Fahrt gefunden werden kann.'),
anz_aenderung BIGNUMERIC(38,0) OPTIONS(description='Anzahl manuellen Änderungen der Tour nach der Optimierung'),
betrag_fixkosten NUMERIC(18,2) OPTIONS(description='Speditionsfixkosten, Rechnung fehlt dann???'),
tms_tour_dispostelle_id BIGNUMERIC(38,0) OPTIONS(description='Dispostelle des Tours'),
tms_tourart_detail_id BIGNUMERIC(38,0)
OPTIONS(description='Genauere Unterteilung als die tms_tourart_id (Kunde-Lager, Lager-Lager,...), die direkt von Wanko kommt. Die Spalte wird im ETL-Prozess über die Tourpositionen angereichert.            1 = Filialbelieferung            2 = Shuttle (zwischen VZ)            3 = Hofverkehr            4 =I ndustrieabholung            5 = Manuelle Tour            6 = Fleischwerktour            7 = Fleischwerk Shuttle'),
tms_tour_richtungsart_id BIGNUMERIC(38,0)
OPTIONS(description='Gibt an, ob es sich bei der Tour um einen Rundlauf oder eine einfache Fahrt handelt. Die Information wird im ETL-Prozess aus den Tourpositionen ermittelt.             1 = OneWay            2 = Rundlauf            3 = Industrieabholung            4 = Sonstige'),
sortiment_temperaturgruppe_id BIGNUMERIC(38,0)
OPTIONS(description='Temperaturgruppe aus den Sortimenten, der mit der Tour verknüpften Aufträge. Die Information wird im ETL-Prozess ermittelt. Inhalt besagt, ob die Tour mit einem Kühlfahrzeug durchgeführt werden muss.            0 = Nicht gesetzt            1 = TK (Tiefgekühlt)            2 = GK (Gekühlt)            3 = TE (Temperiert)            4 = UK (Ungekühlt)            5 = TB (Thermobehälter)'),
tms_tour_strategisch_id BIGNUMERIC(38,0)
OPTIONS(description='Strategische Tournummer (wird beim Ableiten aus dem Feld tms_tour_id der strategischen Tour gefüllt).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, system_id, tms_tour_id, dat_tour) NOT ENFORCED
)
OPTIONS(description='TMS - Die Tabelle enthält die Informationen über Touren im System, einschließlich Tourtyp, Start- und Zielort und Fahrzeuge. Aus der Quelle pltop (WANKO)');