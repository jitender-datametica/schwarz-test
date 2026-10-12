--==============================================================
-- Table: coi_ump_wup
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: coi_ump_wup
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.coi_ump_wup (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
gj_plan BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Plan-Geschäftsjahr, Format JJJJ            '),
version_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Die Planversion eines Geschäftsjahres (1-9)            '),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='WUP_ID entspricht der Marktnummer / Fililalnummer in SAP (WERKS)'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer            '),
planfiliale_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Flag für neue Filialen, welche noch keine Filialnummer erhalten haben            '),
land_level STRING(3) COLLATE 'und:ci'
OPTIONS(description='Landes-Kategorisierung (1-3 Stellen) z.B HRK für Kroatien Küste und HRL für Kroatien Land            '),
wup_standort STRING(40) COLLATE 'und:ci' DEFAULT ' '
OPTIONS(description='Filial-Ort/Bezeichnung (u.a. notwendig für neue Filialen (Plan) ohne konkrete FilialNr            (wird in der Planung vergeben))'),
dat_eroeffnung DATE
OPTIONS(description='Eröffnungs-Datum,  für Planung überschreibbar und daher separat gespeichert            '),
dat_schliessung DATE
OPTIONS(description='Schließungs-Datum, für Planung überschreibbar und daher separat gespeichert            '),
vs_id BIGNUMERIC(38,0)
OPTIONS(description='ID der Vertriebsschiene. Wird vorgefüllt aus Tabelle vs. Wird beim Einlesen des Excel über Filiale gezogen und bei Neufilialen über Excel-Eingabe            '),
wup_id_referenz BIGNUMERIC(38,0)
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
faktor_wup_referenz NUMERIC(9,6) DEFAULT 0 NOT NULL OPTIONS(description='Faktor für Referenzfiliale            '),
faktor_basis NUMERIC(9,6) DEFAULT 0 NOT NULL
OPTIONS(description='Faktor für die den Basiswert (Filiale/Referenzfilial-Wert)            '),
dat_fleisch_theke DATE OPTIONS(description='Eröffnungsdatum der Theke. Kann auch leer sein.            '),
dat_wurst_theke DATE OPTIONS(description='Eröffnungsdatum der Theke. Kann auch leer sein.            '),
dat_kaese_theke DATE OPTIONS(description='Eröffnungsdatum der Theke. Kann auch leer sein.            '),
dat_gefluegel_theke DATE OPTIONS(description='Eröffnungsdatum der Theke. Kann auch leer sein.            '),
dat_feinkost_theke DATE OPTIONS(description='Eröffnungsdatum der Theke. Kann auch leer sein.            '),
dat_fisch_theke DATE OPTIONS(description='Eröffnungsdatum der Theke. Kann auch leer sein.            '),
dat_wup_ref_von DATE
OPTIONS(description='Datum von dem ab der Referenzmarkt für die Ist-Umsätze herangezogen werden soll (im Format JJJJ-MM-TT)'),
dat_wup_ref_bis DATE
OPTIONS(description='Datum bis zu dem der Referenzmarkt für die Ist-Umsätze herangezogen werden soll (im Format JJJJ-MM-TT)'),
referenzgrund_id BIGNUMERIC(38,0)
OPTIONS(description='Die ID für den Grund warum eine Referenzfiliale herangezogen wurde'),
bereinigt_fg BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='Das FG gibt an, ob eine Filiale noch im Expansionszeitraum liegt (Start GJ_plan-1)            '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, gj_plan, version_id, wup_id, nb_id) NOT ENFORCED
)
OPTIONS(description='WWC - COI Umsatzplanung - Pflege der Filialen (inkl. Planfilialen) - Planversion abhaengig - manueller Upload');