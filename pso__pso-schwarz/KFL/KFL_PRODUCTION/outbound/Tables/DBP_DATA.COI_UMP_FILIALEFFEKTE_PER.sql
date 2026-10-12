--==============================================================
-- Table: coi_ump_filialeffekte_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: coi_ump_filialeffekte_per
   generated from Powerdesigner on Dienstag, 20. September 2022 17:25:03
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.coi_ump_filialeffekte_per (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
gj_plan BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschaeftsjahr, Format JJJJ'),
version_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Die Planversion eines Geschaeftsjahres (1-9)'),
land_level STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Landes-Kategorisierung (1-3 Stellen) z.B HRK für Kroatien Kueste und HRL für Kroatien Land'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='WUP_ID entspricht der Marktnummer / Fililalnummer in SAP (WERKS)'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
filialeffekt_massnahme_typ STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Von COI vorgegebene Effekte (Kannibalisierung, Wettbewerb, Infrastruktur, Vertrieb)'),
filialeffekt_auswirkung_bez STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Beschreibung der Auswirkung (Freitext). Auswirkungen koennen sich zeitlich ueberschneiden.'),
dat_filialeffekt_von DATE NOT NULL OPTIONS(description='Beginn des Effekt, der sich auf den Filialumsatz auswirkt'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
massnahme_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fortlaufende Nummer, die im Beladeprozess pro EK-, Immo- resp. Filialeffekt-Maßnahme/Auswirkung gesetzt wird'),
dat_filialeffekt_bis DATE OPTIONS(description='Ende des Effekt, der sich auf den Filialumsatz auswirkt'),
faktor_filialeffekt BIGNUMERIC(14,10)
OPTIONS(description='Faktor in % für Filialeffekte, die Auswirkung auf den Umsatz haben. Auswirkungen koennen sich zeitlich ueberschneiden. (entweder faktor_... in % oder wert_... Spalte wird gefuellt)'),
wert_filialeffekt NUMERIC(18,4)
OPTIONS(description='Absolutwert (für den kompletten Gueltigkeitszeitraum) für Filialeffekte, die Auswirkung auf den Umsatz haben. (entweder faktor_... in % oder wert_... Spalte wird gefuellt) (kommt direkt aus der Upload-Excel)'),
umsatz_netto_massnahme_ges NUMERIC(18,4)
OPTIONS(description='Ist der Gesamtwert des betroffenen Umsatzes des eingegebenen Effektes (Wert). Teilsumme des umsatz_netto_basis_3 fuer die angegebene Zeitperiode über die angegebene hwg Beschraenkung'),
bereinigt_fg BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Das FG gibt an, ob eine Filiale noch im Expansionszeitraum liegt (Start GJ_plan-1)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, gj_plan, version_id, wup_id, nb_id, dat_filialeffekt_von) NOT ENFORCED
)
OPTIONS(description='WWC - COI Umsatzplanung - Pflege der Filialeffekte pro Filiale und deren Auswirkung auf den Umsatz - Planversion abhaengig - manueller Upload');