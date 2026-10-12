CREATE TABLE P_LEW_CORE.T_TIME_TYPE_HIST_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   time_type_sid                       NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID fuer Arbeits- / Abwesenheitstyp.',
   time_type_short_descr               VARCHAR(250)     COLLATE 'en-ci' COMMENT 'Abwesenheitstyp Kurzbeschreibung; PTM:VMIS_MISSINGTYPE.SHORTDESC',
   time_type_descr                     VARCHAR(250)     COLLATE 'en-ci' COMMENT 'Abwesenheitstyp Beschreibung; PTM:VMIS_MISSINGTYPE.DESCRIPTION',
   presence_fg                         NUMBER(38,0)     COMMENT 'Flag: 1 = der Mitarbeiter war Anwesend, 0 = Abwesend',
   performance_relevant_fg             NUMBER(38,0)     COMMENT 'Flag: 1 = leistungsrelevant, 0 = nicht leistungsrelevant; PTM:VMIS_MISSINGTYPE.PERFORMANCERELEVANCE',
   active_from_dt                      DATE             COMMENT 'Start of record validity_2 that is set by business.',
   active_to_dt                        DATE             COMMENT 'End of record validity_2 that is set by business.',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Kunde ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_2 angenommen.',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_TIME_TYPE_HIST PRIMARY KEY (time_type_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 11238 $: Historized version - Zeittyp der Arbeit / Abwesenheit. Konsolidierung der Typen aus SAP GPS und PTM. Typen sind abhaengig von WH, dem die Zeiterfassung zugeordnet ist; SAP_GPS:Abwesenheitstypen_Initial.csv; PTM:VMIS_MISSINGTYPE;';

