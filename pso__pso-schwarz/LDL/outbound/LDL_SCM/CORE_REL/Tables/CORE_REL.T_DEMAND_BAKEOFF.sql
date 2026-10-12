CREATE TABLE IF NOT EXISTS ldl_scm_core_rel.t_demand_bakeoff (
ian BIGNUMERIC(38,0) OPTIONS(description='Internationale Artikelnummer'),
prod_hier_v STRING(100) OPTIONS(description='Produkthierarchie'),
stueck_je_karton BIGNUMERIC(38,0) OPTIONS(description='Stück pro Karton'),
stueck_je_hhpech BIGNUMERIC(38,0) OPTIONS(description='Stück je HHPECH'),
land STRING(100) OPTIONS(description='Ländercode'),
month INTEGER OPTIONS(description='Monat'),
year INTEGER OPTIONS(description='Jahr'),
plan BIGNUMERIC(38,5) OPTIONS(description='Plan'),
bestellmenge BIGNUMERIC(38,0) OPTIONS(description='Bestellmenge'),
d_bm_vs_plan BIGNUMERIC(38,5) OPTIONS(description='Differenz zwischen Bestellmenge und Plan'),
d_bm_vs_plan_p BIGNUMERIC(38,5) OPTIONS(description='Prozentuale Differenz zwischen Bestellmenge und Plan'),
dwh_updated_tmsp DATETIME OPTIONS(description='Erstellungszeitpunkt des Datensatzes im DWH'),
dwh_created_tmsp DATETIME OPTIONS(description='Zeitstempel der letzten Aktualisierung des Datensatzes im DWH')
);