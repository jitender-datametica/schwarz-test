--==============================================================
-- Table: ts_nachlieferung_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_nachlieferung_1
   generated from Powerdesigner on Mittwoch, 4. Mai 2022 21:07:25
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ts_nachlieferung_1 (
nachlieferung_request_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='The incremental id of this request'),
gp_exp_name STRING(40) COLLATE 'und:ci' DEFAULT '' NOT NULL OPTIONS(description='Datasuppliers-Process Name'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 ID im DWH'),
wup_id BIGNUMERIC(38,0) DEFAULT - 99 NOT NULL OPTIONS(description='Store for which the data must be re_1-delivered'),
dat_start DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL
OPTIONS(description='The starting date of the dataset which must be re_1-delivered'),
art_id BIGNUMERIC(38,0) OPTIONS(description='Article for which data must be re_1-delivered'),
anzahl_dateien BIGNUMERIC(38,0) DEFAULT 1 NOT NULL OPTIONS(description='Amount of files to be delivered'),
active_fg BIGNUMERIC(38,0) DEFAULT 1 NOT NULL
OPTIONS(description='Status_1 of the request - indicates if data still need to be delivered or no (1 - yes, 0 -no)'),
ldap_user STRING(40) DEFAULT '' NOT NULL OPTIONS(description='The ldap username of the person creating the request'),
gp_id BIGNUMERIC(38,0) OPTIONS(description='ID of the partners for which we deliver data'),
periodizitaet STRING(12) OPTIONS(description='list of dates included in each exported file'),
datzeit_insert TIMESTAMP DEFAULT CAST('9999-12-31 00:00:00' AS TIMESTAMP)
NOT NULL OPTIONS(description='The time this record ( request) was created'),
datzeit_update TIMESTAMP OPTIONS(description='Time when this record (request) was updated'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (nachlieferung_request_id, mandant_id, wup_id, dat_start) NOT ENFORCED
)
OPTIONS(description='The table contains row for subsequent deliveries of data (exports) to external partners, and status_1 of these exports (pending or completed).');