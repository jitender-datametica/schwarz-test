/* --------------------------------------------------------------------------------
   DDL for table: t_map_mis_item_missing_reason
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MAP_MIS_ITEM_MISSING_REASON CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   missing_reason_cd                   VARCHAR(20)      NOT NULL COMMENT 'ELWIS: x_bdo_coex_data.t_ref_miss_reason_map.elwis_itm_miss_reason_cd; pendant: f_lew_core.t_item_missing_progress.missing_reason_cd',
   mis_item_missing_reason_cd          VARCHAR(20)      COMMENT 'ELWIS: x_bdo_coex_data.t_ref_miss_reason_map.wawi_itm_miss_reason_cd;',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_MAP_MIS_ITEM_MISSING_REASON PRIMARY KEY (client_id, missing_reason_cd) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Tabelle zum Mapping zwischen WAWI und SAP Missing-Reason-Codes;
             Inhalt wird manuell gepflegt;
             COEX: x_bdo_coex_data.t_ref_miss_reason_map';

