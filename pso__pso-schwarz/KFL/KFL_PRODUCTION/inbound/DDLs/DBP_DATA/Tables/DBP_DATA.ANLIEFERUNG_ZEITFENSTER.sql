--==============================================================
-- Table: anlieferung_zeitfenster
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: anlieferung_zeitfenster
   generated from Powerdesigner on Tuesday, March 22, 2022 8:57:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ANLIEFERUNG_ZEITFENSTER (
   mercareon_standort                  VARCHAR(255)    NOT NULL COMMENT 'Standortbezeichnung Mercareon',
   mercareon_entladestelle             VARCHAR(255)    NOT NULL COMMENT 'Entladestellenbezeichnung Mercareon
            Entladestellenbezeichnung Mercareon
            Entladestellenbezeichnung Mercareon',
   dat                                 DATE            NOT NULL COMMENT 'Datum Zeitfenster',
   zeit                                TIME(0)         NOT NULL COMMENT 'Uhrzeit Zeitfenster 
            (volle, halbe oder Viertelstunde)',
   anz_zf_gesamt                       NUMBER(38,0)    COMMENT 'Anzahl Zeitfenster gesamt',
   anz_zf_gebucht                      NUMBER(38,0)    COMMENT 'Anzahl Zeitfenster gebucht',
   anz_zf_reserviert                   NUMBER(38,0)    COMMENT 'Anzahl Zeitfenster reserviert',
   anz_zf_gesperrt                     NUMBER(38,0)    COMMENT 'Anzahl Zeitfenster gesperrt',
   anz_zf_frei                         NUMBER(38,0)    COMMENT 'Anzahl Zeitfenster frei',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ANLIEFERUNG_ZEITFENSTER PRIMARY KEY (mercareon_standort, mercareon_entladestelle, dat, zeit) NOT ENFORCED
)  COMMENT = 'Mercareon Zeitfenster Report';
