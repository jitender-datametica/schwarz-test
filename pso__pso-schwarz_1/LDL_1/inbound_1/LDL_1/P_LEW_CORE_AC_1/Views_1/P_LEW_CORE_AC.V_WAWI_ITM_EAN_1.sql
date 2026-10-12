CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_WAWI_ITM_EAN_1 (
   client_id                                COMMENT 'DWH-Mandant_1; FK auf CLIENT; table name before the trans-all migration: client_id'
  ,item_sid                                 COMMENT 'Systemgenerierte Artikelnummer; table name before the trans-all migration: item_sid'
  ,dat_rec_start                            COMMENT 'column name before the trans-all migration: dat_rec_start'
  ,dat_rec_end                              COMMENT 'column name before the trans-all migration: dat_rec_end'
  ,ean_1                                      COMMENT 'column name before the trans-all migration: ean_1'
  ,ean_item_desc                            COMMENT 'column name before the trans-all migration: ean_item_desc'
  ,ean_item_long_descr                      COMMENT 'extended desription of the EAN_1
WAWI: ARTEANCODES.ONLINE_DESC'
  ,custom_nr                                COMMENT 'column name before the trans-all migration: custom_nr'
  ,custom_key                               COMMENT 'column name before the trans-all migration: custom_key'
  ,language_id                              COMMENT 'Sprache; table name before the trans-all migration: language_id'
  ,load_id                                  COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat; table name before the trans-all migration: load_id'
)
COMMENT = '$Revision: 5995 $. Auto Generated  9/27/2017'
AS SELECT
   client_id
  ,item_sid
  ,dat_rec_start
  ,dat_rec_end
  ,ean_1
  ,ean_item_desc
  ,ean_item_long_descr
  ,custom_nr
  ,custom_key
  ,language_id
  ,load_id
FROM P_LEW_CORE.T_WAWI_ITM_EAN_1
;