CREATE TABLE P_LEW_CORE.T_INTERNAL_ORGANISATION_TYPE_1 (
   int_org_type_cd                     VARCHAR(100)    NOT NULL COMMENT 'type code of the internal organisation (defined by the data modeler)',
   int_org_type_name                   VARCHAR(100)    COMMENT 'name of the internal organisation type',
   int_org_type_descr                  VARCHAR(250)    COMMENT 'description of the organisation type',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_T_INTERNAL_ORGANISATION_TYPE PRIMARY KEY (int_org_type_cd)
       NOT ENFORCED
)
COMMENT = 'Ths table contains the types of internal organizations stored in t_organisational_unit. It contains organisation types on a level comparable to country_1 or client, but having different business backgrounds and therefore different details.';

