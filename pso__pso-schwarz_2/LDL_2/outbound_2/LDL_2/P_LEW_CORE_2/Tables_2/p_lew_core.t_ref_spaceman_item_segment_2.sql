/* --------------------------------------------------------------------------------
   DDL for table: t_ref_spaceman_item_segment_2
   generated from Powerdesigner on Dienstag, 10. Januar 2023 11:00:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_spaceman_item_segment_2 (
spaceman_item_segment_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key_ item_2 segment definition in space management            spaceman:tblapproducts:DESCJ'),
spaceman_item_segment_name STRING(100)
OPTIONS(description='name of the segment of the item_2 in space management            spaceman:tblapproducts:DESCJ'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (spaceman_item_segment_sid) NOT ENFORCED
) OPTIONS(description='table contains the different spaceman item_2 segment codes');