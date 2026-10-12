--==============================================================
-- Table: flw_mes_arbeitsplatz_schluessel
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_mes_arbeitsplatz_schluessel
   generated from Powerdesigner on Mittwoch, 13. April 2022 16:31:48
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_MES_ARBEITSPLATZ_SCHLUESSEL (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   flw_arbeitsplatzschluessel_id       INTEGER    NOT NULL COMMENT 'In order to get the name of the work place we have to enter it in the table CRHD and then search for the text with the object ID in the table CRTX and yes, here we only need the KTEXT.',
   flw_arbeitsplatz_id                 VARCHAR(8)      NOT NULL COMMENT 'identifier of the working place in production line',
   flw_werk_id                         INTEGER    NOT NULL COMMENT 'plant where the meat is processed',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_MES_ARBEITSPLATZ_SCHLUESSEL PRIMARY KEY (mandant_id, flw_arbeitsplatzschluessel_id) NOT ENFORCED
)  COMMENT = 'this table contains data for  the working place allocation';
