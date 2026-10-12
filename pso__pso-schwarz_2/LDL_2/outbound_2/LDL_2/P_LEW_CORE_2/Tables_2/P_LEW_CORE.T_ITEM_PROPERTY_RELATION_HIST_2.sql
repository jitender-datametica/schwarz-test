/* --------------------------------------------------------------------------------
   DDL for table: t_item_property_relation_hist_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_property_relation_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Item_2 that is assigned a property; FK on ITEM_2; SAP: z_ds_zmmx_v_bw_inob.objek; WaWi: C237_ITEMNR'),
item_property_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Assigned property; FK on ITEM_PROPERTY; WaWi: C237_PROPERTY_ID'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The property is assigned to the item_2 in case of deleted_fg = 0'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (item_sid, item_property_sid, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. Links items to their assigned properties (n:m).             existence of a valid link indicates an assignment.             eLWIS: z_ds_zmmx_v_bw_inob, z_ds_zmmx_v_bw_ausp             WaWi: T237_item_property_assignment_2');