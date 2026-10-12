/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table/view	|	t_wawi_int_itemnr
Description		|	WAWI table
====================================================================================================
*/

CREATE TABLE DATA.t_wawi_int_itemnr (
    CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'Client id - calculated based on the country code',
    WAWI_INSTANZ_KZL VARCHAR(3) NOT NULL,
    INT_ITEMNR VARCHAR(20) NOT NULL COMMENT 'International item number',
    ITEMNR VARCHAR(18) NOT NULL COMMENT 'National item number',
    INT_ITEMDESC VARCHAR(100) COMMENT 'German description',
    CASESIZE NUMBER(10,5) COMMENT 'Not in use (default null)',
    MODDATE TIMESTAMP_NTZ(9) COMMENT 'Last modification date',
    MODUSER VARCHAR(8) COMMENT 'Last user',
    INT_ITEMNRSHO VARCHAR(4) COMMENT 'Not in use (default null)',
    ACTIVE NUMBER(5,0) COMMENT 'Status of the link 0 = inactive; Active flag in WAWI is not checked 1 = active; Active flag in WAWI is checked',
    IS_MAIN_LINK NUMBER(1,0),
    SCN NUMBER(38,0),
    DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Load id',
    DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record created at',
    DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Record updated at',
    DWH_VALID_FROM DATE NOT NULL COMMENT 'Valid from date',
    DWH_VALID_TO DATE NOT NULL COMMENT 'Valid to date',
    DELETED_FG BOOLEAN NOT NULL COMMENT 'Flag if record is deleted',
    PRIMARY KEY(CLIENT_ID,INT_ITEMNR,ITEMNR,DWH_VALID_FROM)
)COMMENT='WAWI - HQWAWIADM.T215_INT_ITEMNR Table for linking international item numbers with national item numbers.'
;