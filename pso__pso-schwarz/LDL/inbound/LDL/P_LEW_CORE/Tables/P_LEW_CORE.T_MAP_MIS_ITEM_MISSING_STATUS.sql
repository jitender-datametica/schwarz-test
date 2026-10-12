/* --------------------------------------------------------------------------------
   DDL for table: t_map_mis_item_missing_status
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MAP_MIS_ITEM_MISSING_STATUS CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   item_status_cd                      VARCHAR(20)      NOT NULL COMMENT 'ELWIS: itm_state_bges_id; pendant: f_lew_core.item_info_per_location',
   missing_state_cd                    VARCHAR(20)      NOT NULL COMMENT 'ELWIS: itm_missing_state; pendant: f_lew_core.t_item_missing_progress',
   missing_reason_cd                   VARCHAR(20)      COMMENT 'ELWIS: itm_missing_reason_cd: pendant: f_lew_core.t_item_missing_progress',
   mis_item_missing_reason_cd          VARCHAR(20)      COMMENT 'ELWIS: itm_missing_reason_cd',
   mis_end_cd_pp                       VARCHAR(20)      COMMENT 'ELWIS: end_cd_pp_mis',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_MAP_MIS_ITEM_MISSING_STATUS PRIMARY KEY (client_id, item_status_cd, missing_state_cd) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Tabelle zur Ermittlung des MIS-Item-Missing-Status-Codes;
             Inhalt wird manuell gepflegt;
             ELWIS: t_r_itm_missing_state_map_mis';

