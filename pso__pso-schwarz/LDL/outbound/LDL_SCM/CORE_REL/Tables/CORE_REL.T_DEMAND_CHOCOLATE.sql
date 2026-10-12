CREATE TABLE IF NOT EXISTS ldl_scm_core_rel.t_demand_chocolate (
ian BIGNUMERIC(38,0) OPTIONS(description='IAN'),
mat_nr BIGNUMERIC(38,0) OPTIONS(description='Materialnummer'),
pal_artikel STRING(100) OPTIONS(description='PAL Artikel'),
stueck_je_karton STRING(100) OPTIONS(description='Stück pro Karton'),
stueck_je_palette BIGNUMERIC(38,0) OPTIONS(description='Stück pro Palette'),
land STRING(100) OPTIONS(description='Land'),
month INTEGER OPTIONS(description='Monat'),
year INTEGER OPTIONS(description='Jahr'),
plan BIGNUMERIC(38,5) OPTIONS(description='Geplante Menge'),
bestellmenge BIGNUMERIC(38,0) OPTIONS(description='Erhaltene Menge'),
d_bm_vs_plan BIGNUMERIC(38,5) OPTIONS(description='Differenz zwischen Bestellmenge und geplanter Menge (absolut)'),
d_bm_vs_plan_p BIGNUMERIC(38,5) OPTIONS(description='Differenz zwischen Bestellmenge und geplanter Menge (prozentual)'),
dwh_updated_tmsp DATETIME OPTIONS(description='Erstellungszeitpunkt des Datensatzes im DWH'),
dwh_created_tmsp DATETIME OPTIONS(description='Zeitstempel der letzten Aktualisierung des Datensatzes im DWH')
);