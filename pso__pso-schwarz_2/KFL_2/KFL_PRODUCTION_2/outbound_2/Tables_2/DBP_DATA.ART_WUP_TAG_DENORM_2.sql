--==============================================================
-- Table: art_wup_tag_denorm_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_tag_denorm_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_wup_tag_denorm_2 (
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Hier sind nur Artikel_2 hinterlegt, die bestimmten Kriterien genügen (dispomerkmal,kdis,listung_id)'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktnummer'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_2-TT'),
aktion_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag vom Wert 1 oder 0. Wenn = 1, ist der Artikel_2 in Aktion_2'),
dat_naechst_verkaufstag DATE NOT NULL
OPTIONS(description='Datum des nächsten Verkaufstages. Wird ermittelt aus planlieferzeit, Öffnungskalender und Früh/Spätmarktkennzeichen'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, wup_id, dat) NOT ENFORCED
)
OPTIONS(description='FLW - in dieser Tabelle sind denormalisiert Merkmale abgelegt. Die Tabelle wird zunächst nur für FLW- und Prognose-relevante Artikel_2 befüllt');