/* --------------------------------------------------------------------------------
   DDL for table: t_map_mis_pcwo_id
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MAP_MIS_PCWO_ID CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   move_type_cd                        VARCHAR(20)      NOT NULL COMMENT 'ELWIS: mov_type_cd; pendant: f_lew_core.t_item_movement_record_pos',
   move_reason_cd                      VARCHAR(20)      NOT NULL COMMENT 'ELWIS: mov_reason_cd; pendant: f_lew_core.t_item_movement_record_pos',
   move_reason_descr                   VARCHAR(100)     COMMENT 'ELWIS: mov_reason_descr',
   mis_pcwo_reason_id                  NUMBER(38,0)     COMMENT 'ELWIS: pcwo_reason_id',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_MAP_MIS_PCWO_ID PRIMARY KEY (client_id, move_type_cd, move_reason_cd) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Tabelle zur Ermittlung des MIS-PCWO-REASON-ID;
             Inhalt wird manuell gepflegt;
             ELWIS: t_r_pcwo_id_mis';

