--==============================================================
-- Table: l_ssm_prozess_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_ssm_prozess_2
   generated from Powerdesigner on Montag, 14. August 2023 14:55:07
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_ssm_prozess_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
ssm_prozess_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Prozesses'),
ssm_aufwand_typ_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='ID des Aufwandstyp (z.B. Aufgabe, Minimal, Dynamisch, etc.)'),
wup_abt_id BIGNUMERIC(38,0) OPTIONS(description='ID der Abteilung innerhalb eines Marktes'),
treiber_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Eindeutige ID des Sollstunden-Modell-Treiber (Einflussgrößen auf den Personalaufwand /Tätigkeit des Marktmitarbeiter)'),
dat_von DATE OPTIONS(description='Datum im Format JJJJ-MM_2-TT'),
dat_bis DATE OPTIONS(description='Datum im Format JJJJ-MM_2-TT'),
ssm_prozess_bez STRING(80) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung des Prozesses (z.B. Warenverräumung, etc.)'),
dayforce_xrefcode STRING(50) COLLATE 'und:ci'
OPTIONS(description='Für den Export in externes Tool DayForce. Mapping Prozess zu XrefCode per Vorgabe durch DayForce'),
dayforce_xrefcode_de STRING(50) COLLATE 'und:ci'
OPTIONS(description='Für den Export in externes Tool DayForce. Mapping Prozess zu XrefCode per Vorgabe durch DayForce'),
dayforce_minimal_mapping BIGNUMERIC(38,0)
OPTIONS(description='Kennzeichnung Minimalprozess (z.B. Minimalbesetzung an Frischetheke) für Berechnung Planauslastung'),
oeffnung_laden_theken_fg BIGNUMERIC(38,0)
OPTIONS(description='Bedeutung: Prozess richtet sich an  0 = Ladenöffnung, 1 = an Thekenöffnung'),
rundung_typ_kz BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Kennzeichen gibt an auf welcher Zeitebene gerundet wird. 0=Stunde, 1=15 min; 2=30min'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, ssm_prozess_id) NOT ENFORCED
) OPTIONS(description='VIS - Sollstundenmodell - Lookuptabelle für die Prozesse');