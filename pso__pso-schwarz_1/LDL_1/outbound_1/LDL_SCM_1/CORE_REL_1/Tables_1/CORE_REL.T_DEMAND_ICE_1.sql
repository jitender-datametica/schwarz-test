CREATE TABLE IF NOT EXISTS ldl_scm_core_rel.t_demand_ice_1 (
pal_ian_lidl BIGNUMERIC(38,0) OPTIONS(description='PAL IAN Lidl'),
artikelbezeichnung STRING(500) OPTIONS(description='Artikelbeschreibung'),
land_1 STRING(100) OPTIONS(description='Land_1'),
einzelstueck_pro_fsschale BIGNUMERIC(38,0) OPTIONS(description='Stück pro Eisschale'),
fsschalen_pro_pal BIGNUMERIC(38,0) OPTIONS(description='Schalen pro Palette'),
gesamt_planme_in_fs_schalen BIGNUMERIC(38,0) OPTIONS(description='Gesamtplanung in Eisschalen'),
month INTEGER OPTIONS(description='Monat_1'),
year INTEGER OPTIONS(description='Jahr'),
plan BIGNUMERIC(38,5) OPTIONS(description='Plan'),
bm BIGNUMERIC(38,5) OPTIONS(description='Bestellmenge'),
d_bm_vs_plan_abs BIGNUMERIC(38,5) OPTIONS(description='Differenz zwischen Bestellmenge und geplanter Menge (absolut)'),
d_bm_vs_plan_p BIGNUMERIC(38,5) OPTIONS(description='Differenz zwischen Bestellmenge und geplanter Menge (prozentual)'),
dwh_updated_tmsp DATETIME OPTIONS(description='Erstellungszeitpunkt des Datensatzes im DWH'),
dwh_created_tmsp DATETIME OPTIONS(description='Zeitstempel der letzten Aktualisierung des Datensatzes im DWH')
);