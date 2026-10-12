--==============================================================
-- Table: tag_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tag_1
   generated from Powerdesigner on Mittwoch, 9. August 2023 11:07:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tag_1 (
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_1-TT'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Monat_1 eines Kalenderjahres, Format JJJJMM'),
kjmo_vj BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der einem Kalenderjahresmonat entspreche Monat_1 des Kalendervorjahres, Format JJJJMM'),
kjmo_vvj BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Kalendermonat im Vorvorjahr'),
wtag_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='laufende Nummer des Wochentages, wobei Montag = 1 und Sonntag = 7'),
kjwo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahreswoche, Format JJJJWW'),
kjwo_vj BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die der Kalenderjahreswoche entsprechende Woche_1 im Vorjahr, Format JJJJWW'),
kjwo_vvj BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Kalenderwoche im Vorvorjahr'),
gjwo BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Geschäftsjahreswoche. Kann zwischen 1 und 53 sein, 1 beginnt zum Geschäftsjahr. Format JJJJWW'),
gjwo_vj BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Geschäftsjahrewoche entsprechende Woche_1 im Vorjahr, Format JJJJWW'),
wo_dat_von DATE NOT NULL OPTIONS(description='Datum des ersten Tages der Woche_1 im Format JJJJ-MM_1-TT'),
wo_dat_bis DATE NOT NULL OPTIONS(description='Datum des letzten Tages der Woche_1 im Format JJJJ-MM_1-TT'),
gjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahresmonat, beginnend bei 1 im März, Format JJJJMM'),
gjmo_vj BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der einem Geschäftsjahresmonat entsprechende Monat_1 des Vorjahres, Format JJJJMM'),
kjqu BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahresquartal, Format JJJJQQ'),
gjqu BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahresquartal, Format JJJJQQ'),
kj BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahr, Format JJJJ'),
gj BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahr, Format JJJJ'),
kjtag_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Laufende Nummer des Tages im Kalenderjahr, von 1 bis 365 bzw. 366'),
gjtag_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Laufende Nummer des Tages im Geschäftsjahr, von 1 bis 365 bzw. 366'),
kjwo_kl BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kaufland - Kalenderjahreswoche. Beginnt am 01.01. eines Jahres und endet am 31.12. unabhängig vom Wochentag. Die erste und die letzte Kalenderjahreswoche enthält so in der Regel weniger als sieben Tage. Format JJJJWW'),
kjwo_kl_dat_von DATE NOT NULL
OPTIONS(description='Datum des Beginns einer Kaufland Kalenderjahreswoche. Format JJJJ-MM_1-TT'),
kjwo_kl_dat_bis DATE NOT NULL
OPTIONS(description='Datum des Endes einer Kaufland Kalenderjahreswoche. Format JJJJ-MM_1-TT'),
gjwo_kl BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kaufland - Geschäftsjahreswoche. Beginnt am 01.03. eines Jahres und endet letzten Februartag unabhängig vom Wochentag. Die erste und die letzte Geschäftsjahreswoche enthält so in der Regel weniger als sieben Tage. Format JJJJWW'),
gjwo_kl_dat_von DATE NOT NULL
OPTIONS(description='Datum des Beginns einer Kaufland Geschäftsjahreswoche. Format JJJJ-MM_1-TT'),
gjwo_kl_dat_bis DATE NOT NULL
OPTIONS(description='Datum des Endes einer Kaufland Geschäftsjahreswoche. Format JJJJ-MM_1-TT'),
dat_vj DATE NOT NULL
OPTIONS(description='Dem Tagesdatum entsprechendes Wochentagsdatum im Vorjahr. Die Berechnung geht z.B. auf den gleichen Dienstag 52 Wochen bzw. 364 Tage zurück.'),
dat_vvj DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL
OPTIONS(description='Dem Tagesdatum entsprechendes Wochentagsdatum im Vorvorjahr. Die Berechnung geht z.B. auf den gleichen Dienstag 104 Wochen bzw. 728 Tage zurück.'),
akt_tag BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Tages zum laufenden Tag_1 darstellt. Der aktuelle Tag_1 hat den Wert 0, der vorige Tag_1 -1 und der nächste Tag_1 den Wert 1'),
akt_mo BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Monats zum laufenden Monat_1 darstellt. Der aktuelle Monat_1 hat den Wert 0, der vorige Monat_1 -1 und der nächste Monat_1 den Wert 1'),
akt_mo_komplett BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Monats zum letzten abgeschlossenen Monat_1 darstellt. Der aktuelle Monat_1 hat den Wert 1, der vorige Monat_1 0 und der nächste Monat_1  den Wert 2'),
akt_wo BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand einer Woche_1 zur laufenden Woche_1 darstellt. Die aktuelle Woche_1 hat den Wert 0, die vorige Woche_1 -1 und die nächste Woche_1 den Wert 1'),
akt_wo_komplett BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand einer Woche_1 zur letzten abgeschlossenen Woche_1 darstellt. Die aktuelle Woche_1 hat den Wert 1, die vorige Woche_1 0 und die nächste Woche_1  den Wert 2'),
akt_gjwo_kl BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand einer Geschäftjahreswoche KL  zur laufenden GJWoche KL darstellt. Die aktuelle GJWoche KL  hat den Wert 0, die vorige GJwoche KL -1 und die nächste GJWoche KL den Wert 1'),
akt_gjwo_kl_komplett BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand einer Geschäftjahreswoche KL  zur laufenden abgeschlossenen GJWoche KL darstellt. Die aktuelle GJWoche KL  hat den Wert 1, die vorige GJwoche KL 0 und die nächste GJWoche KL den Wert 2'),
akt_kjwo_kl BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand einer  Kalenderjahreswoche Kaufland zur aktuellen kjwo_kl anzeigt. Die aktuelle Kjwo_kl hat den Wert 0, die vorige Kjwo_kl -1 und die nächste Kjwo_kl den Wert 1'),
akt_kjwo_kl_komplett BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand einer  Kalenderjahreswoche Kaufland zur letzten abgeschlossenen kjwo_kl anzeigt. Die aktuelle Kjwo_kl hat den Wert 1, die vorige Kjwo_kl 0 und die nächste Kjwo_kl den Wert 2'),
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
mo_gj BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Laufender Monat_1 im Geschäftsjahr. Wert zwischen 1 und 12, wobei März = 1 und Februar = 12'),
mo_kj BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Laufender Monat_1 im Kalenderjahr. Wert zwischen 1 und 12, wobei Januar = 1 und Dezember = 12'),
pjwo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Produktionswoche, geht von Samstag bis Freitag'),
gjhj BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Geschäftsjahres-Halbjahr (Format Jahr Halbjahr Bsp. 201701)'),
akt_gjhj BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Geschäftjahres-Halbjahr  zum laufenden GJ-Halbjahr darstellt. Das aktuelle GJ-Halbjahr  hat den Wert 0, das vorige GJ-Halbjahr -1 und das nächste GJ-Halbjahr den Wert 1'),
akt_gjhj_komplett BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Geschäftjahres-Halbjahr  zum letzten abgeschlossenen GJ-Halbjahr darstellt. Das aktuelle GJ-Halbjahr  hat den Wert 0, das vorige GJ-Halbjahr -1 und das nächste GJ-Halbjahr den Wert 1'),
dat_vj_kt DATE
OPTIONS(description='Vorjahresdatum auf Kalendertagesebene (KT). Hat das gleiche Datum im Vorjahr, z.B. wenn DAT =\'2020-01-01\' dann DAT_VJ_KT =\'2019-01-01\'. Ist beim Schalttag leer, z.B.: DAT =\'2020-02-29\' dann DAT_VJ_KT = null. (Im Gegensatz dazu sind DAT_VJ und DAT_VVJ auf Wochentagesebene, also wenn das betrachtete Datum ein Dienstag ist, dann beinhalten DAT_VJ das Datum für den Dienstag 52 Wochen oder 364 Tage zurück.)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (dat) NOT ENFORCED
) OPTIONS(description='TP1-MIS - Enthält Kalenderdaten auf Tagesebene');