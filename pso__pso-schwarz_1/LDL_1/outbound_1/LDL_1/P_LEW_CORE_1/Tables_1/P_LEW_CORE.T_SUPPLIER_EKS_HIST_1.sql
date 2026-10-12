/* --------------------------------------------------------------------------------
   DDL for table: t_supplier_eks_hist_1
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_supplier_eks_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
sup_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Lieferant; FK auf SUPPLIER_1; SAP-Retail: zmmx_eks.lifnr; SAP-BW: t_bw_z_ds_zmmx_eks.lifnr'),
eks_no BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='EKS-Lieferantennummer; SAP-Retail: zmmx_eks.eksnr; SAP-BW: t_bw_z_ds_zmmx_eks.eksnr; ELWIS: t_s_sup_eksnr.eks_nr'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Lieferant/EKS-Bez. ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_1 angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (sup_sid, eks_no, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. SEKSH; EKS-Lieferantennummern;             SAP-Retail: zmmx_eks;             SAP-BW: t_bw_z_ds_zmmx_eks;             ELWIS: t_s_sup_eksnr;             WAWI: t_sup_supplier_int');