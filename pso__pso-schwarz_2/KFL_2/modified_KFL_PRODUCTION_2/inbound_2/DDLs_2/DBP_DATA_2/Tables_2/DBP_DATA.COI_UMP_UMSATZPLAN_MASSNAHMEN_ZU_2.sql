--==============================================================
-- Table: coi_ump_umsatzplan_massnahmen_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: coi_ump_umsatzplan_massnahmen_zu_2
   generated from Powerdesigner on Dienstag, 20. September 2022 17:47:25
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.COI_UMP_UMSATZPLAN_MASSNAHMEN_ZU_2 CLUSTER BY (
     MANDANT_ID,
     GJ_PLAN,
     VERSION_ID 
)(
   mandant_id                          INTEGER    DEFAULT 0 NOT NULL COMMENT 'Mandant_2 im DWH',
   gj_plan                             INTEGER    NOT NULL COMMENT 'Geschaeftsjahr, Format JJJJ',
   version_id                          INTEGER    NOT NULL COMMENT 'Die Planversion eines Geschaeftsjahres (1-9)',
   wup_id                              INTEGER    NOT NULL COMMENT 'WUP_ID entspricht der Marktnummer / Fililalnummer in SAP (WERKS)',
   nb_id                               INTEGER    NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat_plan                            DATE            NOT NULL COMMENT 'Datum des Plantag für das GJ auf Land_2-Level (im Format JJJJ-MM_2-TT)',
   arthiertyp_id                       INTEGER    NOT NULL COMMENT 'Artikel_2 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   hwg_id                              INTEGER    NOT NULL COMMENT 'ID der Hauptwarengruppe',
   massnahme_art_id                    INTEGER    NOT NULL COMMENT 'Art_2 der Massnahme zur Nachvollziehbarkeit auf dne Markt / Tag_2 heruntergebrochen (1 = EK-Maßnahme ( aus coi_ump_ek_massnahme_per_2 ); 2 = Filialeffekt-Maßnahme ( coi_ump_filialeffekte_per_2 ); 3 = Immo-Maßnahme (coi_ump_wup_immo_massnahme_per_2))',
   massnahme_typ_bez                   VARCHAR(100)    COLLATE 'en-ci' NOT NULL COMMENT 'Bezeichnung des Maßnahmentyps aus den jeweiligen Quellen: EK(coi_ump_ek_massnahme_per.ek_massnahme_typ ) Filialeffekt (coi_ump_filialeffekte_per.filialeffekt_massnahme_bez); Immo (coi_ump_wup_immo_massnahme_per.immo_massnahme_bez)',
   massnahme_id                        INTEGER    NOT NULL COMMENT 'Fortlaufende Nummer, die im Beladeprozess pro EK-, Immo- resp. Filialeffekt-Maßnahme/Auswirkung gesetzt wird',
   wrg_id                              VARCHAR(3)      COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   massnahme_art_bez                   VARCHAR(100)    COLLATE 'en-ci' NOT NULL COMMENT 'Bezeichnung der Maßnahmenart 1 = EK-Maßnahme ( aus coi_ump_ek_massnahme_per_2 ); 2 = Filialeffekt-Maßnahme ( coi_ump_filialeffekte_per_2 ); 3 = Immo-Maßnahme (coi_ump_wup_immo_massnahme_per_2)',
   massnahme_auswirkung_bez            VARCHAR(100)    COLLATE 'en-ci' NOT NULL COMMENT 'Bezeichnung der Auswirkung der Maßnahme',
   faktor                              NUMBER(29,6)     DEFAULT 0 COMMENT 'Faktor in % fuer die jeweilige Maßnahme / Auswirkung',
   wert                                NUMBER(29,4)    COMMENT 'Absolutwert (pro Tag_2) fuer die jeweilige Maßnahme/Auswirkung. Befüllung optional als "Ersatz" fuer faktor, beinhaltet Werte aus "wert_kalender", "wert_immo", "wert_filialeffekt" oder "wert_ek" in sich.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_COI_UMP_UMSATZPLAN_MASSNAHMEN_ZU PRIMARY KEY (mandant_id, gj_plan, version_id, wup_id, nb_id, dat_plan, arthiertyp_id, hwg_id, massnahme_art_id, massnahme_typ_bez, massnahme_id) NOT ENFORCED
)  COMMENT = 'WWC - COI Umsatzplanung - Faktentabelle - Mappingtabelle EK- / Immo- und Filialeffektmaßnahmen zum jeweiligen Plantag (heruntergebrochen auf die massnahme_art_id / massnaheme_id)';
