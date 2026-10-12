/* --------------------------------------------------------------------------------
   DDL for table: t_location_relocation_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_location_relocation_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Betrachtete Lokation; FK auf LOCATION_2'),
loc_sid_following BIGNUMERIC(38,0)
OPTIONS(description='Aktuelle Lokation nach Untergang der betrachteten Lokation (Fusionsgewinner) oder identisch zur betrachteten Lokation, solang diese aktiv. '),
dwh_cal_dt DATE NOT NULL
OPTIONS(description='Fusionszeitpunkt oder Ur-Erfassungszeitpunkt (Bei unbekannter Urerfassung "01.01.1900")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (loc_sid) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id
OPTIONS(description='$Revision: 0000 $. LRLO; Stellt die Fusionen der Locations dar. ;             WAWI: t_org_store_reloc             ');