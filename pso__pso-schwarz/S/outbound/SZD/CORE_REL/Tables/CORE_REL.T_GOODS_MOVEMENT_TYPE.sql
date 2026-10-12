/* --------------------------------------------------------------------------------
   DDL for table: T_GOODS_MOVEMENT_TYPE
   generated from Powerdesigner on Donnerstag, 28. November 2024 11:30:02
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_goods_movement_type (
goods_movement_type_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the movement type for goods.'),
goods_movement_type_descr STRING(250) NOT NULL OPTIONS(description='A brief description of the movement type.'),
goods_receipt_blocked_cd STRING(50)
OPTIONS(description='Descriptive attribute - a code used to signify a type of blocking for procurement'),
shopping_list_selection_param_txt STRING(1000)
OPTIONS(description='Descriptive attribute - a parameter used for selection of a list by procurement'),
booking_ref_nr STRING(250) OPTIONS(description='Descriptive attribute - a reference number used for inventory tracking'),
debit_fg BOOL NOT NULL OPTIONS(description='Flag indicating if it is booked as debit'),
credit_fg BOOL NOT NULL OPTIONS(description='Flag indicating if it is booked as credit'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (goods_movement_type_cd) NOT ENFORCED
) OPTIONS(description='Minor Entity - The types of movements for goods. - Source - Lexis');