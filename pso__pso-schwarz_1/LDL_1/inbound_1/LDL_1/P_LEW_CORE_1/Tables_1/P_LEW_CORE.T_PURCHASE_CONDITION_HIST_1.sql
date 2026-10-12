/* --------------------------------------------------------------------------------
   DDL for table: t_purchase_condition_hist_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_PURCHASE_CONDITION_HIST_1 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   pur_cond_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key PURCHASE CONDITION',
   curr_sid                            NUMBER(38,0)     COMMENT 'Waehrung des Konditionsbetrags; FK auf CURRENCY; SAP-Retail: konp.konwa; SAP-BW: z_ds_zmmx_v_bw_konhp.konwa; ELWIS Name: t_s_pur_cond_pos.cond_am',
   condition_pos_nr                    NUMBER(38,0)     COMMENT 'Positionsnr. im Quellsystem - im Applikationsbereich Einkauf gibt es nur eine_1 Pos pro knumh; SAP-Retail: konp.kopos; SAP-BW: z_ds_zmmx_v_bw_konhp.kopos',
   curr_cd                             VARCHAR(20)      COMMENT 'Waehrungscode des Konditionsbetrags; SAP-Retail: konp.konwa; SAP-BW: z_ds_zmmx_v_bw_konhp.konwa; ELWIS: t_s_pur_cond_pos.cond_am',
   condition_val                       NUMBER(18,5)     COMMENT 'Konditionsbetrag; SAP-Retail: konp.kbetr; SAP-BW: z_ds_zmmx_v_bw_konhp.kbetr; ELWIS: t_s_pur_cond_pos.cond_amt ',
   condition_pct_val                   NUMBER(18,5)     COMMENT 'Konditionsprozentsatz = kbetr/10; SAP-Retail: konp.kbetr; SAP-BW: z_ds_zmmx_v_bw_konhp.kbetr; ELWIS: t_s_pur_cond_pos.cond_amt ',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Pinfo-Detail ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_1 angenommen; SAP-Retail: eine.loekz',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_PURCHASE_CONDITION_HIST PRIMARY KEY (pur_cond_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. PUCOH; 
             Konditionen aus Applikation Einkauf ("M");
             hierbei sind fachlich zu einer Kondition nicht mehr als eine_1 Positionsnr moeglich;
             SAP-Retail: konh/konp_1; 
             SAP-BW: z_ds_zmmx_v_bw_konhp;
             ELWIS: t_s_pur_cond(_pos)';

