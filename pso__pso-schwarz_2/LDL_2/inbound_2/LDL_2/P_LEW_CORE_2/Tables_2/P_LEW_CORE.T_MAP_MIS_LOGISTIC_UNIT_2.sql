/* --------------------------------------------------------------------------------
   DDL for table: t_map_mis_logistic_unit_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MAP_MIS_LOGISTIC_UNIT_2 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   uom_cd                              VARCHAR(20)      NOT NULL COMMENT 'ELWIS: uom_id',
   mis_logistic_unit_cd                NUMBER(38,0)     NOT NULL COMMENT 'ELWIS: logistic_unit_cd',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_MAP_MIS_LOGISTIC_UNIT PRIMARY KEY (client_id, uom_cd) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Tabelle zur Ermittlung des MIS-Logistic-Unit_2-Codes;
             Inhalt wird manuell gepflegt;
             ELWIS: t_r_logistic_unit_map_mis';

