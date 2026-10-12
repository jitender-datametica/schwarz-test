CREATE TABLE IF NOT EXISTS ldl_scm_core_rel.t_demand_nuts_1 (
ian BIGNUMERIC(38,0) OPTIONS(description='Kennung für den Artikel_1'),
pal_artikel STRING(100) OPTIONS(description='Artikelkennung in Palette'),
stueck_je_karton BIGNUMERIC(38,0) OPTIONS(description='Anzahl der Stücke pro Karton'),
stueck_je_palette BIGNUMERIC(38,0) OPTIONS(description='Anzahl der Stücke pro Palette'),
land_1 STRING(100) OPTIONS(description='Ländercode oder -name'),
month INTEGER OPTIONS(description='Monat_1 der Daten (1-12)'),
year INTEGER OPTIONS(description='Jahr der Daten (z.B. 2024)'),
plan BIGNUMERIC(38,5) OPTIONS(description='Geplante Menge'),
bestellmenge BIGNUMERIC(38,0) OPTIONS(description='Bestellmenge'),
d_bm_vs_plan BIGNUMERIC(38,5) OPTIONS(description='Absolute Differenz zwischen Bestellmenge und geplanter Menge'),
d_bm_vs_plan_p BIGNUMERIC(38,5) OPTIONS(description='Prozentuale Differenz zwischen Bestellmenge und geplanter Menge'),
dwh_updated_tmsp DATETIME OPTIONS(description='Erstellungszeitpunkt des Datensatzes im DWH.'),
dwh_created_tmsp DATETIME OPTIONS(description='Zeitstempel der letzten Aktualisierung des Datensatzes im DWH.')
);