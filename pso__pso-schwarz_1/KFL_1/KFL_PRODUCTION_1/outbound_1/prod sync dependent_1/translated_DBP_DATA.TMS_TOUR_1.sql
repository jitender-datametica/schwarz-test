CREATE OR REPLACE TABLE kfl_production_dbp_data.tms_tour_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
system_id INTEGER NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_tour_id INTEGER NOT NULL
OPTIONS(description='ID des Tours (Tournummer). Eine_1 Tour_1 kann an mehr als einem Datum stattfinden, daher ist die Spalte tms_tour_id allein nicht eindeutig. Aus pltop.tonr'),
dat_tour DATE NOT NULL OPTIONS(description='Tourdatum'),
tms_tour_lfd_nr INTEGER NOT NULL OPTIONS(description='SKey für die Tabelle tms_tour_1 im Quellsystem. Aus pltop.top_id'),
transportation_unit_id_ext STRING(20) OPTIONS(description='Externe TU-Nummer'),
tms_tourart_id STRING(2) NOT NULL
OPTIONS(description='die Art_1 der Tour_1, z. B. ob es sich um eine_1 direkte Lieferung zwischen Kunden oder um eine_1 Lieferung zwischen Lager und Kunde/Lager handelt.\'0\' = Kunde-Kunde,\'1\' = Lager-Kunde,\'2\' = Kunde-Lager,\'3\' = Lager-Lager'),
tms_tourtyp_id INTEGER
OPTIONS(description='Die Spalte\""tourtyp\"" dient der detaillierten Kategorisierung von Touren für Reporting und Abrechnung. Je nach Tourart können verschiedene Tourtypen vorkommmen. (105 =\""01 - Zutour - keine Abrechnung\"", 106 =\""03 - Internationaler Transport\"", 201 =\""02 - Abholung Lieferant\"", ...)'),
tms_tourstatus_id INTEGER OPTIONS(description='Tourstatus (Verladen, Abgerechnet,…)'),
tms_tour_bez STRING(30) OPTIONS(description='Name der Tour_1'),
anz_stopp INTEGER OPTIONS(description='Anzahl der Stopps(Geschäftspartner) auf der Tour_1'),
anz_stellplatz INTEGER OPTIONS(description='Anzahl Stellplätze pro Tour_1'),
tms_fahrzeug_id STRING(20) OPTIONS(description='Fahrzeugnummer'),
tms_fahrzeugtyp_id INTEGER OPTIONS(description='Fahrzeugtyp'),
tms_trailer_id STRING(20) OPTIONS(description='Hängernummer'),
tms_trailer_typ_id INTEGER OPTIONS(description='Hängertyp'),
spedition_tms_gp_id STRING(30) OPTIONS(description='ID des tms_gp_1, welcher hier als Spedition auftrifft'),
spedition_tms_gp_typ_cd STRING(3) OPTIONS(description='Code für den tms_gp_1-Typ, welcher hier als Spedition auftrifft'),
temperaturgruppe_id STRING(20)
OPTIONS(description='UK (ungekühlt) / TK (tiefgekühlt) / TE (temperiert) / GK (gekühlt) -> wird nur für Kühlinformation genutzt'),
gutschrift_erstellt_fg INTEGER OPTIONS(description='Kennzeichen, ob eine_1 Gutschrift erstellt wurde'),
startlager_tms_gp_id STRING(30) OPTIONS(description='ID des tms_gp_1, welcher hier als Startlager auftrifft'),
startlager_tms_gp_typ_cd STRING(3) OPTIONS(description='Code für den tms_gp_1-Typ, welcher hier als Startlager auftrifft'),
ziellager_tms_gp_id STRING(30) OPTIONS(description='ID des tms_gp_1, welcher hier als Ziellager auftrifft'),
ziellager_tms_gp_typ_cd STRING(3) OPTIONS(description='Code für den tms_gp_1-Typ, welcher hier als Ziellager auftrifft'),
maut_km INTEGER OPTIONS(description='Mautstrecke in Metern (deutsche Autobahnmaut)'),
leer_km INTEGER
OPTIONS(description='Anzahl der Leerfahrten, die von einem Spediteur durchgeführt wurden. Leerfahrten können aus verschiedenen Gründen notwendig werden, z. B. wenn der Markt an einem abgelegenen Ort liegt oder wenn keine Rückladung für eine_1 beladene Fahrt gefunden werden kann.'),
anz_aenderung INTEGER OPTIONS(description='Anzahl manuellen Änderungen der Tour_1 nach der Optimierung'),
betrag_fixkosten NUMERIC(29,2) OPTIONS(description='Speditionsfixkosten, Rechnung fehlt dann???'),
tms_tour_dispostelle_id INTEGER OPTIONS(description='Dispostelle des Tours'),
tms_tourart_detail_id INTEGER
OPTIONS(description='Genauere Unterteilung als die tms_tourart_id (Kunde-Lager, Lager-Lager,...), die direkt von Wanko kommt. Die Spalte wird im ETL-Prozess über die Tourpositionen angereichert.\n            1 = Filialbelieferung\n            2 = Shuttle (zwischen VZ)\n            3 = Hofverkehr\n            4 =I ndustrieabholung\n            5 = Manuelle Tour_1\n            6 = Fleischwerktour\n            7 = Fleischwerk Shuttle'),
tms_tour_richtungsart_id INTEGER
OPTIONS(description='Gibt an, ob es sich bei der Tour_1 um einen Rundlauf oder eine_1 einfache Fahrt handelt. Die Information wird im ETL-Prozess aus den Tourpositionen ermittelt.\n            1 = OneWay\n            2 = Rundlauf\n            3 = Industrieabholung\n            4 = Sonstige'),
sortiment_temperaturgruppe_id INTEGER
OPTIONS(description='Temperaturgruppe aus den Sortimenten, der mit der Tour_1 verknüpften Aufträge. Die Information wird im ETL-Prozess ermittelt. Inhalt besagt, ob die Tour_1 mit einem Kühlfahrzeug durchgeführt werden muss.\n            0 = Nicht gesetzt\n            1 = TK (Tiefgekühlt)\n            2 = GK (Gekühlt)\n            3 = TE (Temperiert)\n            4 = UK (Ungekühlt)\n            5 = TB (Thermobehälter)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
tms_tour_strategisch_id INTEGER
OPTIONS(description='Strategische Tournummer (wird beim Ableiten aus dem Feld tms_tour_id der strategischen Tour_1 gefüllt).'),
antriebsart_id INTEGER
OPTIONS(description='ID für die generelle Antriebstechnologie des Fahrzeugs auf dieser Tour. Antriebsart: 1 = Diesel, 2 = Elektro, 3 = Gas, 4 = Wasserstoff, 0 = nicht zugeordnet.\n            Diese Spalte ist nicht identisch mit der Treibstoffart (tms_treibstoff). Bspw. Ein LKW kann mit HVO100 (Pflanzenöl) oder fossilim Diesel betankt werden (= unterschiedliche Treibstoffe), die Antriebsart bleibt in beiden Fällen 1 (Diesel), da die Motorentechnologie identisch ist.'),
PRIMARY KEY (mandant_id, system_id, tms_tour_id, dat_tour) NOT ENFORCED
)
OPTIONS(description='TMS - Die Tabelle enthält die Informationen über Touren im System, einschließlich Tourtyp, Start- und Zielort und Fahrzeuge. Aus der Quelle pltop (WANKO)');