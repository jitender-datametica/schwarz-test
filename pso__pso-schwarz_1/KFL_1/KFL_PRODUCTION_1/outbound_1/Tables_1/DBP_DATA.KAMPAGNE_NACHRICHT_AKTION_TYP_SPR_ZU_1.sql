--==============================================================
-- Table: kampagne_nachricht_aktion_typ_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kampagne_nachricht_aktion_typ_spr_zu_1
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kampagne_nachricht_aktion_typ_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
nachricht_aktion_typ_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID, die die Art_1 der ausgeführten Aktion_1 angibt.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der DWH-Sprache, z.B. 22 = Deutsch, 24 = Englisch, etc.'),
nachricht_aktion_typ_bez STRING(200) NOT NULL
OPTIONS(description='Bezeichnung des Absendungaktionen in unterschiedlichen Sprachen, z. B. Gesendet, Blockiert, Zugestellt, Bounced, Geöffnet, Feedback Loop, Link geklicked, usw.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, nachricht_aktion_typ_id, spr_id) NOT ENFORCED
) OPTIONS(description='Sprachabhängige Bezeichnungen der Aktionstypen für Marketingkampagnen - manuell versorgt.');