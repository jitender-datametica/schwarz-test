CREATE TABLE IF NOT EXISTS ldl_scm_core_rel.t_demand_coffee_2 (
ian BIGNUMERIC(38,0) OPTIONS(description='IAN'),
pal_artikel STRING(100) OPTIONS(description='PAL Artikel_2'),
stueck_je_karton BIGNUMERIC(38,0) OPTIONS(description='Stück pro Karton'),
stueck_je_palette BIGNUMERIC(38,0) OPTIONS(description='Stück pro Palette'),
land_2 STRING(100) OPTIONS(description='Ländercode'),
month INTEGER OPTIONS(description='Monat_2'),
year INTEGER OPTIONS(description='Jahr'),
plan BIGNUMERIC(38,5) OPTIONS(description='Plan'),
bestellmenge BIGNUMERIC(38,0) OPTIONS(description='Bestellmenge'),
d_bm_vs_plan_abs BIGNUMERIC(38,5) OPTIONS(description='Differenz zwischen Bestellmenge und geplanter Menge (absolut)'),
d_bm_vs_plan_p BIGNUMERIC(38,5) OPTIONS(description='Differenz zwischen Bestellmenge und geplanter Menge (prozentual)'),
dwh_updated_tmsp DATETIME OPTIONS(description='Erstellungszeitpunkt des Datensatzes im DWH'),
dwh_created_tmsp DATETIME OPTIONS(description='Zeitstempel der letzten Aktualisierung des Datensatzes im DWH')
);