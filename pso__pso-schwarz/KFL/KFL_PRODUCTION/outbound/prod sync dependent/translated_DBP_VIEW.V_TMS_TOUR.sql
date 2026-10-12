CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tms_tour (mandant_id OPTIONS(description='Mandant im DWH'), system_id
OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_tour_id
OPTIONS(description='ID des Tours (Tournummer). Eine Tour kann an mehr als einem Datum stattfinden, daher ist die Spalte tms_tour_id allein nicht eindeutig. Aus pltop.tonr'),
dat_tour OPTIONS(description='Tourdatum'), tms_tour_lfd_nr
OPTIONS(description='SKey für die Tabelle tms_tour im Quellsystem. Aus pltop.top_id'), transportation_unit_id_ext
OPTIONS(description='Externe TU-Nummer'), tms_tourart_id
OPTIONS(description='die Art der Tour, z. B. ob es sich um eine direkte Lieferung zwischen Kunden oder um eine Lieferung zwischen Lager und Kunde/Lager handelt.\'0\' = Kunde-Kunde,\'1\' = Lager-Kunde,\'2\' = Kunde-Lager,\'3\' = Lager-Lager'),
tms_tourtyp_id
OPTIONS(description='Die Spalte\""tourtyp\"" dient der detaillierten Kategorisierung von Touren für Reporting und Abrechnung. Je nach Tourart können verschiedene Tourtypen vorkommmen. (105 =\""01 - Zutour - keine Abrechnung\"", 106 =\""03 - Internationaler Transport\"", 201 =\""02 - Abholung Lieferant\"", ...)'),
tms_tourstatus_id OPTIONS(description='Tourstatus (Verladen, Abgerechnet,…)'), tms_tour_bez
OPTIONS(description='Name der Tour'), anz_stopp OPTIONS(description='Anzahl der Stopps(Geschäftspartner) auf der Tour'),
anz_stellplatz OPTIONS(description='Anzahl Stellplätze pro Tour'), tms_fahrzeug_id OPTIONS(description='Fahrzeugnummer'),
tms_fahrzeugtyp_id OPTIONS(description='Fahrzeugtyp'), tms_trailer_id OPTIONS(description='Hängernummer'),
tms_trailer_typ_id OPTIONS(description='Hängertyp'), spedition_tms_gp_id
OPTIONS(description='ID des tms_gp, welcher hier als Spedition auftrifft'), spedition_tms_gp_typ_cd
OPTIONS(description='Code für den tms_gp-Typ, welcher hier als Spedition auftrifft'), temperaturgruppe_id
OPTIONS(description='UK (ungekühlt) / TK (tiefgekühlt) / TE (temperiert) / GK (gekühlt) -> wird nur für Kühlinformation genutzt'),
gutschrift_erstellt_fg OPTIONS(description='Kennzeichen, ob eine Gutschrift erstellt wurde'), startlager_tms_gp_id
OPTIONS(description='ID des tms_gp, welcher hier als Startlager auftrifft'), startlager_tms_gp_typ_cd
OPTIONS(description='Code für den tms_gp-Typ, welcher hier als Startlager auftrifft'), ziellager_tms_gp_id
OPTIONS(description='ID des tms_gp, welcher hier als Ziellager auftrifft'), ziellager_tms_gp_typ_cd
OPTIONS(description='Code für den tms_gp-Typ, welcher hier als Ziellager auftrifft'), maut_km
OPTIONS(description='Mautstrecke in Metern (deutsche Autobahnmaut)'), leer_km
OPTIONS(description='Anzahl der Leerfahrten, die von einem Spediteur durchgeführt wurden. Leerfahrten können aus verschiedenen Gründen notwendig werden, z. B. wenn der Markt an einem abgelegenen Ort liegt oder wenn keine Rückladung für eine beladene Fahrt gefunden werden kann.'),
anz_aenderung OPTIONS(description='Anzahl manuellen Änderungen der Tour nach der Optimierung'), betrag_fixkosten
OPTIONS(description='Speditionsfixkosten, Rechnung fehlt dann???'), tms_tour_dispostelle_id
OPTIONS(description='Dispostelle des Tours'), tms_tourart_detail_id
OPTIONS(description='Genauere Unterteilung als die tms_tourart_id (Kunde-Lager, Lager-Lager,...), die direkt von Wanko kommt. Die Spalte wird im ETL-Prozess über die Tourpositionen angereichert.\n1 = Filialbelieferung\n2 = Shuttle (zwischen VZ)\n3 = Hofverkehr\n4 =I ndustrieabholung\n5 = Manuelle Tour\n6 = Fleischwerktour\n7 = Fleischwerk Shuttle'),
tms_tour_richtungsart_id
OPTIONS(description='Gibt an, ob es sich bei der Tour um einen Rundlauf oder eine einfache Fahrt handelt. Die Information wird im ETL-Prozess aus den Tourpositionen ermittelt.\n1 = OneWay\n2 = Rundlauf\n3 = Industrieabholung\n4 = Sonstige'),
sortiment_temperaturgruppe_id
OPTIONS(description='Temperaturgruppe aus den Sortimenten, der mit der Tour verknüpften Aufträge. Die Information wird im ETL-Prozess ermittelt. Inhalt besagt, ob die Tour mit einem Kühlfahrzeug durchgeführt werden muss.\n0 = Nicht gesetzt\n1 = TK (Tiefgekühlt)\n2 = GK (Gekühlt)\n3 = TE (Temperiert)\n4 = UK (Ungekühlt)\n5 = TB (Thermobehälter)'),
tms_tour_strategisch_id
OPTIONS(description='Strategische Tournummer (wird beim Ableiten aus dem Feld tms_tour_id der strategischen Tour gefüllt).'),
antriebsart_id
OPTIONS(description='ID für die generelle Antriebstechnologie des Fahrzeugs auf dieser Tour. Antriebsart: 1 = Diesel, 2 = Elektro, 3 = Gas, 4 = Wasserstoff, 0 = nicht zugeordnet.\nDiese Spalte ist nicht identisch mit der Treibstoffart (tms_treibstoff). Bspw. Ein LKW kann mit HVO100 (Pflanzenöl) oder fossilim Diesel betankt werden (= unterschiedliche Treibstoffe), die Antriebsart bleibt in beiden Fällen 1 (Diesel), da die Motorentechnologie identisch ist.'))
AS SELECT mandant_id,
 system_id,
 tms_tour_id,
 dat_tour,
 tms_tour_lfd_nr,
 transportation_unit_id_ext,
 tms_tourart_id,
 tms_tourtyp_id,
 tms_tourstatus_id,
 tms_tour_bez,
 anz_stopp,
 anz_stellplatz,
 tms_fahrzeug_id,
 tms_fahrzeugtyp_id,
 tms_trailer_id,
 tms_trailer_typ_id,
 spedition_tms_gp_id,
 spedition_tms_gp_typ_cd,
 temperaturgruppe_id,
 gutschrift_erstellt_fg,
 startlager_tms_gp_id,
 startlager_tms_gp_typ_cd,
 ziellager_tms_gp_id,
 ziellager_tms_gp_typ_cd,
 maut_km,
 leer_km,
 anz_aenderung,
 betrag_fixkosten,
 tms_tour_dispostelle_id,
 tms_tourart_detail_id,
 tms_tour_richtungsart_id,
 sortiment_temperaturgruppe_id,
 tms_tour_strategisch_id,
 antriebsart_id
FROM kfl_production_dbp_data.tms_tour;