--==============================================================
-- Table: l_kampagne_nachricht_aktion_typ
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_kampagne_nachricht_aktion_typ
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_kampagne_nachricht_aktion_typ (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
nachricht_aktion_typ_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID, die die Art der ausgeführten Aktion angibt, z. B. 1 = Gesendet 2 = Blockiert 3 = Zugestellt 4 = Bounced 5 = Geöffnet 6 = Feedback Loop 7 = Link geklicked, etc..'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, nachricht_aktion_typ_id) NOT ENFORCED
)
OPTIONS(description='Die Tabelle enthält die Referenzinformationen zu den verschiedenen Aktionstypen, die im Zusammenhang mit einer versendeten Nachricht auftreten können, z. B. Gesendet, Blockiert, Zugestellt, Geöffnet, usw.');