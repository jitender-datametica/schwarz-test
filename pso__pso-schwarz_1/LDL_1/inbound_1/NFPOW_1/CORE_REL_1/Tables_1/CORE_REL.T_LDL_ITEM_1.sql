CREATE TABLE CORE_REL.T_LDL_ITEM_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   ldl_item_sid                        NUMBER(38,0)     NOT NULL,
   ldl_client_id                       NUMBER(38,0)     NOT NULL,
   ldl_item_nr                         NUMBER(38,0),
   case_size_qty                       NUMBER(38,5),
   active_from_dt                      DATE,
   ldl_brand_list_type_id              NUMBER(38,0)     COMMENT 'WAWI: P_LEW_MART_MSI_AC_MATERIALIZED.v_ref_itm_list_type_buylist_1',
   ldl_list_type_id                    NUMBER(38,0)     COMMENT 'WAWI:p_lew_mart_lead_ac.V_ITM_ITEM.listing_type_id',
   ldl_brand_name                      VARCHAR(100)     COMMENT 'WAWI:p_lew_mart_lead_ac.V_ITM_ITEM.brand_1',
   ldl_item_fam_grp_nr                 NUMBER(38,0)     COMMENT 'WAWI:p_lew_mart_lead_ac.V_ITM_ITEM.item_familygroup_id',
   ldl_sub_item_grp_id                 NUMBER(38,0),
   ldl_item_name                       VARCHAR(100)     COMMENT 'WAWI:p_lew_mart_lead_ac.V_ITM_ITEM.item_desc',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_LDL_ITEM PRIMARY KEY (ldl_item_sid) NOT ENFORCED 
)  COMMENT = '-Level wie in p_lew_core.t_item_1, key ist ldl_item_sid (aus item_sid) 
             WAWI: p_lew_mart_lead_ac.V_ITM_ITEM_1
             Spalten: item_id,client_id,orig_item_nr,case_size,dat_valid_from
             ,buying_list_type_id,listing_type_id,brand_1,subitemgroup_id,item_desc,item_familygroup_id
             ';