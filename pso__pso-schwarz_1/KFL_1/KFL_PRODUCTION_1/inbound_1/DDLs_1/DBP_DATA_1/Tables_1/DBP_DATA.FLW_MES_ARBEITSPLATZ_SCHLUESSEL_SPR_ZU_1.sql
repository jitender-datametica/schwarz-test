--==============================================================
-- Table: flw_mes_arbeitsplatz_schluessel_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_mes_arbeitsplatz_schluessel_spr_zu_1
   generated from Powerdesigner on Mittwoch, 13. April 2022 16:32:15
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_MES_ARBEITSPLATZ_SCHLUESSEL_SPR_ZU_1 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_1 im DWH',
   flw_arbeitsplatzschluessel_id       NUMBER(38,0)    NOT NULL COMMENT 'In order to get the name of the work place we have to enter it in the table CRHD_1 and then search for the text with the object ID in the table CRTX and yes, here we only need the KTEXT.',
   spr_id                              NUMBER(38,0)    NOT NULL COMMENT 'Eindeutige Kennzeichnung der Sprache',
   flw_arbeitsplatz_bez                VARCHAR(500)    NOT NULL COMMENT 'Description of production line',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_MES_ARBEITSPLATZ_SCHLUESSEL_SPR_ZU PRIMARY KEY (mandant_id, flw_arbeitsplatzschluessel_id, spr_id, flw_arbeitsplatz_bez) NOT ENFORCED
)  COMMENT = 'this table contains translation data for  the working place allocation';
