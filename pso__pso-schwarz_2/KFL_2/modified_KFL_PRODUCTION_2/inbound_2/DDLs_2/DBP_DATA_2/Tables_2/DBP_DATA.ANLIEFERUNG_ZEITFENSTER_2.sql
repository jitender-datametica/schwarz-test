--==============================================================
-- Table: anlieferung_zeitfenster_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: anlieferung_zeitfenster_2
   generated from Powerdesigner on Tuesday, March 22, 2022 8:57:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ANLIEFERUNG_ZEITFENSTER_2 (
   mercareon_standort                  VARCHAR(255)    NOT NULL COMMENT 'Standortbezeichnung Mercareon',
   mercareon_entladestelle             VARCHAR(255)    NOT NULL COMMENT 'Entladestellenbezeichnung Mercareon
            Entladestellenbezeichnung Mercareon
            Entladestellenbezeichnung Mercareon',
   dat                                 DATE            NOT NULL COMMENT 'Datum Zeitfenster',
   zeit_2                                TIME(0)         NOT NULL COMMENT 'Uhrzeit Zeitfenster 
            (volle, halbe oder Viertelstunde)',
   anz_zf_gesamt                       INTEGER    COMMENT 'Anzahl Zeitfenster gesamt',
   anz_zf_gebucht                      INTEGER    COMMENT 'Anzahl Zeitfenster gebucht',
   anz_zf_reserviert                   INTEGER    COMMENT 'Anzahl Zeitfenster reserviert',
   anz_zf_gesperrt                     INTEGER    COMMENT 'Anzahl Zeitfenster gesperrt',
   anz_zf_frei                         INTEGER    COMMENT 'Anzahl Zeitfenster frei',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ANLIEFERUNG_ZEITFENSTER PRIMARY KEY (mercareon_standort, mercareon_entladestelle, dat, zeit_2) NOT ENFORCED
)  COMMENT = 'Mercareon Zeitfenster Report';
