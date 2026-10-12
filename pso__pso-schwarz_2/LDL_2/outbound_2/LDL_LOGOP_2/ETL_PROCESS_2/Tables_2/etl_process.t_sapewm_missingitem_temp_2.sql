/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	etl_process
DB table		|	t_sapewm_missingitem_2
Description		|	SAP EWM - source table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_sapewm_missingitem_temp_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID. Subset of Warehouse Number'),
mandt STRING(3) OPTIONS(description='Client'),
zz_mi_no STRING(10) NOT NULL OPTIONS(description='Missing item_2 number'),
matnr STRING(40) OPTIONS(description='Product'),
lgnum STRING(4) NOT NULL OPTIONS(description='Warehouse Number/Warehouse Complex'),
avlgrp STRING(10) OPTIONS(description='Availability Group'),
entitled STRING(10) OPTIONS(description='Party Entitled to Dispose'),
zz_mi_status STRING(1) OPTIONS(description='Missing item_2 status_2'),
zz_mi_status_cp STRING(1) OPTIONS(description='Missing item_2 status_2 cartonization planning'),
zzernam STRING(12) OPTIONS(description='Name of person who created the object'),
zzerdat DATE OPTIONS(description='Date on which record was created'),
zzerzet TIME OPTIONS(description='Entry Time'),
zzaenam STRING(12) OPTIONS(description='Name of person who changed object'),
zzaedat DATE OPTIONS(description='Changed On'),
zzaezet TIME OPTIONS(description='Time last change was made'),
mi_reason STRING(2) OPTIONS(description='Missing Item_2 Reason'),
mi_ernam STRING(12) OPTIONS(description='Reason Created by'),
mi_erdat DATE OPTIONS(description='Reason Created at'),
mierzeit TIME OPTIONS(description='Reason Created on'),
egr_date DATE OPTIONS(description='Expected Goods Receipt Date'),
egr_date_ernam STRING(12) OPTIONS(description='EGR Date Created by'),
egr_date_erdat DATE OPTIONS(description='EGR Date Created at'),
egr_date_erzeit TIME OPTIONS(description='EGR Date Created on'),
product_text STRING(40) OPTIONS(description='Retrieving data. Wait a few seconds and try to cut or copy again.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
PRIMARY KEY (client_id, lgnum, zz_mi_no) NOT ENFORCED
) OPTIONS(description='SAP EWM - Missing Items');