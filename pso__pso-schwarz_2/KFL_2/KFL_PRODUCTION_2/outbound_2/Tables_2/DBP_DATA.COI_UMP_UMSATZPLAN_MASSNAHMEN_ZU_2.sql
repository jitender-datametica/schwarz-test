--==============================================================
-- Table: coi_ump_umsatzplan_massnahmen_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: coi_ump_umsatzplan_massnahmen_zu_2
   generated from Powerdesigner on Dienstag, 20. September 2022 17:47:25
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.coi_ump_umsatzplan_massnahmen_zu_2 (
mandant_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Mandant_2 im DWH'),
gj_plan BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschaeftsjahr, Format JJJJ'),
version_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Die Planversion eines Geschaeftsjahres (1-9)'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='WUP_ID entspricht der Marktnummer / Fililalnummer in SAP (WERKS)'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat_plan DATE NOT NULL OPTIONS(description='Datum des Plantag für das GJ auf Land_2-Level (im Format JJJJ-MM_2-TT)'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
hwg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Hauptwarengruppe'),
massnahme_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Art_2 der Massnahme zur Nachvollziehbarkeit auf dne Markt / Tag_2 heruntergebrochen (1 = EK-Maßnahme ( aus coi_ump_ek_massnahme_per_2 ); 2 = Filialeffekt-Maßnahme ( coi_ump_filialeffekte_per_2 ); 3 = Immo-Maßnahme (coi_ump_wup_immo_massnahme_per_2))'),
massnahme_typ_bez STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung des Maßnahmentyps aus den jeweiligen Quellen: EK(coi_ump_ek_massnahme_per.ek_massnahme_typ ) Filialeffekt (coi_ump_filialeffekte_per.filialeffekt_massnahme_bez); Immo (coi_ump_wup_immo_massnahme_per.immo_massnahme_bez)'),
massnahme_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fortlaufende Nummer, die im Beladeprozess pro EK-, Immo- resp. Filialeffekt-Maßnahme/Auswirkung gesetzt wird'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
massnahme_art_bez STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung der Maßnahmenart 1 = EK-Maßnahme ( aus coi_ump_ek_massnahme_per_2 ); 2 = Filialeffekt-Maßnahme ( coi_ump_filialeffekte_per_2 ); 3 = Immo-Maßnahme (coi_ump_wup_immo_massnahme_per_2)'),
massnahme_auswirkung_bez STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung der Auswirkung der Maßnahme'),
faktor NUMERIC(9,6) DEFAULT 0 OPTIONS(description='Faktor in % fuer die jeweilige Maßnahme / Auswirkung'),
wert NUMERIC(18,4)
OPTIONS(description='Absolutwert (pro Tag_2) fuer die jeweilige Maßnahme/Auswirkung. Befüllung optional als "Ersatz" fuer faktor, beinhaltet Werte aus "wert_kalender", "wert_immo", "wert_filialeffekt" oder "wert_ek" in sich.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, gj_plan, version_id, wup_id, nb_id, dat_plan, arthiertyp_id, hwg_id, massnahme_art_id,
 massnahme_id) NOT ENFORCED
) CLUSTER BY mandant_id, gj_plan, version_id
OPTIONS(description='WWC - COI Umsatzplanung - Faktentabelle - Mappingtabelle EK- / Immo- und Filialeffektmaßnahmen zum jeweiligen Plantag (heruntergebrochen auf die massnahme_art_id / massnaheme_id)');