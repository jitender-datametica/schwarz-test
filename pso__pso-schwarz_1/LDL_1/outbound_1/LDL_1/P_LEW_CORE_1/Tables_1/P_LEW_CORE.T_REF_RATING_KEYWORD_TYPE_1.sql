/* --------------------------------------------------------------------------------
   DDL for table: t_ref_rating_keyword_type_1
   generated from Powerdesigner on Montag, 9. Oktober 2023 16:52:37
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_rating_keyword_type_1 (
rating_keyword_type_cd STRING(100) NOT NULL
OPTIONS(description='Code for the discriminator values for keyword types used in rating.'),
rating_keyword_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the discriminator value for keyword types used in rating.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (rating_keyword_type_cd) NOT ENFORCED
)
OPTIONS(description='The minor dimension that contain keyword types used in rating ( for example Noun , Adjective , Verb , etc)');