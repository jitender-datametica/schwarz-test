/* --------------------------------------------------------------------------------
   DDL for table: t_purchase_condition_2
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_PURCHASE_CONDITION_2 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   pur_cond_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key PURCHASE CONDITION',
   src_knumh                           VARCHAR(20)      COMMENT 'Nummer des Konditionssatzes; SAP-Retail: konh.knumh; SAP-BW: z_ds_zmmx_v_bw_konhp.knumh',
   application_cd                      VARCHAR(20)      COMMENT 'Applikation: M=Einkauf; SAP-Retail: konh.kappl; SAP-BW: z_ds_zmmx_v_bw_konhp.kappl; ELWIS: t_s_pur_cond.cond_appl',
   condition_type_cd                   VARCHAR(20)      COMMENT 'Konditionsart; SAP-Retail: konh.kschl; SAP-BW: z_ds_zmmx_v_bw_konhp.kschl; ELWIS: t_s_pur_cond.cond_type',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_PURCHASE_CONDITION PRIMARY KEY (pur_cond_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. PUCO; 
             Konditionen aus Applikation Einkauf ("M");
             hierbei sind fachlich zu einer Kondition nicht mehr als eine_2 Positionsnr moeglich;
             SAP-Retail: konh/konp_2; 
             SAP-BW: z_ds_zmmx_v_bw_konhp;
             ELWIS: t_s_pur_cond(_pos)';

