CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_contact_medium_2 (
contact_medium_cd STRING(5) COLLATE 'und:ci' NOT NULL
OPTIONS(description='code of the contact_2 medium as used to link to the common WAWI description table'),
contact_medium_descr STRING(100)
OPTIONS(description='description of the contact_2 medium as used to link to the common WAWI description table'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH')
)
OPTIONS(description='$Revision: 0000 $. table contains types of contact_2 medias          Source: static reference, derived from WAWI table t007_description');