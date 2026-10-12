CREATE OR REPLACE TABLE kfl_production_dbp_data.monat_1 (
kjmo INTEGER NOT NULL OPTIONS(description='Monat_1 eines Kalenderjahres, Format JJJJMM'),
kjmo_vj INTEGER NOT NULL
OPTIONS(description='Der einem Kalenderjahresmonat entspreche Monat_1 des Kalendervorjahres, Format JJJJMM'),
gjmo INTEGER NOT NULL OPTIONS(description='Geschäftsjahresmonat, beginnend bei 1 im März, Format JJJJMM'),
gjmo_vj INTEGER NOT NULL
OPTIONS(description='Der einem Geschäftsjahresmonat entsprechende Monat_1 des Vorjahres, Format JJJJMM'),
kjqu INTEGER NOT NULL,
gjqu INTEGER NOT NULL OPTIONS(description='Geschäftsjahresquartal, Format JJJJQQ'),
kj INTEGER NOT NULL OPTIONS(description='Kalenderjahr, Format JJJJ'),
gj INTEGER NOT NULL OPTIONS(description='Geschäftsjahr, Format JJJJ'),
akt_mo INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Monats zum laufenden Monat_1 darstellt. Der aktuelle Monat_1 hat den Wert 0, der vorige Monat_1 -1 und der nächste Monat_1 den Wert 1'),
akt_mo_komplett INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Monats zum letzten abgeschlossenen Monat_1 darstellt. Der aktuelle Monat_1 hat den Wert 1, der vorige Monat_1 0 und der nächste Monat_1  den Wert 2'),
akt_gjqu INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Geschäftjahresquartals  zum laufenden GJQuartal darstellt. Das aktuelle GJQuartal  hat den Wert 0, das vorige GJQuartal -1 und das nächste GJQuartal den Wert 1'),
akt_gjqu_komplett INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines GeschäftjahresQuartals  zum letzten abgeschlossenen GJQuartal  darstellt. Das aktuelle GJQuartal  hat den Wert 1, das vorige GJQuartal  0 und das nächste GJQuartal  den Wert 2'),
akt_kjqu INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Kalenderjahresquartals  zum laufenden KJQuartal darstellt. Das aktuelle KJQuartal  hat den Wert 0, das vorige KJQuartal -1 und das nächste KJQuartal den Wert 1'),
akt_kjqu_komplett INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines KalenderahresQuartals  zum letzten abgeschlossenen KJQuartal  darstellt. Das aktuelle KJQuartal  hat den Wert 1, das vorige KJQuartal  0 und das nächste KJQuartal  den Wert 2'),
akt_gj INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Geschäftjahres zum laufenden GJ darstellt. Das aktuelle GJ hat den Wert 0, das vorige GJ -1 und das nächste GJ den Wert 1'),
akt_gj_komplett INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Geschäftjahres zum letzten abgeschlossenen GJ darstellt. Das aktuelle GJ hat den Wert 1, das vorige GJ 0 und das nächste GJ den Wert 2'),
akt_kj INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Kalenderjahres zum laufenden KJ darstellt. Das aktuelle KJ hat den Wert 0, das vorige KJ -1 und das nächste KJ den Wert 1'),
akt_kj_komplett INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Kalenderjahres zum letzten abgeschlossenen KJ darstellt. Das aktuelle KJ hat den Wert 1, das vorige KJ 0 und das nächste KJ den Wert 2'),
mo_gj INTEGER NOT NULL,
mo_kj INTEGER NOT NULL OPTIONS(description='Nummer des Monats (zwischen 1 und 12)'),
min_dat DATE NOT NULL OPTIONS(description='das kleinste Datum des Monats'),
max_dat DATE NOT NULL OPTIONS(description='das grösste Datum des Monats'),
gjhj INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Geschäftsjahres-Halbjahr (Format Jahr Halbjahr Bsp. 201701)'),
td_update TIMESTAMP,
td_insert TIMESTAMP,
kjmo_vvj INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Kalendermonat im Vorvorjahr')
) OPTIONS(description='Enthält Kalenderdaten auf Monatsebene');