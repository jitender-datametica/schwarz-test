CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_supplier_contact_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
loc_sid_wh BIGNUMERIC(38,0) NOT NULL OPTIONS(description='warehouse, foreign key on location_1'),
sup_contact_id INTEGER NOT NULL
OPTIONS(description='ID from WAWI source table t246_contact_supplier_1, pk together with client and warehouse'),
sup_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key SUPPLIER_1'),
sup_contact_purpose_sid BIGNUMERIC(38,0)
OPTIONS(description='surrogate key for the contact_1 purpose from WAWI t_244_contact_type.'),
contact_medium_cd STRING(5) COLLATE 'und:ci' NOT NULL
OPTIONS(description='id of the media code, links to the  contact_1 medium reference table'),
contact_preference_fg BIGNUMERIC(38,0)
OPTIONS(description='preference of the contact_1 method: 1 - prefered, 0 - not prefered'),
contact_active_fg BIGNUMERIC(38,0) OPTIONS(description='0=not active, 1=active'),
contact_last_changed_dt DATE OPTIONS(description='date of the last change of the contact_1 information'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='attribute set was not delivered by source system (anymore), if deleted_fg=1'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 1900-01-01 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 9999-12-31 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (sup_contact_id, loc_sid_wh, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. table contains contact_1 informaton for suppliers          source: WAWI table t246_contact_supplier_1');