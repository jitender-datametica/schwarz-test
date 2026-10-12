CREATE TABLE P_LEW_CORE.T_TIME_TYPE_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   time_type_sid                       NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID fuer Arbeits- / Abwesenheitstyp.',
   src_wh_id                           NUMBER(38,0)     COMMENT 'Gesellschaftsnummer; PTM: VMIS_MISSINGTYPE.WHNO',
   src_time_type_id                    NUMBER(38,0)     COMMENT 'Abwesenheitstyp verwendet in PTM; PTM: VMIS_MISSINGTYPE.TYPE_ID',
   src_time_type_cd                    VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Abwesenheitstyp verwendet in SAP GPS; PTM: VMIS_MISSINGTYPE.SAP_FLAG',
   source_system                       VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Quellesystem (PTM/GPS)',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_TIME_TYPE PRIMARY KEY (client_id, time_type_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 11238 $: Zeittyp der Arbeit / Abwesenheit. Konsolidierung der Typen aus SAP GPS und PTM. Typen sind abhaengig von WH, dem die Zeiterfassung zugeordnet ist; SAP_GPS:Abwesenheitstypen_Initial.csv; PTM:VMIS_MISSINGTYPE;';
