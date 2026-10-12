/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_wawi_wekopf_2
Description		|	WAWI table
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_wawi_wekopf_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse number. Original name: gesellschaftsnr'),
delnotenorm STRING(20)
OPTIONS(description='Standardized delivery note number without special characters and leading zeros.'),
id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID of the Goods receipt document. Unique ID pulled from the ID table'),
integra_adhoc_id BIGNUMERIC(38,0) OPTIONS(description='FK T400 INTEGRA Adhoc head'),
issue_slip STRING(30) OPTIONS(description='The column is used for delivery documents.'),
krednr STRING(7) OPTIONS(description='Supplier_2 number'),
lagerortnr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Storage location_2 number'),
lieferscheinnr STRING(60) OPTIONS(description='delivery receipt number'),
old_wekorrdatum DATE OPTIONS(description=''),
po_nr STRING(12) OPTIONS(description='Order number'),
status_2 BIGNUMERIC(38,0) OPTIONS(description='Status_2: 1 = posted by DAY; 4 = booked by DHQ'),
statussatz STRING(2) OPTIONS(description=''),
terminaljob_id BIGNUMERIC(38,0) OPTIONS(description='Reference to T604_DELIVERIES.C604_DELIVERY_ID'),
tgstatus BIGNUMERIC(38,0)
OPTIONS(description='Status_2 for daily closing: 1 = ready to be posted by DAY; 2 = posted by DAY; 5 = booked by DHQ; 10 = Direct delivery ready for booking by DAY'),
wareneingangszeit DATETIME OPTIONS(description='Goods receipt time'),
we_art BIGNUMERIC(38,0) OPTIONS(description='Property of the data: 1 = Goods receipt; 2 = ?; 3 = return'),
wedatum DATE OPTIONS(description='Goods receipt date'),
wekorrdatum DATE OPTIONS(description='Correction date'),
wawi_instanz_kzl STRING(3) NOT NULL OPTIONS(description='Country_2 code'),
ewm_refnr STRING(25) OPTIONS(description=''),
scn BIGNUMERIC(38,0) OPTIONS(description=''),
storenr INTEGER OPTIONS(description=''),
lia_reference STRING(30) OPTIONS(description=''),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_id, id, lagerortnr, wawi_instanz_kzl, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='WAWI - Storage of the header information of a goods receipt.');