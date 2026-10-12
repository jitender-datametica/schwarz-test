/* --------------------------------------------------------------------------------
   DDL for table: t_supplier_eks_hist
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_SUPPLIER_EKS_HIST CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   sup_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Lieferant; FK auf SUPPLIER; SAP-Retail: zmmx_eks.lifnr; SAP-BW: t_bw_z_ds_zmmx_eks.lifnr',
   eks_no                              NUMBER(38,0)     NOT NULL COMMENT 'EKS-Lieferantennummer; SAP-Retail: zmmx_eks.eksnr; SAP-BW: t_bw_z_ds_zmmx_eks.eksnr; ELWIS: t_s_sup_eksnr.eks_nr',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Lieferant/EKS-Bez. ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status angenommen',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_SUPPLIER_EKS_HIST PRIMARY KEY (sup_sid, eks_no, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. SEKSH; EKS-Lieferantennummern;
             SAP-Retail: zmmx_eks;
             SAP-BW: t_bw_z_ds_zmmx_eks;
             ELWIS: t_s_sup_eksnr;
             WAWI: t_sup_supplier_int';

