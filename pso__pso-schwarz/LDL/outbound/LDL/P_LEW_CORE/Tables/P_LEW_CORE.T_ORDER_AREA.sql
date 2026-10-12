/* --------------------------------------------------------------------------------
   DDL for table: t_order_area
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_order_area (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant;'),
order_area_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='surrogate key; uniquely identifies a WH Order Area'),
src_ekgrp STRING(20) OPTIONS(description='techn. identifier of order area withinSAP Retail'),
src_bestbereichnr STRING(20) OPTIONS(description='techn. identifier of order area within WAWI'),
order_area_nr STRING(20) NOT NULL OPTIONS(description='business identifier of the order area (known to the business)'),
order_area_name STRING(100)
OPTIONS(description='name describing the general order area - may or may not be overwritten within a WH'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (order_area_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. General set of order areas ("Bestellbereiche") available. Caution: WHs may use just a subset of the order areas and define their own names for them');