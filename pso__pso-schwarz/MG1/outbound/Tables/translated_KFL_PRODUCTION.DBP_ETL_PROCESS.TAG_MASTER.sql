CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_ETL_PROCESS.TAG_MASTER (
DAT DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM-TT'),
KJMO INTEGER NOT NULL OPTIONS(description='Monat eines Kalenderjahres, Format JJJJMM'),
KJMO_VJ INTEGER NOT NULL
OPTIONS(description='Der einem Kalenderjahresmonat entspreche Monat des Kalendervorjahres, Format JJJJMM'),
KJMO_VVJ INTEGER NOT NULL OPTIONS(description='Kalendermonat im Vorvorjahr'),
WTAG_ID INTEGER NOT NULL OPTIONS(description='laufende Nummer des Wochentages, wobei Montag = 1 und Sonntag = 7'),
KJWO INTEGER NOT NULL OPTIONS(description='Kalenderjahreswoche, Format JJJJWW'),
KJWO_VJ INTEGER NOT NULL
OPTIONS(description='Die der Kalenderjahreswoche entsprechende Woche im Vorjahr, Format JJJJWW'),
KJWO_VVJ INTEGER NOT NULL OPTIONS(description='Kalenderwoche im Vorvorjahr'),
GJWO INTEGER NOT NULL
OPTIONS(description='Geschäftsjahreswoche. Kann zwischen 1 und 53 sein, 1 beginnt zum Geschäftsjahr. Format JJJJWW'),
GJWO_VJ INTEGER NOT NULL OPTIONS(description='Der Geschäftsjahrewoche entsprechende Woche im Vorjahr, Format JJJJWW'),
WO_DAT_VON DATE NOT NULL OPTIONS(description='Datum des ersten Tages der Woche im Format JJJJ-MM-TT'),
WO_DAT_BIS DATE NOT NULL OPTIONS(description='Datum des letzten Tages der Woche im Format JJJJ-MM-TT'),
GJMO INTEGER NOT NULL OPTIONS(description='Geschäftsjahresmonat, beginnend bei 1 im März, Format JJJJMM'),
GJMO_VJ INTEGER NOT NULL
OPTIONS(description='Der einem Geschäftsjahresmonat entsprechende Monat des Vorjahres, Format JJJJMM'),
KJQU INTEGER NOT NULL OPTIONS(description='Kalenderjahresquartal, Format JJJJQQ'),
GJQU INTEGER NOT NULL OPTIONS(description='Geschäftsjahresquartal, Format JJJJQQ'),
KJ INTEGER NOT NULL OPTIONS(description='Kalenderjahr, Format JJJJ'),
GJ INTEGER NOT NULL OPTIONS(description='Geschäftsjahr, Format JJJJ'),
KJTAG_ID INTEGER NOT NULL OPTIONS(description='Laufende Nummer des Tages im Kalenderjahr, von 1 bis 365 bzw. 366'),
GJTAG_ID INTEGER NOT NULL OPTIONS(description='Laufende Nummer des Tages im Geschäftsjahr, von 1 bis 365 bzw. 366'),
KJWO_KL INTEGER NOT NULL
OPTIONS(description='Kaufland - Kalenderjahreswoche. Beginnt am 01.01. eines Jahres und endet am 31.12. unabhängig vom Wochentag. Die erste und die letzte Kalenderjahreswoche enthält so in der Regel weniger als sieben Tage. Format JJJJWW'),
KJWO_KL_DAT_VON DATE NOT NULL
OPTIONS(description='Datum des Beginns einer Kaufland Kalenderjahreswoche. Format JJJJ-MM-TT'),
KJWO_KL_DAT_BIS DATE NOT NULL
OPTIONS(description='Datum des Endes einer Kaufland Kalenderjahreswoche. Format JJJJ-MM-TT'),
GJWO_KL INTEGER NOT NULL
OPTIONS(description='Kaufland - Geschäftsjahreswoche. Beginnt am 01.03. eines Jahres und endet letzten Februartag unabhängig vom Wochentag. Die erste und die letzte Geschäftsjahreswoche enthält so in der Regel weniger als sieben Tage. Format JJJJWW'),
GJWO_KL_DAT_VON DATE NOT NULL
OPTIONS(description='Datum des Beginns einer Kaufland Geschäftsjahreswoche. Format JJJJ-MM-TT'),
GJWO_KL_DAT_BIS DATE NOT NULL
OPTIONS(description='Datum des Endes einer Kaufland Geschäftsjahreswoche. Format JJJJ-MM-TT'),
DAT_VJ DATE NOT NULL OPTIONS(description='dem Tagesdatum entsprechendes Datum im Vorjahr'),
DAT_VVJ DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL OPTIONS(description='Wochentag im Vorvorjahr'),
AKT_TAG INTEGER NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Tages zum laufenden Tag darstellt. Der aktuelle Tag hat den Wert 0, der vorige Tag -1 und der nächste Tag den Wert 1'),
AKT_MO INTEGER NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Monats zum laufenden Monat darstellt. Der aktuelle Monat hat den Wert 0, der vorige Monat -1 und der nächste Monat den Wert 1'),
AKT_MO_KOMPLETT INTEGER NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Monats zum letzten abgeschlossenen Monat darstellt. Der aktuelle Monat hat den Wert 1, der vorige Monat 0 und der nächste Monat  den Wert 2'),
AKT_WO INTEGER NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand einer Woche zur laufenden Woche darstellt. Die aktuelle Woche hat den Wert 0, die vorige Woche -1 und die nächste Woche den Wert 1'),
AKT_WO_KOMPLETT INTEGER NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand einer Woche zur letzten abgeschlossenen Woche darstellt. Die aktuelle Woche hat den Wert 1, die vorige Woche 0 und die nächste Woche  den Wert 2'),
AKT_GJWO_KL INTEGER NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand einer Geschäftjahreswoche KL  zur laufenden GJWoche KL darstellt. Die aktuelle GJWoche KL  hat den Wert 0, die vorige GJwoche KL -1 und die nächste GJWoche KL den Wert 1'),
AKT_GJWO_KL_KOMPLETT INTEGER NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand einer Geschäftjahreswoche KL  zur laufenden abgeschlossenen GJWoche KL darstellt. Die aktuelle GJWoche KL  hat den Wert 1, die vorige GJwoche KL 0 und die nächste GJWoche KL den Wert 2'),
AKT_KJWO_KL INTEGER NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand einer  Kalenderjahreswoche Kaufland zur aktuellen kjwo_kl anzeigt. Die aktuelle Kjwo_kl hat den Wert 0, die vorige Kjwo_kl -1 und die nächste Kjwo_kl den Wert 1'),
AKT_KJWO_KL_KOMPLETT INTEGER NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand einer  Kalenderjahreswoche Kaufland zur letzten abgeschlossenen kjwo_kl anzeigt. Die aktuelle Kjwo_kl hat den Wert 1, die vorige Kjwo_kl 0 und die nächste Kjwo_kl den Wert 2'),
AKT_GJQU INTEGER NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Geschäftjahresquartals  zum laufenden GJQuartal darstellt. Das aktuelle GJQuartal  hat den Wert 0, das vorige GJQuartal -1 und das nächste GJQuartal den Wert 1'),
AKT_GJQU_KOMPLETT INTEGER NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines GeschäftjahresQuartals  zum letzten abgeschlossenen GJQuartal  darstellt. Das aktuelle GJQuartal  hat den Wert 1, das vorige GJQuartal  0 und das nächste GJQuartal  den Wert 2'),
AKT_KJQU INTEGER NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Kalenderjahresquartals  zum laufenden KJQuartal darstellt. Das aktuelle KJQuartal  hat den Wert 0, das vorige KJQuartal -1 und das nächste KJQuartal den Wert 1'),
AKT_KJQU_KOMPLETT INTEGER NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines KalenderahresQuartals  zum letzten abgeschlossenen KJQuartal  darstellt. Das aktuelle KJQuartal  hat den Wert 1, das vorige KJQuartal  0 und das nächste KJQuartal  den Wert 2'),
AKT_GJ INTEGER NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Geschäftjahres zum laufenden GJ darstellt. Das aktuelle GJ hat den Wert 0, das vorige GJ -1 und das nächste GJ den Wert 1'),
AKT_GJ_KOMPLETT INTEGER NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Geschäftjahres zum letzten abgeschlossenen GJ darstellt. Das aktuelle GJ hat den Wert 1, das vorige GJ 0 und das nächste GJ den Wert 2'),
AKT_KJ INTEGER NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Kalenderjahres zum laufenden KJ darstellt. Das aktuelle KJ hat den Wert 0, das vorige KJ -1 und das nächste KJ den Wert 1'),
AKT_KJ_KOMPLETT INTEGER NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Kalenderjahres zum letzten abgeschlossenen KJ darstellt. Das aktuelle KJ hat den Wert 1, das vorige KJ 0 und das nächste KJ den Wert 2'),
MO_GJ INTEGER NOT NULL
OPTIONS(description='Laufender Monat im Geschäftsjahr. Wert zwischen 1 und 12, wobei März = 1 und Februar = 12'),
MO_KJ INTEGER NOT NULL
OPTIONS(description='Laufender Monat im Kalenderjahr. Wert zwischen 1 und 12, wobei Januar = 1 und Dezember = 12'),
PJWO INTEGER NOT NULL OPTIONS(description='Produktionswoche, geht von Samstag bis Freitag'),
GJHJ INTEGER NOT NULL OPTIONS(description='Geschäftsjahres-Halbjahr (Format Jahr Halbjahr Bsp. 201701)'),
AKT_GJHJ INTEGER NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Geschäftjahres-Halbjahr  zum laufenden GJ-Halbjahr darstellt. Das aktuelle GJ-Halbjahr  hat den Wert 0, das vorige GJ-Halbjahr -1 und das nächste GJ-Halbjahr den Wert 1'),
AKT_GJHJ_KOMPLETT INTEGER NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Geschäftjahres-Halbjahr  zum letzten abgeschlossenen GJ-Halbjahr darstellt. Das aktuelle GJ-Halbjahr  hat den Wert 0, das vorige GJ-Halbjahr -1 und das nächste GJ-Halbjahr den Wert 1'),
DAT_VJ_KT DATE
OPTIONS(description='Vorjahresdatum auf Kalendertagesebene (KT). Hat das gleiche Datum im Vorjahr, z.B. wenn DAT = 2020-01-01 dann DAT_VJ_KT = 2019-01-01. Ist beim Schalttag leer, z.B.: DAT = 2020-02-29 dann DAT_VJ_KT = null. (Im Gegensatz dazu sind DAT_VJ und DAT_VVJ auf Wochentagesebene, also wenn das betrachtete Datum ein Dienstag ist, dann beinhalten DAT_VJ das Datum für den Dienstag 52 Wochen oder 364 Tage zurück.)'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (DAT) NOT ENFORCED
) OPTIONS(description='Zeit - Ladehilfstabelle.Enthält Kalenderdaten auf Tagesebene');