CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_time_type_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
time_type_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID fuer Arbeits- / Abwesenheitstyp.'),
src_wh_id BIGNUMERIC(38,0) OPTIONS(description='Gesellschaftsnummer; PTM: VMIS_MISSINGTYPE.WHNO'),
src_time_type_id BIGNUMERIC(38,0) OPTIONS(description='Abwesenheitstyp verwendet in PTM; PTM: VMIS_MISSINGTYPE.TYPE_ID'),
src_time_type_cd STRING(100) COLLATE 'und:ci'
OPTIONS(description='Abwesenheitstyp verwendet in SAP GPS; PTM: VMIS_MISSINGTYPE.SAP_FLAG'),
source_system STRING(100) COLLATE 'und:ci' OPTIONS(description='Quellesystem (PTM/GPS)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, time_type_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 11238 $: Zeittyp der Arbeit / Abwesenheit. Konsolidierung der Typen aus SAP GPS und PTM. Typen sind abhaengig von WH, dem die Zeiterfassung zugeordnet ist; SAP_GPS:Abwesenheitstypen_Initial.csv; PTM:VMIS_MISSINGTYPE;');