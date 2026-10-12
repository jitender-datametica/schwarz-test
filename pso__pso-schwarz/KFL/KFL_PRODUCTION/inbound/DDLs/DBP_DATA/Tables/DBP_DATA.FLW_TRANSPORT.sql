--==============================================================
-- Table: flw_transport
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_transport
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:40 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_TRANSPORT (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   tour_id                             NUMBER(38,0)     NOT NULL COMMENT 'LKW-Nummer (eind.Schlüssel) aus Feld LKW_NUM',
   werk_id                             NUMBER(38,0)     COMMENT 'Numerischer Surrogate key für das Werk aus Feld WERK',
   dat_verladung                       DATE             COMMENT 'Verladedatum aus Feld ZZPLAN_LBG',
   dat_transp_abschluss                DATE             COMMENT 'Datum aus Zeitstempel Abschluss Transport (LKW-Kopf) aus Feld TR_END',
   zeit_transp_abschluss               TIME(6)          COMMENT 'Zeit aus Zeitstempel Abschluss Transport (LKW-Kopf) aus Feld TR_END',
   route_id                            VARCHAR(6)       COLLATE 'en-ci' COMMENT 'Route aus Feld ZZROUTE',
   anz_stellplatz_soll                 NUMBER(38,0)     COMMENT 'Max. Stellplätze LKW aus Feld SOLL_SP',
   spediteur_id                        NUMBER(38,0)     COMMENT 'Nummer des Spediteurs aus Feld SPED',
   lkw_typ_id                          VARCHAR(2)       COLLATE 'en-ci' COMMENT 'LKW-Typ aus Feld LKW_TYP',
   temperatur                          NUMBER(9,6)      NOT NULL COMMENT 'LKW-Temperatur (in °Celsius) aus Feld TEMPERATUR',
   lkw_kennz_id                        VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'LKW-Kennzeichen aus Feld LKW_KENNZ',
   lkw_anh_kennz_id                    VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Anhänger-Kennzeichen aus Feld ANH_KENNZ',
   fracht_betrag_relevanz_fg           NUMBER(38,0)     NOT NULL COMMENT 'Flag Frachtkostenrelevanz aus Feld ZZFRKRL',
   rundlauf_transport_fg               NUMBER(38,0)     NOT NULL COMMENT 'Flag Kennzeichen: Rundlauf aus Feld RUNDL',
   hauspost_fg                         NUMBER(38,0)     NOT NULL COMMENT 'Flag Kennzeichen: Hauspost aus Feld HAUSP',
   kommentar1                          VARCHAR(80)      COLLATE 'en-ci' COMMENT 'Freitext1 im Transportkopf aus Feld FREI_TXT1',
   kommentar2                          VARCHAR(80)      COLLATE 'en-ci' COMMENT 'Freitext2 im Transportkopf aus Feld FREI_TXT2',
   kommentar3                          VARCHAR(80)      COLLATE 'en-ci' COMMENT 'Freitext3 im Transportkopf aus Feld FREI_TXT3',
   kommentar4                          VARCHAR(80)      COLLATE 'en-ci' COMMENT 'Freitext4 im Transportkopf aus Feld FREI_TXT4',
   dat_plan_verladung                  DATE             NOT NULL COMMENT 'Uhrzeit geplante Verladung der Ware aus Feld ZZPLAN_LBG',
   zeit_plan_verladung                 TIME(6)          COMMENT 'Datum geplante Verladung der Ware aus Feld ZZPLAN_LBG',
   dat_plan_ablade                     DATE             COMMENT 'Geplantes Abladedatum aus Feld ZZPLAN_ABL',
   zeit_plan_ablade                    TIME(6)          COMMENT 'Geplante Abladezeit aus Feld ZZPLAN_ABL',
   lkw_status_id                       NUMBER(38,0)     NOT NULL COMMENT 'Gesamtstatus LKW (Transportkopf) aus Feld STATUS',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_TRANSPORT PRIMARY KEY (mandant_id, tour_id) NOT ENFORCED
)  COMMENT = 'FLW - LKW-Kopfdaten (Transport) - SAP FLW (P21) - ZFW_TR_KOPF';

