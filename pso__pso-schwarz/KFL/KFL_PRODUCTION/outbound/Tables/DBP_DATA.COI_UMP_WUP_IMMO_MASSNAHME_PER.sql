--==============================================================
-- Table: coi_ump_wup_immo_massnahme_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: coi_ump_wup_immo_massnahme_per
   generated from Powerdesigner on Mittwoch, 21. September 2022 15:31:36
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.coi_ump_wup_immo_massnahme_per (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
gj_plan BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschaeftsjahr, Format JJJJ'),
version_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Die Planversion eines Geschaeftsjahres (1-9)'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='WUP_ID entspricht der Marktnummer / Fililalnummer in SAP (WERKS)'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat_immo_massnahme_von DATE NOT NULL
OPTIONS(description='Datum von dem ab die Marktmodernisierungsmaßnahme durchgefuehrt wird'),
dat_immo_auswirkung_von DATE NOT NULL OPTIONS(description='Beginn der Maßnahme (mit Auswirkung auf Berechnung)'),
massnahme_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fortlaufende Nummer, die im Beladeprozess pro EK-, Immo- resp. Filialeffekt-Maßnahme/Auswirkung gesetzt wird'),
dat_immo_massnahme_bis DATE NOT NULL
OPTIONS(description='Datum zu dem die Marktmodernisierungsmaßnahme abgeschlossen sein soll / ist'),
dat_immo_auswirkung_bis DATE NOT NULL OPTIONS(description='Ende der Maßnahme (mit Auswirkung auf Berechnung)'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
immo_massnahme_typ STRING(100) COLLATE 'und:ci' NOT NULL OPTIONS(description='Typ der Immo Maßnahme'),
immo_auswirkung_bez STRING(100) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung der Auswirkung'),
betriebsunterbrechung_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Betriebsunterbrechung -> kein Planumsatz für diesen Zeitraum'),
faktor_immo BIGNUMERIC(14,10)
OPTIONS(description='Faktor in % für Immo-Maßnahme. Zeitliche Ueberschneidungen sind nicht gueltig (Zur Klaerung: Es gibt Maßnahmen die sich ueberschneiden können.) (entweder faktor_... in % oder wert_... Spalte wird gefüllt)'),
wert_immo NUMERIC(18,4)
OPTIONS(description='Absolutwert (für den kompletten Gueltigkeitszeitraum) für Immo-Maßnahme der Umsatzplanung (entweder faktor_... in % oder wert_... Spalte wird gefuellt) (kommt direkt aus der Upload-Excel)'),
umsatz_netto_massnahme_ges NUMERIC(18,4)
OPTIONS(description='Ist der Gesamtwert des betroffenen Umsatzes des eingegebenen Effektes (Wert). Teilsumme des umsatz_netto_basis_3 für die angegebene Zeitperiode ueber die angegebene hwg Beschränkung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, gj_plan, version_id, wup_id, nb_id, dat_immo_massnahme_von, dat_immo_auswirkung_von)
NOT ENFORCED
)
OPTIONS(description='WWC - COI Umsatzplanung - Pflege der Immo-Maßnahmen pro Filiale und deren Auswirkung auf den Umsatz (koennen mehrere Auswirkungen pro Maßnahme sein) - Planversion abhaengig - manueller Upload');