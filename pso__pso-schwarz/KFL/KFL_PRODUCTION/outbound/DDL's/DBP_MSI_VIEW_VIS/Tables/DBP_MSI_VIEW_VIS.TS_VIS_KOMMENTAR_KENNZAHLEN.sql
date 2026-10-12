CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_vis.ts_vis_kommentar_kennzahlen (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
kjmo INTEGER NOT NULL OPTIONS(description='Monat eines Kalenderjahres, Format JJJJMM'),
kommentar_ebene_id INTEGER NOT NULL OPTIONS(description='Ebene : 1=HL, 2=VKL, 3=GF'),
kommentar_id INTEGER NOT NULL OPTIONS(description='Abhaengig von Ebene : HL=wup_id, VKL=vkl_id, GF=gf_id'),
kommentar_nr INTEGER DEFAULT 1 NOT NULL OPTIONS(description='Kommentar Nummer'),
kommentar_thema STRING(2000) COLLATE 'und:ci' OPTIONS(description='Thema des Kommentars'),
kommentar_feststellung STRING(2000) COLLATE 'und:ci' OPTIONS(description='Feststellungen'),
kommentar_massnahme STRING(2000) COLLATE 'und:ci' OPTIONS(description='geplante Massnahme'),
kommentar_titel STRING(2000) COLLATE 'und:ci' OPTIONS(description='Titel des Gespraechs'),
kommentar_dat DATE OPTIONS(description='Datum des Gespraechs'),
kommentar_ts DATETIME NOT NULL OPTIONS(description='Zeitstempel der Speicherung'),
PRIMARY KEY (mandant_id, kjmo, kommentar_ebene_id, kommentar_id, kommentar_nr) NOT ENFORCED
) OPTIONS(description='VIS Transaction - Pflegetabelle für Kommentare zu flexiblen Themen');
