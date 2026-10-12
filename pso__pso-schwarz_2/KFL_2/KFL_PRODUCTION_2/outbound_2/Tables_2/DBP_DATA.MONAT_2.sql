CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.monat_2 (
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Monat_2 eines Kalenderjahres, Format JJJJMM'),
kjmo_vj BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der einem Kalenderjahresmonat entspreche Monat_2 des Kalendervorjahres, Format JJJJMM'),
gjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahresmonat, beginnend bei 1 im März, Format JJJJMM'),
gjmo_vj BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der einem Geschäftsjahresmonat entsprechende Monat_2 des Vorjahres, Format JJJJMM'),
kjqu BIGNUMERIC(38,0) NOT NULL,
gjqu BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahresquartal, Format JJJJQQ'),
kj BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahr, Format JJJJ'),
gj BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahr, Format JJJJ'),
akt_mo BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Monats zum laufenden Monat_2 darstellt. Der aktuelle Monat_2 hat den Wert 0, der vorige Monat_2 -1 und der nächste Monat_2 den Wert 1'),
akt_mo_komplett BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Monats zum letzten abgeschlossenen Monat_2 darstellt. Der aktuelle Monat_2 hat den Wert 1, der vorige Monat_2 0 und der nächste Monat_2  den Wert 2'),
akt_gjqu BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Geschäftjahresquartals  zum laufenden GJQuartal darstellt. Das aktuelle GJQuartal  hat den Wert 0, das vorige GJQuartal -1 und das nächste GJQuartal den Wert 1'),
akt_gjqu_komplett BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines GeschäftjahresQuartals  zum letzten abgeschlossenen GJQuartal  darstellt. Das aktuelle GJQuartal  hat den Wert 1, das vorige GJQuartal  0 und das nächste GJQuartal  den Wert 2'),
akt_kjqu BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Kalenderjahresquartals  zum laufenden KJQuartal darstellt. Das aktuelle KJQuartal  hat den Wert 0, das vorige KJQuartal -1 und das nächste KJQuartal den Wert 1'),
akt_kjqu_komplett BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines KalenderahresQuartals  zum letzten abgeschlossenen KJQuartal  darstellt. Das aktuelle KJQuartal  hat den Wert 1, das vorige KJQuartal  0 und das nächste KJQuartal  den Wert 2'),
akt_gj BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Geschäftjahres zum laufenden GJ darstellt. Das aktuelle GJ hat den Wert 0, das vorige GJ -1 und das nächste GJ den Wert 1'),
akt_gj_komplett BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Geschäftjahres zum letzten abgeschlossenen GJ darstellt. Das aktuelle GJ hat den Wert 1, das vorige GJ 0 und das nächste GJ den Wert 2'),
akt_kj BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Kalenderjahres zum laufenden KJ darstellt. Das aktuelle KJ hat den Wert 0, das vorige KJ -1 und das nächste KJ den Wert 1'),
akt_kj_komplett BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Kalenderjahres zum letzten abgeschlossenen KJ darstellt. Das aktuelle KJ hat den Wert 1, das vorige KJ 0 und das nächste KJ den Wert 2'),
mo_gj BIGNUMERIC(38,0) NOT NULL,
mo_kj BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer des Monats (zwischen 1 und 12)'),
min_dat DATE NOT NULL OPTIONS(description='das kleinste Datum des Monats'),
max_dat DATE NOT NULL OPTIONS(description='das grösste Datum des Monats'),
gjhj BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Geschäftsjahres-Halbjahr (Format Jahr Halbjahr Bsp. 201701)'),
td_update TIMESTAMP,
td_insert TIMESTAMP,
kjmo_vvj BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Kalendermonat im Vorvorjahr')
) OPTIONS(description='Enthält Kalenderdaten auf Monatsebene');