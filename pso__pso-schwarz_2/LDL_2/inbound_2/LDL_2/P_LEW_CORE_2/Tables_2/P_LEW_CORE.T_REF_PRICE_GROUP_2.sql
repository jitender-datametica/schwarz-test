/* --------------------------------------------------------------------------------
   DDL for table: t_ref_price_group_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_PRICE_GROUP_2 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   price_group_id                      NUMBER(38,0)     NOT NULL COMMENT 'ELWIS: t_s_prcs_grp.prcs_grp_cd',
   price_group_name                    VARCHAR(100)     COLLATE 'en-ci' COMMENT 'ELWIS: t_r_prcs_grp_descr.prcs_grp_descr',
   price_group_prio                    NUMBER(38,0)     COMMENT 'ELWIS: t_s_prcs_grp.prcs_grp_prio',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_PRICE_GROUP PRIMARY KEY (client_id, price_group_id) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. 
             manualy maintained lookup table;
             ELWIS: t_s_prcs_grp, t_r_prcs_grp_descr;';

