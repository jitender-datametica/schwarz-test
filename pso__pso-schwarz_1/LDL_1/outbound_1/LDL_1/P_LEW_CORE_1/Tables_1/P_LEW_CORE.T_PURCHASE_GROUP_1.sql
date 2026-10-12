/* --------------------------------------------------------------------------------
   DDL for table: t_purchase_group_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_purchase_group_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
pur_grp_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key PURCHASE GROUP'),
src_ekgrp STRING(20) OPTIONS(description='Quellsystemschluessel SAP-Retail: t024.EKGRP'),
pur_grp_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung der Einkaufergruppe (in Stiftungssprache); SAP-Retail: t024.EKNAM'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (pur_grp_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. PGRP; Einkaufsgruppen;              SAP-Retail: T024_1;             SAP-BW: t_bw_z_ds_t024;             ELWIS: t_r_pur_grp');