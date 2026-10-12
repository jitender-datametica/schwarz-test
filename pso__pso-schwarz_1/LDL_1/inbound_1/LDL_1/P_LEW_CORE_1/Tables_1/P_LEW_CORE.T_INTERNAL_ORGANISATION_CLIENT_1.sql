CREATE TABLE P_LEW_CORE.T_INTERNAL_ORGANISATION_CLIENT_1 (
   int_org_sid                         NUMBER(38,0)    NOT NULL COMMENT 'surrogate key internal organisation',
   int_org_type_cd                     VARCHAR(100)    NOT NULL COMMENT 'type code of the internal organisation (defined by the data modeler)',
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'Surrogate Key CLIENT',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_T_INTERNAL_ORGANISATION_CLIENT PRIMARY KEY (int_org_sid, client_id)
       NOT ENFORCED
)
COMMENT = 'This table contains the relationship between internal organisations and erp system based clients. this relationship can be 1:n, m:1 or m:n, depending on the organisation type';