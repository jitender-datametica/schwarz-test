--==============================================================
-- Table: art_wup_tag_denorm
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_tag_denorm
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_wup_tag_denorm (
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Hier sind nur Artikel hinterlegt, die bestimmten Kriterien genügen (dispomerkmal,kdis,listung_id)'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktnummer'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM-TT'),
aktion_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag vom Wert 1 oder 0. Wenn = 1, ist der Artikel in Aktion'),
dat_naechst_verkaufstag DATE NOT NULL
OPTIONS(description='Datum des nächsten Verkaufstages. Wird ermittelt aus planlieferzeit, Öffnungskalender und Früh/Spätmarktkennzeichen'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, wup_id, dat) NOT ENFORCED
)
OPTIONS(description='FLW - in dieser Tabelle sind denormalisiert Merkmale abgelegt. Die Tabelle wird zunächst nur für FLW- und Prognose-relevante Artikel befüllt');