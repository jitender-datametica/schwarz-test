CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_itm_ean_1 (client_id
OPTIONS(description='DWH-Mandant_1; FK auf CLIENT; table name before the trans-all migration: client_id'), item_sid
OPTIONS(description='Systemgenerierte Artikelnummer; table name before the trans-all migration: item_sid'),
dat_rec_start OPTIONS(description='column name before the trans-all migration: dat_rec_start'), dat_rec_end
OPTIONS(description='column name before the trans-all migration: dat_rec_end'), ean_1
OPTIONS(description='column name before the trans-all migration: ean_1'), ean_item_desc
OPTIONS(description='column name before the trans-all migration: ean_item_desc'), ean_item_long_descr
OPTIONS(description='''extended desription of the EAN_1
WAWI: ARTEANCODES.ONLINE_DESC'''), custom_nr
OPTIONS(description='column name before the trans-all migration: custom_nr'), custom_key
OPTIONS(description='column name before the trans-all migration: custom_key'), language_id
OPTIONS(description='Sprache; table name before the trans-all migration: language_id'), load_id
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat; table name before the trans-all migration: load_id'))
OPTIONS(DESCRIPTION = `$Revision: 5995 $. Auto Generated  9/27/2017`) AS SELECT client_id,
 item_sid,
 dat_rec_start,
 dat_rec_end,
 ean_1,
 ean_item_desc,
 ean_item_long_descr,
 custom_nr,
 custom_key,
 language_id,
 load_id
FROM ldl_p_lew_core.t_wawi_itm_ean_1;