CREATE TABLE IF NOT EXISTS ldl_score_wawi.t_wekopf_hist (
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse number. Original name: gesellschaftsnr'),
delnotenorm STRING(20)
OPTIONS(description='Standardized delivery note number without special characters and leading zeros.'),
id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID of the Goods receipt document. Unique ID pulled from the ID table'),
integra_adhoc_id BIGNUMERIC(38,0) OPTIONS(description='FK T400 INTEGRA Adhoc head'),
issue_slip STRING(30) OPTIONS(description='The column is used for delivery documents.'),
krednr STRING(7) OPTIONS(description='Supplier number'),
lagerortnr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Storage location number'),
lieferscheinnr STRING(60) OPTIONS(description='delivery receipt number'),
old_wekorrdatum DATE,
po_nr STRING(12) OPTIONS(description='Order number'),
status BIGNUMERIC(38,0) OPTIONS(description='Status: 1 = posted by DAY; 4 = booked by DHQ'),
statussatz STRING(2),
terminaljob_id BIGNUMERIC(38,0) OPTIONS(description='Reference to T604_DELIVERIES.C604_DELIVERY_ID'),
tgstatus BIGNUMERIC(38,0)
OPTIONS(description='Status for daily closing: 1 = ready to be posted by DAY; 2 = posted by DAY; 5 = booked by DHQ; 10 = Direct delivery ready for booking by DAY'),
wareneingangszeit DATETIME OPTIONS(description='Goods receipt time'),
we_art BIGNUMERIC(38,0) OPTIONS(description='Property of the data: 1 = Goods receipt; 2 = ?; 3 = return'),
wedatum DATE OPTIONS(description='Goods receipt date'),
wekorrdatum DATE OPTIONS(description='Correction date'),
wawi_instanz_kzl STRING(3) NOT NULL OPTIONS(description='Country code'),
ewm_refnr STRING(25),
scn BIGNUMERIC(38,0),
storenr INTEGER,
lia_reference STRING(30),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (wh_id, id, lagerortnr, wawi_instanz_kzl, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='WAWI - Storage of the header information of a goods receipt.');