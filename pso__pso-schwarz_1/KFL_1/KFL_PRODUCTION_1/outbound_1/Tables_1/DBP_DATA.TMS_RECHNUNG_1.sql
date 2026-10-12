--==============================================================
-- Table: tms_rechnung_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_rechnung_1
   generated from Powerdesigner on Donnerstag, 24. April 2025 11:02:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tms_rechnung_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_rech_beleg_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der Rechnung (Rechnungsnummer). Aus plrech.beleg_nr'),
tms_rech_lfd_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='SKey für die Tabelle tms_rechnung_1 im Quellsystem. Aus plrech.rech_id'),
dat_tms_rech_beleg DATE NOT NULL OPTIONS(description='Belegdatum'),
empfaenger_tms_gp_id STRING(30) OPTIONS(description='ID des tms_gp_1, welcher hier als Empfänger auftrifft'),
empfaenger_tms_gp_typ_cd STRING(3) OPTIONS(description='Code für den tms_gp_1-Typ, welcher hier als Empfänger auftrifft'),
tms_rech_beleg_status_id BIGNUMERIC(38,0) OPTIONS(description='Status_1 des Rechnungsbelegs. 4 = offen, …'),
wrg_id STRING(12) COLLATE 'und:ci' OPTIONS(description='ISO-Währungskürzel'),
tms_rech_sammelbeleg_id STRING(30)
OPTIONS(description='Sammelbeleg-Nummer. Eine_1 Sammelbeleg-Nummer dient dazu, mehrere Einzelrechnungsnummern (Spalte: "tms_rech_beleg_id") zusammenzufassen, die gemeinsam abgerechnet werden. Wichtig: Die Sammelbeleg-Nummer bezieht sich nicht direkt auf eine_1 einzelne Einzelrechnungsnummer.'),
abrechnungslauf_id BIGNUMERIC(38,0) OPTIONS(description='Abrechnungslauf (Nummer)'),
tms_rech_storno_beleg_id BIGNUMERIC(38,0)
OPTIONS(description='Nummer des Stornobelegs(tms_rech_beleg_id) zu diesem Beleg'),
dat_storno DATE OPTIONS(description='Datum des Stornobelegs zu diesem Beleg'),
storno_fg BIGNUMERIC(38,0) OPTIONS(description='Kennzeichen, ob der Beleg storniert wurde.'),
manueller_beleg_fg BIGNUMERIC(38,0)
OPTIONS(description='Kennzeichen für einen manuell erstellten Beleg (Bei manuellen Belegen wird bei der Kostensplittung (PLAUST) anders vorgegangen!)'),
freigegeben_fg BIGNUMERIC(38,0) OPTIONS(description='Kennzeichen, ob der Beleg freigegeben wurde.'),
gedruckt_fg BIGNUMERIC(38,0) OPTIONS(description='Kennzeichen, ob der Beleg gedruckt wurde.'),
tms_dispostelle_id BIGNUMERIC(38,0) OPTIONS(description='ID des zuständigen Dispostelles für die Rechnung'),
ersteller_tms_gp_id STRING(30)
OPTIONS(description='ID des tms_gp_1, welcher hier als Ersteller des Rechnungsbelegs auftrifft'),
ersteller_tms_gp_typ_cd STRING(3)
OPTIONS(description='Code für den tms_gp_1-Typ, welcher hier als Ersteller des Rechnungsbelegs auftrifft'),
tms_rech_beleg_typ_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Typ des gespeicherten Belegs: 0 = Rechnung; 1 = Gutschrift; 2 = Offerte; 3 = Tourkosten SOLL; 4 = Tourkosten IST; 5 = Fuhrparkkosten; 6 = Tankdaten.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, system_id, tms_rech_beleg_id) NOT ENFORCED
)
OPTIONS(description='TMS - Die Tabelle enthält die Informationen über TMS-Rechnungen, einschließlich Rechnungsnummer, Empfänger, Rechnungsbetrag, Storno und Zahlungsstatus. Aus der Quelle plrech (WANKO)');