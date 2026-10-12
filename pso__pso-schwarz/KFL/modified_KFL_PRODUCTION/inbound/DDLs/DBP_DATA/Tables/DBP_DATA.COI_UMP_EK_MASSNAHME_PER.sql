--==============================================================
-- Table: coi_ump_ek_massnahme_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: coi_ump_ek_massnahme_per
   generated from Powerdesigner on Dienstag, 20. September 2022 17:07:38
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.COI_UMP_EK_MASSNAHME_PER (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   gj_plan                             INTEGER    NOT NULL COMMENT 'Geschaeftsjahr, Format JJJJ',
   version_id                          INTEGER    NOT NULL COMMENT 'Die Planversion eines Geschaeftsjahres (1-9)',
   land_level                          VARCHAR(3)      COLLATE 'en-ci' NOT NULL COMMENT 'Landes-Kategorisierung (1-3 Stellen) z.B HRK für Kroatien Kueste und HRL für Kroatien Land',
   vs_id                               INTEGER    NOT NULL COMMENT 'ID der Vertriebsschiene',
   wup_id                              INTEGER    NOT NULL COMMENT 'WUP_ID entspricht der Marktnummer / Fililalnummer in SAP (WERKS)',
   nb_id                               INTEGER    NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   arthiertyp_id                       INTEGER    NOT NULL COMMENT 'Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   abt_id                              INTEGER    NOT NULL COMMENT 'Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem uebernommen',
   hwg_id                              INTEGER    NOT NULL COMMENT 'ID der Hauptwarengruppe',
   ek_massnahme_typ                    VARCHAR(100)    COLLATE 'en-ci' NOT NULL COMMENT 'Gueltige sind Typen "Sortiment" und "Aktion". Bei "Aktion" darf keine abt_id gepflegt werden. Pruefung beim Import',
   dat_ek_massnahme_von                DATE            NOT NULL COMMENT 'Beginn der Maßnahme',
   wrg_id                              VARCHAR(3)      COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   massnahme_id                        INTEGER    NOT NULL COMMENT 'Fortlaufende Nummer, die im Beladeprozess pro EK-, Immo- resp. Filialeffekt-Maßnahme/Auswirkung gesetzt wird',
   ek_massnahme_bez                    VARCHAR(100)    COLLATE 'en-ci' NOT NULL COMMENT 'Bezeichnung der Maßnahme',
   dat_ek_massnahme_bis                DATE            COMMENT 'Ende der Maßnahme',
   faktor_ek                           NUMBER(38,10)   COMMENT 'Faktor für EK-Maßnahme je nach Maßnahmentyp: Aktion, Sortiment und Inflation.',
   wert_ek                             NUMBER(29,4)    COMMENT 'Absolutwert (für den kompletten Gueltigkeitszeitraum) für EK-Maßnahme je nach Maßnahmentyp: Aktion, Sortiment und Inflation. (entweder faktor_... in % oder wert_... Spalte wird gefuellt) (kommt direkt aus der Upload-Excel)',
   umsatz_netto_massnahme_ges          NUMBER(29,4)    COMMENT 'Ist der Gesamtwert des betroffenen Umsatzes des eingegebenen Effektes (Wert). Teilsumme des umsatz_netto_basis_3 (coi_ump_umsatzplan_hwg_calc) fuer die angegebene Zeitperiode ueber die angegebene hwg Beschraenkung',
   bereinigt_fg                        INTEGER    DEFAULT 0 COMMENT 'Das FG gibt an, ob eine Filiale noch im Expansionszeitraum liegt (Start GJ_plan-1)',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_COI_UMP_EK_MASSNAHME_PER PRIMARY KEY (mandant_id, gj_plan, version_id, land_level, vs_id, wup_id, nb_id, arthiertyp_id, abt_id, hwg_id, ek_massnahme_typ, dat_ek_massnahme_von) NOT ENFORCED
)  COMMENT = 'WWC - COI Umsatzplanung - Pflege der EK-Maßnahmen pro Filiale und deren Auswirkung auf den Umsatz (Maßnahmentyp: Aktion, Sortiment und Inflation) - Planversion abhaengig - manueller Upload';
