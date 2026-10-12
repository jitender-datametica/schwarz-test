/* --------------------------------------------------------------------------------
   DDL for table: t_item_property_relation_hist_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_PROPERTY_RELATION_HIST_2 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Item_2 that is assigned a property; FK on ITEM_2; SAP: z_ds_zmmx_v_bw_inob.objek; WaWi: C237_ITEMNR',
   item_property_sid                   NUMBER(38,0)     NOT NULL COMMENT 'Assigned property; FK on ITEM_PROPERTY; WaWi: C237_PROPERTY_ID',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'The property is assigned to the item_2 in case of deleted_fg = 0',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEM_PROPERTY_RELATION_HIST PRIMARY KEY (item_sid, item_property_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Links items to their assigned properties (n:m).
             existence of a valid link indicates an assignment.
             eLWIS: z_ds_zmmx_v_bw_inob, z_ds_zmmx_v_bw_ausp
             WaWi: T237_item_property_assignment_2';

