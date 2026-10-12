/* --------------------------------------------------------------------------------
   DDL for table: t_purchase_group_nat_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_purchase_group_nat_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
pur_grp_nat_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key PURCHASE GROUP NAT'),
src_ekgrp STRING(20)
OPTIONS(description='Quellsystemschluessel SAP-Retail: zmmx008_ekgrp_sh.ekgrp; SAP-BW: z_ds_ekgrp.ekgrp'),
pur_grp_nat_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung der Einkaufergruppe (in Stiftungssprache); SAP-Retail: zmmx008_ekgrp_sh.eknam; SAP-BW: z_ds_ekgrp.txtmd'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (pur_grp_nat_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. Einkaeufergruppen national;              SAP-Retail: ZMMX008_EKGRP_SH;             SAP-BW: z_ds_ekgrp;             ELWIS: -');