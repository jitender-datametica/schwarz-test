--==============================================================
-- Table: coi_ump_ek_massnahme_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: coi_ump_ek_massnahme_per
   generated from Powerdesigner on Dienstag, 20. September 2022 17:07:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.coi_ump_ek_massnahme_per (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
gj_plan BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschaeftsjahr, Format JJJJ'),
version_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Die Planversion eines Geschaeftsjahres (1-9)'),
land_level STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Landes-Kategorisierung (1-3 Stellen) z.B HRK für Kroatien Kueste und HRL für Kroatien Land'),
vs_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Vertriebsschiene'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='WUP_ID entspricht der Marktnummer / Fililalnummer in SAP (WERKS)'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
abt_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem uebernommen'),
hwg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Hauptwarengruppe'),
ek_massnahme_typ STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Gueltige sind Typen "Sortiment" und "Aktion". Bei "Aktion" darf keine abt_id gepflegt werden. Pruefung beim Import'),
dat_ek_massnahme_von DATE NOT NULL OPTIONS(description='Beginn der Maßnahme'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
massnahme_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fortlaufende Nummer, die im Beladeprozess pro EK-, Immo- resp. Filialeffekt-Maßnahme/Auswirkung gesetzt wird'),
ek_massnahme_bez STRING(100) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung der Maßnahme'),
dat_ek_massnahme_bis DATE OPTIONS(description='Ende der Maßnahme'),
faktor_ek BIGNUMERIC(14,10)
OPTIONS(description='Faktor für EK-Maßnahme je nach Maßnahmentyp: Aktion, Sortiment und Inflation.'),
wert_ek NUMERIC(18,4)
OPTIONS(description='Absolutwert (für den kompletten Gueltigkeitszeitraum) für EK-Maßnahme je nach Maßnahmentyp: Aktion, Sortiment und Inflation. (entweder faktor_... in % oder wert_... Spalte wird gefuellt) (kommt direkt aus der Upload-Excel)'),
umsatz_netto_massnahme_ges NUMERIC(18,4)
OPTIONS(description='Ist der Gesamtwert des betroffenen Umsatzes des eingegebenen Effektes (Wert). Teilsumme des umsatz_netto_basis_3 (coi_ump_umsatzplan_hwg_calc) fuer die angegebene Zeitperiode ueber die angegebene hwg Beschraenkung'),
bereinigt_fg BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Das FG gibt an, ob eine Filiale noch im Expansionszeitraum liegt (Start GJ_plan-1)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, gj_plan, version_id, vs_id, wup_id, nb_id, arthiertyp_id, abt_id, hwg_id, dat_ek_massnahme_von
 ) NOT ENFORCED
)
OPTIONS(description='WWC - COI Umsatzplanung - Pflege der EK-Maßnahmen pro Filiale und deren Auswirkung auf den Umsatz (Maßnahmentyp: Aktion, Sortiment und Inflation) - Planversion abhaengig - manueller Upload');