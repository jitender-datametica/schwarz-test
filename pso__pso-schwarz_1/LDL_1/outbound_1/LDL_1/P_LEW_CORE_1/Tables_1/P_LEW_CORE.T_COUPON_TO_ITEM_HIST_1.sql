/* --------------------------------------------------------------------------------
   DDL for table: t_coupon_to_item_hist_1
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_coupon_to_item_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the DWH client / slice'),
coupon_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the Coupon (surrogate key)'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='unique identifier of the Item_1 that is linked to the coupon (surrogate key)'),
loyalty_prog_cd STRING(5) COLLATE 'und:ci' NOT NULL
OPTIONS(description='identifier of the loyalty program the coupon belongs to'),
coupon_relation_type_cd STRING(6) COLLATE 'und:ci' NOT NULL
OPTIONS(description='code identifying how the item_1 is related to the coupon'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Beziehung ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_1 angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (coupon_sid, item_sid, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id, coupon_sid
OPTIONS(description='$Revision: 0000 $. A coupon may be related to one item_1 that the customer can buy for special conditions. A coupon also may be not related to a certain item_1 if the coupon reduces the amount to pay for the whole basket case.');