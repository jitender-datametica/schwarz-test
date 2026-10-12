/* --------------------------------------------------------------------------------
   DDL for table: t_map_mis_item_status_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MAP_MIS_ITEM_STATUS_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   item_status_cd                      VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'ELWIS: p_core_data.t_r_itm_state_map_mis.itm_state_bges_id',
   item_status_descr                   VARCHAR(100)     COLLATE 'en-ci' COMMENT 'ELWIS: p_core_data.t_r_itm_state_map_mis.itm_state_descr',
   mis_itm_state_id                    NUMBER(38,0)     COMMENT 'ELWIS: mis_itm_state_id',
   mis_state_descr                     VARCHAR(100)     COLLATE 'en-ci' COMMENT 'ELWIS: mis_state_descr',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_MAP_MIS_ITEM_STATUS PRIMARY KEY (client_id, item_status_cd) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Tabelle zur Ermittlung des MIS-Item_2-Status_2-Codes;
             Inhalt wird manuell gepflegt;
             ELWIS: t_r_itm_state_map_mis';

