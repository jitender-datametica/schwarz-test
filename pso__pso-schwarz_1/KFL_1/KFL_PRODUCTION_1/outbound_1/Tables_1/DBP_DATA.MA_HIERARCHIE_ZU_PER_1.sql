CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ma_hierarchie_zu_per_1 (
ma_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH ID des Mitarbeiters'),
ma_mutter_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH Mutter ID des Mitarbeiters'),
dat_von DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL OPTIONS(description='Datum, ab dem der Satz Gueltigkeit hat'),
dat_bis DATE NOT NULL OPTIONS(description='Ende der Gueltigkeitsperiode. Format JJJJ-MM_1-TT'),
mandant_id BIGNUMERIC(38,0) OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) OPTIONS(description='Marktnummer aus t001w.werks'),
ma_hierarchie_ebene_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Ma Hierarchieebene. Z.B. HL_1, VKL_1, GF_1'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='VIS - Abbildung der Mitarbeiterhierarchien. Quelle ist zrs_vsdata');