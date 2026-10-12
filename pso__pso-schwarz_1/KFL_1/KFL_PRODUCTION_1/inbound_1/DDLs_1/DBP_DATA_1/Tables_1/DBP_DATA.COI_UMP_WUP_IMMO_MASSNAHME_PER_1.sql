--==============================================================
-- Table: coi_ump_wup_immo_massnahme_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: coi_ump_wup_immo_massnahme_per_1
   generated from Powerdesigner on Mittwoch, 21. September 2022 15:31:36
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.COI_UMP_WUP_IMMO_MASSNAHME_PER_1 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_1 im DWH',
   gj_plan                             NUMBER(38,0)    NOT NULL COMMENT 'Geschaeftsjahr, Format JJJJ',
   version_id                          NUMBER(38,0)    NOT NULL COMMENT 'Die Planversion eines Geschaeftsjahres (1-9)',
   wup_id                              NUMBER(38,0)    NOT NULL COMMENT 'WUP_ID entspricht der Marktnummer / Fililalnummer in SAP (WERKS)',
   nb_id                               NUMBER(38,0)    NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat_immo_massnahme_von              DATE            NOT NULL COMMENT 'Datum von dem ab die Marktmodernisierungsmaßnahme durchgefuehrt wird',
   dat_immo_auswirkung_von             DATE            NOT NULL COMMENT 'Beginn der Maßnahme (mit Auswirkung auf Berechnung)',
   massnahme_id                        NUMBER(38,0)    NOT NULL COMMENT 'Fortlaufende Nummer, die im Beladeprozess pro EK-, Immo- resp. Filialeffekt-Maßnahme/Auswirkung gesetzt wird',
   dat_immo_massnahme_bis              DATE            NOT NULL COMMENT 'Datum zu dem die Marktmodernisierungsmaßnahme abgeschlossen sein soll / ist',
   dat_immo_auswirkung_bis             DATE            NOT NULL COMMENT 'Ende der Maßnahme (mit Auswirkung auf Berechnung)',
   wrg_id                              VARCHAR(3)      COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   immo_massnahme_typ                  VARCHAR(100)    COLLATE 'en-ci' NOT NULL COMMENT 'Typ der Immo Maßnahme',
   immo_auswirkung_bez                 VARCHAR(100)    COLLATE 'en-ci' NOT NULL COMMENT 'Bezeichnung der Auswirkung',
   betriebsunterbrechung_fg            NUMBER(38,0)    DEFAULT 0 NOT NULL COMMENT 'Betriebsunterbrechung -> kein Planumsatz für diesen Zeitraum',
   faktor_immo                         NUMBER(14,10)   COMMENT 'Faktor in % für Immo-Maßnahme. Zeitliche Ueberschneidungen sind nicht gueltig (Zur Klaerung: Es gibt Maßnahmen die sich ueberschneiden können.) (entweder faktor_... in % oder wert_... Spalte wird gefüllt)',
   wert_immo                           NUMBER(18,4)    COMMENT 'Absolutwert (für den kompletten Gueltigkeitszeitraum) für Immo-Maßnahme der Umsatzplanung (entweder faktor_... in % oder wert_... Spalte wird gefuellt) (kommt direkt aus der Upload-Excel)',
   umsatz_netto_massnahme_ges          NUMBER(18,4)    COMMENT 'Ist der Gesamtwert des betroffenen Umsatzes des eingegebenen Effektes (Wert). Teilsumme des umsatz_netto_basis_3 für die angegebene Zeitperiode ueber die angegebene hwg Beschränkung',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_COI_UMP_WUP_IMMO_MASSNAHME_PER PRIMARY KEY (mandant_id, gj_plan, version_id, wup_id, nb_id, dat_immo_massnahme_von, dat_immo_auswirkung_von) NOT ENFORCED
)  COMMENT = 'WWC - COI Umsatzplanung - Pflege der Immo-Maßnahmen pro Filiale und deren Auswirkung auf den Umsatz (koennen mehrere Auswirkungen pro Maßnahme sein) - Planversion abhaengig - manueller Upload';
