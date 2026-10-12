CREATE TABLE p_lew_core.T_INTERNAL_ORGANISATION_2 (
   int_org_sid                         NUMBER(38,0)    NOT NULL COMMENT 'surrogate key internal organisation',
   int_org_type_cd                     VARCHAR(100)    NOT NULL COMMENT 'type code of the internal organisation',
   int_org_nr                          VARCHAR(100)    NOT NULL COMMENT 'identifier of the internal organisation in the source system',
   int_org_name                        VARCHAR(100)    COMMENT 'name of the internal organisation',
   int_org_descr                       VARCHAR(250)    COMMENT 'description of the onternal organisation',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_T_INTERNAL_ORGANISATION PRIMARY KEY (int_org_sid)
       NOT ENFORCED
)
COMMENT = 'This table contains the list of internal organizations of various types. This table is not replacing the already modeled tables containing ERP-related organisational units like client, store or warehouse. It contains organisation types on a level comparable to country_2 or client, but having different business backgrounds and therefore different details.';