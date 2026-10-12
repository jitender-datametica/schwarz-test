/* --------------------------------------------------------------------------------
   DDL for table: t_map_mis_move_type_deliv_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MAP_MIS_MOVE_TYPE_DELIV_2 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   order_type_cd                       VARCHAR(20)      NOT NULL COMMENT 'ELWIS: order_type_cd; pendant: f_lew_core.t_order_record_2',
   move_type_cd                        VARCHAR(20)      NOT NULL COMMENT 'ELWIS: mov_type_cd; pendant: f_lew_core.t_item_movement_record_pos_2',
   mis_deliv_type_id                   NUMBER(38,0)     NOT NULL COMMENT 'ELWIS: mis_deliv_type_id',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_MAP_MIS_MOVE_TYPE_DELIV PRIMARY KEY (client_id, order_type_cd, move_type_cd) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Tabelle zur Ermittlung des MIS-Deliv-Type-Codes;
             Inhalt wird manuell gepflegt;
             ELWIS: t_s_mov_type_deliv_map_mis';

