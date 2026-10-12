CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_item_relation_hist (item_sid
OPTIONS(description='Artikel; FK auf ITEM; SAP-Retail: makt.matnr; SAP-BW: t_bw_0material_text.matnr'), rel_item_sid
OPTIONS(description='Surrogate Key for the related ITEM (eindeutig ueber alle Laender/Mandanten hinweg).'),
item_rel_type_cd
OPTIONS(description='Source relationship type number, which identifies the type of the relationship between the parent item and the child item.'),
item_rel_type_grp_cd
OPTIONS(description='The relationship type group code that arranges the relationship types for a combining property, like source system or table.'),
item_rel_rate
OPTIONS(description='Item relationship rate between the item and the related items. e.g. Quantity of pieces (child items) inside of the item multipack / case (parent item).'),
deleted_fg
OPTIONS(description='The record is in case of deleted_fg = 1 not known in the source system in the time frame dwh_valid_from / dwh_valid_to. Note: this is also set ff the loesch-kz in the source system is set.'),
dwh_valid_from
OPTIONS(description='Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to
OPTIONS(description='End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
client_id OPTIONS(description='DWH-Mandant; FK auf CLIENT'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'), dwh_updated
OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `This table contains the relationship between two items, I.e. a multpack and its set of included items, which can help calculate accurate quantities of pieces sold, considering the real quantity inside the pack instead of counting only one piece per pack.\nSources:\nWAWI Table: T218_CONS_ITEM_LINKS`)
AS SELECT item_sid,
 rel_item_sid,
 item_rel_type_cd,
 item_rel_type_grp_cd,
 item_rel_rate,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 client_id,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_item_relation_hist;