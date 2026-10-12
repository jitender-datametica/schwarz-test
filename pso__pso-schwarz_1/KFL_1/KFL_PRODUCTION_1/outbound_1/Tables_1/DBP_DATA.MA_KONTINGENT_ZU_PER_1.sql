CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ma_kontingent_zu_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
mitarbeiter_id STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutige anonymisierte ID des Mitarbeiters'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahresmonat'),
kontingent_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Abwesenheitskontingenttyp; Feld:KTART; Quelle: IT2006-KTART'),
dat_von DATE NOT NULL
OPTIONS(description='Beginn Gueltigkeit Abwesenheit ; Feld: ZHR_KTARTBEGDA ; Quelle: IT2006-begda'),
dat_bis DATE NOT NULL OPTIONS(description='Ende Gueltigkeit Abwesenheit ; Feld: ZHR_KTARTENDDA ; Quelle: IT2006-endda'),
anz_kontingent NUMERIC(9,2) DEFAULT 0
OPTIONS(description='Anzahl Abwesenheitskontinggenttyp ; Feld: ZHR_KTARTANZHL ; Quelle: IT2006-anzhl'),
td_insert TIMESTAMP,
td_update TIMESTAMP
) OPTIONS(description='Abwesenheitskontingente aus fuenften optionalen IDOC Untersegment Z100IFDWHMDS6');