CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.MONAT (
KJMO INTEGER NOT NULL OPTIONS(description='Monat eines Kalenderjahres, Format JJJJMM'),
KJMO_VJ INTEGER NOT NULL
OPTIONS(description='Der einem Kalenderjahresmonat entspreche Monat des Kalendervorjahres, Format JJJJMM'),
GJMO INTEGER NOT NULL OPTIONS(description='Geschäftsjahresmonat, beginnend bei 1 im März, Format JJJJMM'),
GJMO_VJ INTEGER NOT NULL
OPTIONS(description='Der einem Geschäftsjahresmonat entsprechende Monat des Vorjahres, Format JJJJMM'),
KJQU INTEGER NOT NULL,
GJQU INTEGER NOT NULL OPTIONS(description='Geschäftsjahresquartal, Format JJJJQQ'),
KJ INTEGER NOT NULL OPTIONS(description='Kalenderjahr, Format JJJJ'),
GJ INTEGER NOT NULL OPTIONS(description='Geschäftsjahr, Format JJJJ'),
AKT_MO INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Monats zum laufenden Monat darstellt. Der aktuelle Monat hat den Wert 0, der vorige Monat -1 und der nächste Monat den Wert 1'),
AKT_MO_KOMPLETT INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Monats zum letzten abgeschlossenen Monat darstellt. Der aktuelle Monat hat den Wert 1, der vorige Monat 0 und der nächste Monat  den Wert 2'),
AKT_GJQU INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Geschäftjahresquartals  zum laufenden GJQuartal darstellt. Das aktuelle GJQuartal  hat den Wert 0, das vorige GJQuartal -1 und das nächste GJQuartal den Wert 1'),
AKT_GJQU_KOMPLETT INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines GeschäftjahresQuartals  zum letzten abgeschlossenen GJQuartal  darstellt. Das aktuelle GJQuartal  hat den Wert 1, das vorige GJQuartal  0 und das nächste GJQuartal  den Wert 2'),
AKT_KJQU INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Kalenderjahresquartals  zum laufenden KJQuartal darstellt. Das aktuelle KJQuartal  hat den Wert 0, das vorige KJQuartal -1 und das nächste KJQuartal den Wert 1'),
AKT_KJQU_KOMPLETT INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines KalenderahresQuartals  zum letzten abgeschlossenen KJQuartal  darstellt. Das aktuelle KJQuartal  hat den Wert 1, das vorige KJQuartal  0 und das nächste KJQuartal  den Wert 2'),
AKT_GJ INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Geschäftjahres zum laufenden GJ darstellt. Das aktuelle GJ hat den Wert 0, das vorige GJ -1 und das nächste GJ den Wert 1'),
AKT_GJ_KOMPLETT INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Geschäftjahres zum letzten abgeschlossenen GJ darstellt. Das aktuelle GJ hat den Wert 1, das vorige GJ 0 und das nächste GJ den Wert 2'),
AKT_KJ INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Kalenderjahres zum laufenden KJ darstellt. Das aktuelle KJ hat den Wert 0, das vorige KJ -1 und das nächste KJ den Wert 1'),
AKT_KJ_KOMPLETT INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Kalenderjahres zum letzten abgeschlossenen KJ darstellt. Das aktuelle KJ hat den Wert 1, das vorige KJ 0 und das nächste KJ den Wert 2'),
MO_GJ INTEGER NOT NULL,
MO_KJ INTEGER NOT NULL OPTIONS(description='Nummer des Monats (zwischen 1 und 12)'),
MIN_DAT DATE NOT NULL OPTIONS(description='das kleinste Datum des Monats'),
MAX_DAT DATE NOT NULL OPTIONS(description='das grösste Datum des Monats'),
GJHJ INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Geschäftsjahres-Halbjahr (Format Jahr Halbjahr Bsp. 201701)'),
TD_UPDATE TIMESTAMP,
TD_INSERT TIMESTAMP,
KJMO_VVJ INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Kalendermonat im Vorvorjahr')
) OPTIONS(description='Enthält Kalenderdaten auf Monatsebene');