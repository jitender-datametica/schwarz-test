--==============================================================
-- Table: immo_mietvertrag_sicherheit_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_mietvertrag_sicherheit_1
   generated from Powerdesigner on Mittwoch, 30. November 2022 14:47:14
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMMO_MIETVERTRAG_SICHERHEIT_1 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH',
   mv_intreno                          VARCHAR(20)     COLLATE 'en-ci' NOT NULL COMMENT 'Interner Schlüssel des Immobilienobjekts',
   sicherheit_lfd_nr                   INTEGER    NOT NULL COMMENT 'Position innerhalb der Gruppe_1',
   beschreibung                        VARCHAR(60)     COLLATE 'en-ci' NOT NULL COMMENT 'Beschreibung Sicherheiten',
   sicherheit_typ                      INTEGER    NOT NULL COMMENT 'Art_1 der Sicherheit',
   dat_bis                             DATE            NOT NULL COMMENT 'Datum: Gültig bis',
   betrag_soll                         NUMBER(29,2)    NOT NULL COMMENT 'Sollbetrag Sicherheiten',
   soll_wrg_id                         VARCHAR(3)      COMMENT 'Kurzbezeichnung der  Währung für den Soll-Betrag, z.B. CZK, EUR',
   betrag_ist                          NUMBER(29,2)    NOT NULL COMMENT 'Istbetrag Sicherheiten',
   ist_wrg_id                          VARCHAR(3)      NOT NULL COMMENT 'Kurzbezeichnung der  Währung für den Ist-Betrag, z.B. CZK, EUR',
   dat_eingeloest_am                   DATE            NOT NULL COMMENT 'Datum Sicherheit eingelöst am',
   dat_rueckgabe_am                    DATE            NOT NULL COMMENT 'Datum Rückgabe Sicherheit',
   dat_eingang_am                      DATE            NOT NULL COMMENT 'Eingang Sicherheit bei KL',
   dat_uebergabe_am                    DATE            NOT NULL COMMENT 'Datum Übergabe an Begünstigten',
   buergschaft_nr                      VARCHAR(60)     COLLATE 'en-ci' NOT NULL COMMENT 'Bürgschaftsnummer',
   buergschaft_grund                   VARCHAR(60)     COLLATE 'en-ci' NOT NULL COMMENT 'Bürgschaftsgrund',
   rueckgabe_voraussetzung             VARCHAR(60)     COLLATE 'en-ci' NOT NULL COMMENT 'Rückgabevoraussetzung',
   bank_id                             VARCHAR(10)     COLLATE 'en-ci' COMMENT 'Banknummer',
   kaution_bez                         VARCHAR(80)     COLLATE 'en-ci' COMMENT 'Kautionsbezeichnung',
   dat_ausstellung_am                  DATE            COMMENT 'Deposit Issue Datum',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMMO_MIETVERTRAG_SICHERHEIT PRIMARY KEY (mandant_id, mv_intreno, sicherheit_lfd_nr) NOT ENFORCED
)  COMMENT = 'IMMO - Mietvertrag Mietsicherheiten / Bürgschaften - SAP REFX - ZBI_V_DEPOSIT';
