CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_time_type_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
time_type_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID fuer Arbeits- / Abwesenheitstyp.'),
time_type_short_descr STRING(250) COLLATE 'und:ci'
OPTIONS(description='Abwesenheitstyp Kurzbeschreibung; PTM:VMIS_MISSINGTYPE.SHORTDESC'),
time_type_descr STRING(250) COLLATE 'und:ci'
OPTIONS(description='Abwesenheitstyp Beschreibung; PTM:VMIS_MISSINGTYPE.DESCRIPTION'),
presence_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: 1 = der Mitarbeiter war Anwesend, 0 = Abwesend'),
performance_relevant_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag: 1 = leistungsrelevant, 0 = nicht leistungsrelevant; PTM:VMIS_MISSINGTYPE.PERFORMANCERELEVANCE'),
active_from_dt DATE OPTIONS(description='Start of record validity_1 that is set by business.'),
active_to_dt DATE OPTIONS(description='End of record validity_1 that is set by business.'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kunde ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_1 angenommen.'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (time_type_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='$Revision: 11238 $: Historized version - Zeittyp der Arbeit / Abwesenheit. Konsolidierung der Typen aus SAP GPS und PTM. Typen sind abhaengig von WH, dem die Zeiterfassung zugeordnet ist; SAP_GPS:Abwesenheitstypen_Initial.csv; PTM:VMIS_MISSINGTYPE;');