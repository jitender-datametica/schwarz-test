CREATE OR REPLACE TABLE kfl_production_dbp_data.l_ma (
ma_id INTEGER NOT NULL
OPTIONS(description='ID des Mitarbeiters. Wird im Beladeprozess als SK erzeugt aus den Feldern MANDT, IDNR, FUNCTION (Historisierung aufgrund CRDAT(Datum der Neuanlage des Datensatz)).'),
dat_von DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL OPTIONS(description='Datum, ab dem der Satz Gueltigkeit hat'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
sap_ma_id INTEGER NOT NULL OPTIONS(description='SAP Mitarbeiter ID'),
ma_funktion_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Die Funktion des Mitarbeiters aus der Quelle zrsvsdata.function.'),
dat_bis DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL
OPTIONS(description='Ende der Gueltigkeitsperiode. Format JJJJ-MM-TT'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='VIS - Mitarbeitertabelle - SAP RET - ZRS_VSDATA');