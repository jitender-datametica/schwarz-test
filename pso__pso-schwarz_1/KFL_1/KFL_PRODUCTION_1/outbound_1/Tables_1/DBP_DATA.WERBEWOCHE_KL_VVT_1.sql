CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.werbewoche_kl_vvt_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_1-TT'),
akt_kjwo_ww BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand einer Werbewoche zur laufenden Werbewoche darstellt. Die aktuelle Werbewoche hat den Wert 0, die vorige Woche_1 -1 und die nächste Woche_1 den Wert 1'),
akt_kjwo_ww_komplett BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand einer Werbewoche zur laufenden abgeschlossenen Werbewoche darstellt. Die aktuelle Werbewoche  hat den Wert 1, die vorige Werbewoche 0 und die nächste Werbewoche den Wert 2'),
kjwo_ww BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Werbewoche, Format JJJJWW'),
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='AIS - Enthält Kalenderdaten auf Werbewochen-Ebene mit VorVorTagslogik');