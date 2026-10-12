--==============================================================
-- Table: anlieferung_management
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: anlieferung_management
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.anlieferung_management (
anlieferung_id STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Buchungsnummer aus dem Mercareon System. Quellfeld ist bunum'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant'),
entladestelle_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige id einer Entladestelle / eines Gates. Wird im DWH erstellt - die Schnittstelle Mercareon liefert lediglich einen Text'),
menge_palette_gesamt BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Menge der tatsächlich gelieferten Paletten über alle Bestellungen der Buchung. Kann vom Spediteur nach der Buchung verändert werden'),
datzeit_entl_gebucht DATETIME NOT NULL
OPTIONS(description='Gebuchter Beginn der Entladung 8Entladetag + Entladezeit) aus bookingdate und bookingtime'),
datzeit_ankunft DATETIME OPTIONS(description='Ankunfttag + Ankunftzeit aus arrivaldate + arrivaltime'),
datzeit_tor DATETIME OPTIONS(description='Datum + Zeit "ans Tor gerufen" aus calltogategate und calltogatetime'),
datzeit_entl_beginn DATETIME
OPTIONS(description='Datum + Zeit Entladung Beginn aus unloadingbegindate + unloadingbegintime'),
datzeit_entl_ende DATETIME OPTIONS(description='Datum + Zeit Entladung Ende aus unloadingenddate + unloadingendtime'),
datzeit_ausfahrt DATETIME OPTIONS(description='Datum + Zeit der Ausfahrt aus daparturedate + departuretime'),
anlieferung_status1_id BIGNUMERIC(38,0) OPTIONS(description='ID des Erfassungsstatus (Wert zwischen 1 und 3)'),
anlieferung_status2_id BIGNUMERIC(38,0) OPTIONS(description='ID des Pünktlichkeitsstatus (Wert zwischen 1 und 5)'),
sako_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Sako Flag. Wird in der Versorgung aus der Bezeichnung der Entladestelle abgeleitet '),
retoure_kz STRING(1) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Retouren-Kennzeichnung. wird aus der Bezeichnung der Entladestelle abgeleitet. m = Marktretoure, L = Lieferantenretoure'),
anlieferung_spediteur_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Spediteur'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='LIS - Kopftabelle der Daten aus dem System Mercareon (gebuchte Anliefer-Zeitfenster)');