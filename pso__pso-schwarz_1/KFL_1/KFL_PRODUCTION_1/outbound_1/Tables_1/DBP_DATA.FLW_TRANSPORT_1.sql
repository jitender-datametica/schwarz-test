--==============================================================
-- Table: flw_transport_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_transport_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:40 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_transport_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
tour_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='LKW-Nummer (eind.Schlüssel) aus Feld LKW_NUM'),
werk_id BIGNUMERIC(38,0) OPTIONS(description='Numerischer Surrogate key für das Werk aus Feld WERK'),
dat_verladung DATE OPTIONS(description='Verladedatum aus Feld ZZPLAN_LBG'),
dat_transp_abschluss DATE OPTIONS(description='Datum aus Zeitstempel Abschluss Transport (LKW-Kopf) aus Feld TR_END'),
zeit_transp_abschluss TIME OPTIONS(description='Zeit_1 aus Zeitstempel Abschluss Transport (LKW-Kopf) aus Feld TR_END'),
route_id STRING(6) COLLATE 'und:ci' OPTIONS(description='Route aus Feld ZZROUTE'),
anz_stellplatz_soll BIGNUMERIC(38,0) OPTIONS(description='Max. Stellplätze LKW aus Feld SOLL_SP'),
spediteur_id BIGNUMERIC(38,0) OPTIONS(description='Nummer des Spediteurs aus Feld SPED'),
lkw_typ_id STRING(2) COLLATE 'und:ci' OPTIONS(description='LKW-Typ aus Feld LKW_TYP'),
temperatur NUMERIC(9,6) NOT NULL OPTIONS(description='LKW-Temperatur (in °Celsius) aus Feld TEMPERATUR'),
lkw_kennz_id STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='LKW-Kennzeichen aus Feld LKW_KENNZ'),
lkw_anh_kennz_id STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Anhänger-Kennzeichen aus Feld ANH_KENNZ'),
fracht_betrag_relevanz_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Flag Frachtkostenrelevanz aus Feld ZZFRKRL'),
rundlauf_transport_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Flag Kennzeichen: Rundlauf aus Feld RUNDL'),
hauspost_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Flag Kennzeichen: Hauspost aus Feld HAUSP'),
kommentar1 STRING(80) COLLATE 'und:ci' OPTIONS(description='Freitext1 im Transportkopf aus Feld FREI_TXT1'),
kommentar2 STRING(80) COLLATE 'und:ci' OPTIONS(description='Freitext2 im Transportkopf aus Feld FREI_TXT2'),
kommentar3 STRING(80) COLLATE 'und:ci' OPTIONS(description='Freitext3 im Transportkopf aus Feld FREI_TXT3'),
kommentar4 STRING(80) COLLATE 'und:ci' OPTIONS(description='Freitext4 im Transportkopf aus Feld FREI_TXT4'),
dat_plan_verladung DATE NOT NULL OPTIONS(description='Uhrzeit geplante Verladung der Ware aus Feld ZZPLAN_LBG'),
zeit_plan_verladung TIME OPTIONS(description='Datum geplante Verladung der Ware aus Feld ZZPLAN_LBG'),
dat_plan_ablade DATE OPTIONS(description='Geplantes Abladedatum aus Feld ZZPLAN_ABL'),
zeit_plan_ablade TIME OPTIONS(description='Geplante Abladezeit aus Feld ZZPLAN_ABL'),
lkw_status_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Gesamtstatus LKW (Transportkopf) aus Feld STATUS_1'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, tour_id) NOT ENFORCED
) OPTIONS(description='FLW - LKW-Kopfdaten (Transport) - SAP FLW (P21) - ZFW_TR_KOPF');