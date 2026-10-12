--==============================================================
-- Table: tms_rechnung_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_rechnung_1
   generated from Powerdesigner on Donnerstag, 24. April 2025 11:02:31
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TMS_RECHNUNG_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_rech_beleg_id                   INTEGER     NOT NULL COMMENT 'ID der Rechnung (Rechnungsnummer). Aus plrech.beleg_nr',
   tms_rech_lfd_nr                     INTEGER     NOT NULL COMMENT 'SKey für die Tabelle tms_rechnung_1 im Quellsystem. Aus plrech.rech_id',
   dat_tms_rech_beleg                  DATE             NOT NULL COMMENT 'Belegdatum',
   empfaenger_tms_gp_id                VARCHAR(30)      COMMENT 'ID des tms_gp_1, welcher hier als Empfänger auftrifft',
   empfaenger_tms_gp_typ_cd            VARCHAR(3)       COMMENT 'Code für den tms_gp_1-Typ, welcher hier als Empfänger auftrifft',
   tms_rech_beleg_status_id            INTEGER     COMMENT 'Status_1 des Rechnungsbelegs. 4 = offen, …',
   wrg_id                              VARCHAR(12)      COLLATE 'en-ci' COMMENT 'ISO-Währungskürzel',
   tms_rech_sammelbeleg_id             VARCHAR(30)      COMMENT 'Sammelbeleg-Nummer. Eine_1 Sammelbeleg-Nummer dient dazu, mehrere Einzelrechnungsnummern (Spalte: "tms_rech_beleg_id") zusammenzufassen, die gemeinsam abgerechnet werden. Wichtig: Die Sammelbeleg-Nummer bezieht sich nicht direkt auf eine_1 einzelne Einzelrechnungsnummer.',
   abrechnungslauf_id                  INTEGER     COMMENT 'Abrechnungslauf (Nummer)',
   tms_rech_storno_beleg_id            INTEGER      COMMENT 'Nummer des Stornobelegs(tms_rech_beleg_id) zu diesem Beleg',
   dat_storno                          DATE             COMMENT 'Datum des Stornobelegs zu diesem Beleg',
   storno_fg                           INTEGER     COMMENT 'Kennzeichen, ob der Beleg storniert wurde.',
   manueller_beleg_fg                  INTEGER     COMMENT 'Kennzeichen für einen manuell erstellten Beleg (Bei manuellen Belegen wird bei der Kostensplittung (PLAUST) anders vorgegangen!)',
   freigegeben_fg                      INTEGER     COMMENT 'Kennzeichen, ob der Beleg freigegeben wurde.',
   gedruckt_fg                         INTEGER     COMMENT 'Kennzeichen, ob der Beleg gedruckt wurde.',
   tms_dispostelle_id                  INTEGER     COMMENT 'ID des zuständigen Dispostelles für die Rechnung',
   ersteller_tms_gp_id                 VARCHAR(30)      COMMENT 'ID des tms_gp_1, welcher hier als Ersteller des Rechnungsbelegs auftrifft',
   ersteller_tms_gp_typ_cd             VARCHAR(3)       COMMENT 'Code für den tms_gp_1-Typ, welcher hier als Ersteller des Rechnungsbelegs auftrifft',
   tms_rech_beleg_typ_id               INTEGER     NOT NULL COMMENT 'Typ des gespeicherten Belegs: 0 = Rechnung; 1 = Gutschrift; 2 = Offerte; 3 = Tourkosten SOLL; 4 = Tourkosten IST; 5 = Fuhrparkkosten; 6 = Tankdaten.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TMS_RECHNUNG PRIMARY KEY (mandant_id, system_id, tms_rech_beleg_id) NOT ENFORCED
)  COMMENT = 'TMS - Die Tabelle enthält die Informationen über TMS-Rechnungen, einschließlich Rechnungsnummer, Empfänger, Rechnungsbetrag, Storno und Zahlungsstatus. Aus der Quelle plrech (WANKO)';
