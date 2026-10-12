--==============================================================
-- Table: in_fi_beleg_dat_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_fi_beleg_dat_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_FI_BELEG_DAT_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1',
   buchungskreis_id                    NUMBER(38,0)     NOT NULL COMMENT 'Zuordnung des Buchungskreises zu dem WUP_1 über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_1, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland',
   in_fi_beleg_id                      NUMBER(18,0)     NOT NULL COMMENT 'Belegnummer eines Buchhaltungsbelegs. Aus SAP Industrie belnr',
   in_fi_beleg_pos_id                  NUMBER(38,0)     NOT NULL COMMENT 'Belegposition eines Buchhaltungsbelegs. Aus SAP Industrie buzei',
   gj                                  NUMBER(38,0)     NOT NULL COMMENT 'Geschäftsjahr, Format JJJJ',
   dat_buch                            DATE             NOT NULL COMMENT 'Buchungsdatum der Rechnung.',
   dat_beleg                           DATE             NOT NULL COMMENT 'Belegdatum der Rechnung.',
   dat_basis                           DATE             NOT NULL COMMENT 'Basisdatum für Fälligkeitsberechnung',
   in_lief_id                          NUMBER(38,0)     COMMENT 'Lieferantennummer. Im DWH erzeugter numerischer Schlüssel',
   sonder_hauptbuch_kz                 VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Kennzeichen für die Zuordnung zu Sonderhauptbuch, z.Bsp. A = Auszahlung, P = Zahlungsaufforderung. Aus umskz',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_FI_BELEG_DAT PRIMARY KEY (mandant_id, buchungskreis_id, in_fi_beleg_id, in_fi_beleg_pos_id, gj) NOT ENFORCED
)  COMMENT = 'IMMO - Buchhaltung: Sekundärindex für Kreditoren aus der SAP-Quelle bsik';
