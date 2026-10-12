--==============================================================
-- Table: coi_ump_tag_referenz_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: coi_ump_tag_referenz_1
   generated from Powerdesigner on Dienstag, 20. September 2022 17:35:32
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.COI_UMP_TAG_REFERENZ_1 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_1 im DWH',
   gj_plan                             NUMBER(38,0)    NOT NULL COMMENT 'Geschaeftsjahr, Format JJJJ',
   version_id                          NUMBER(38,0)    NOT NULL COMMENT 'Die Planversion eines Geschaeftsjahres (1-9)',
   land_level                          VARCHAR(3)      COLLATE 'en-ci' NOT NULL COMMENT 'Landes-Kategorisierung (1-3 Stellen) z.B HRK fuer Kroatien Kueste und HRL für Kroatien Land_1',
   dat_plan                            DATE            NOT NULL COMMENT 'Datum des Plantag für das GJ auf Land_1-Level (im Format JJJJ-MM_1-TT)',
   dat_referenz                        DATE            COMMENT 'Datum des Referenztages des Vorjahres zum Plantag (im Format JJJJ-MM_1-TT) auf Ebene Land_1-Level',
   wrg_id                              VARCHAR(3)      COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   faktor_kalender                     NUMBER(14,10)   COMMENT 'Faktor in % fuer den Referenztag der Umsatzplanung (Auf- / Abschlag zum dat_referenz).',
   wert_kalender                       NUMBER(18,4)    COMMENT 'Absolutwert fuer den Referenztag der Umsatzplanung (entweder faktor_kalender in % oder wert_kalender wird gefuellt) (kommt direkt aus der Upload-Excel)',
   umsatz_netto_tag_ges                NUMBER(18,4)    COMMENT 'Ist der Gesamtwert des betroffenen Umsatzes des eingegebenen Effektes (Wert). Teilsumme des umsatz_netto_basis_2 für den angegebenen Tag_1 ueber alle hgws',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_COI_UMP_TAG_REFERENZ PRIMARY KEY (mandant_id, gj_plan, version_id, land_level, dat_plan) NOT ENFORCED
)  COMMENT = 'WWC - COI Umsatzplanung - Pflege der Referenztage Vorjahr auf Level Mandant_1 / Land_1-Level - Planversion abhaengig - manueller Upload';
