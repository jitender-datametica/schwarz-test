CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.woche_2 (
gjwo BIGNUMERIC(38,0)
OPTIONS(description='Geschäftsjahreswoche. Kann zwischen 1 und 53 sein, 1 beginnt zum Geschäftsjahr. Format JJJJWW'),
gjwo_vj BIGNUMERIC(38,0) OPTIONS(description='Der Geschäftsjahrewoche entsprechende Woche_2 im Vorjahr, Format JJJJWW'),
kjwo BIGNUMERIC(38,0) OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
kjwo_vj BIGNUMERIC(38,0) OPTIONS(description='Der Kalenderjahrwoche entsprechende Woche_2 im Vorjahr, Format JJJJWW'),
wo_dat_von DATE,
wo_dat_bis DATE,
akt_wo BIGNUMERIC(38,0)
OPTIONS(description='Zahlenfolge, die den Abstand einer Woche_2 zur laufenden Woche_2 darstellt. Die aktuelle Woche_2 hat den Wert 0, die vorige Woche_2 -1 und die nächste Woche_2 den Wert 1'),
akt_wo_komplett BIGNUMERIC(38,0)
OPTIONS(description='Zahlenfolge, die den Abstand einer Woche_2 zur letzten abgeschlossenen Woche_2 darstellt. Die aktuelle Woche_2 hat den Wert 1, die vorige Woche_2 0 und die nächste Woche_2  den Wert 2'),
akt_wo_kalendarisch BIGNUMERIC(38,0)
OPTIONS(description='Zahlenfolge, die den Abstand einer Woche_2 zur laufenden Woche_2 darstellt. Die aktuelle Woche_2 hat den Wert 0, die vorige Woche_2 -1 und die nächste Woche_2 den Wert 1'),
td_update TIMESTAMP,
td_insert TIMESTAMP,
kjwo_vvj BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Kalenderwoche im Vorvorjahr')
) OPTIONS(description='Enthält Kalenderdaten auf Wochenebene');