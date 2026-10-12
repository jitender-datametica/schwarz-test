--==============================================================
-- Table: anlieferung_zeitfenster
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: anlieferung_zeitfenster
   generated from Powerdesigner on Tuesday, March 22, 2022 8:57:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.anlieferung_zeitfenster (
mercareon_standort STRING(255) NOT NULL OPTIONS(description='Standortbezeichnung Mercareon'),
mercareon_entladestelle STRING(255) NOT NULL
OPTIONS(description='Entladestellenbezeichnung Mercareon            Entladestellenbezeichnung Mercareon            Entladestellenbezeichnung Mercareon'),
dat DATE NOT NULL OPTIONS(description='Datum Zeitfenster'),
zeit TIME NOT NULL OPTIONS(description='Uhrzeit Zeitfenster             (volle, halbe oder Viertelstunde)'),
anz_zf_gesamt BIGNUMERIC(38,0) OPTIONS(description='Anzahl Zeitfenster gesamt'),
anz_zf_gebucht BIGNUMERIC(38,0) OPTIONS(description='Anzahl Zeitfenster gebucht'),
anz_zf_reserviert BIGNUMERIC(38,0) OPTIONS(description='Anzahl Zeitfenster reserviert'),
anz_zf_gesperrt BIGNUMERIC(38,0) OPTIONS(description='Anzahl Zeitfenster gesperrt'),
anz_zf_frei BIGNUMERIC(38,0) OPTIONS(description='Anzahl Zeitfenster frei'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mercareon_standort, mercareon_entladestelle, dat, zeit) NOT ENFORCED
) OPTIONS(description='Mercareon Zeitfenster Report');