--==============================================================
-- Table: ts_nachlieferung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_nachlieferung_2
   generated from Powerdesigner on Mittwoch, 4. Mai 2022 21:07:25
*/ --------------------------------------------------------------------------------


CREATE TABLE DBP_MSI_DATA.TS_NACHLIEFERUNG_2 (
   nachlieferung_request_id            NUMBER(38,0)    DEFAULT -1 NOT NULL COMMENT 'The incremental id of this request',
   gp_exp_name                         VARCHAR(40)     COLLATE 'en-ci' DEFAULT '' NOT NULL COMMENT 'Datasuppliers-Process Name',
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_2 ID im DWH',
   wup_id                              NUMBER(38,0)    DEFAULT -99 NOT NULL COMMENT 'Store for which the data must be re_2-delivered',
   dat_start                           DATE            DEFAULT CAST('9999-12-31' AS DATE) NOT NULL COMMENT 'The starting date of the dataset which must be re_2-delivered',
   art_id                              NUMBER(38,0)    COMMENT 'Article for which data must be re_2-delivered',
   anzahl_dateien                      NUMBER(38,0)    DEFAULT 1 NOT NULL COMMENT 'Amount of files to be delivered',
   active_fg                           NUMBER(38,0)    DEFAULT 1 NOT NULL COMMENT 'Status_2 of the request - indicates if data still need to be delivered or no (1 - yes, 0 -no)',
   ldap_user                           VARCHAR(40)     DEFAULT '' NOT NULL COMMENT 'The ldap username of the person creating the request',
   gp_id                               NUMBER(38,0)    COMMENT 'ID of the partners for which we deliver data',
   periodizitaet                       VARCHAR(12)     COMMENT 'list of dates included in each exported file',
   datzeit_insert                      TIMESTAMP_LTZ(9) DEFAULT CAST('9999-12-31 00:00:00' AS TIMESTAMP_LTZ) NOT NULL COMMENT 'The time this record ( request) was created',
   datzeit_update                      TIMESTAMP_LTZ(9) COMMENT 'Time when this record (request) was updated',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_NACHLIEFERUNG PRIMARY KEY (nachlieferung_request_id, gp_exp_name, mandant_id, wup_id, dat_start) NOT ENFORCED
)  COMMENT = 'The table contains row for subsequent deliveries of data (exports) to external partners, and status_2 of these exports (pending or completed).';