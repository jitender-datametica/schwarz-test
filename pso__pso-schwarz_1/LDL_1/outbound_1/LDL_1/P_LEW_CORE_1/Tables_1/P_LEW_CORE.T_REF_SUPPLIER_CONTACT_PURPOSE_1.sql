CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_supplier_contact_purpose_1 (
sup_contact_purpose_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key for the contact_1 purpose from WAWI t_244_contact_type.'),
sup_contact_purpose_descr STRING(100)
OPTIONS(description='international description of the contact_1 purpose from WAWI t_244_contact_type'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (sup_contact_purpose_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. table contains purposes of supplier_1 contacts          Source: WAWI table t244_contact_type. This table contains the same information in every country_1, but the technical identifier can be differ from country_1 to country.           Therefore the information key is used to derive a sid.');