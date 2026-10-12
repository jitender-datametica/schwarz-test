--==============================================================
-- Table: anlieferung_management
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: anlieferung_management
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ANLIEFERUNG_MANAGEMENT (
   anlieferung_id                      VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Buchungsnummer aus dem Mercareon System. Quellfeld ist bunum',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant',
   entladestelle_id                    NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige id einer Entladestelle / eines Gates. Wird im DWH erstellt - die Schnittstelle Mercareon liefert lediglich einen Text',
   menge_palette_gesamt                NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Menge der tatsächlich gelieferten Paletten über alle Bestellungen der Buchung. Kann vom Spediteur nach der Buchung verändert werden',
   datzeit_entl_gebucht                TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Gebuchter Beginn der Entladung 8Entladetag + Entladezeit) aus bookingdate und bookingtime',
   datzeit_ankunft                     TIMESTAMP_NTZ(9) COMMENT 'Ankunfttag + Ankunftzeit aus arrivaldate + arrivaltime',
   datzeit_tor                         TIMESTAMP_NTZ(9) COMMENT 'Datum + Zeit "ans Tor gerufen" aus calltogategate und calltogatetime',
   datzeit_entl_beginn                 TIMESTAMP_NTZ(9) COMMENT 'Datum + Zeit Entladung Beginn aus unloadingbegindate + unloadingbegintime',
   datzeit_entl_ende                   TIMESTAMP_NTZ(9) COMMENT 'Datum + Zeit Entladung Ende aus unloadingenddate + unloadingendtime',
   datzeit_ausfahrt                    TIMESTAMP_NTZ(9) COMMENT 'Datum + Zeit der Ausfahrt aus daparturedate + departuretime',
   anlieferung_status1_id              NUMBER(38,0)     COMMENT 'ID des Erfassungsstatus (Wert zwischen 1 und 3)',
   anlieferung_status2_id              NUMBER(38,0)     COMMENT 'ID des Pünktlichkeitsstatus (Wert zwischen 1 und 5)',
   sako_fg                             NUMBER(38,0)     NOT NULL DEFAULT 0 COMMENT 'Sako Flag. Wird in der Versorgung aus der Bezeichnung der Entladestelle abgeleitet ',
   retoure_kz                          VARCHAR(1)       NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Retouren-Kennzeichnung. wird aus der Bezeichnung der Entladestelle abgeleitet. m = Marktretoure, L = Lieferantenretoure',
   anlieferung_spediteur_id            NUMBER(38,0)     NOT NULL COMMENT 'ID des Spediteur',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ANLIEFERUNG_MANAGEMENT PRIMARY KEY (anlieferung_id) NOT ENFORCED
)  COMMENT = 'LIS - Kopftabelle der Daten aus dem System Mercareon (gebuchte Anliefer-Zeitfenster)';

