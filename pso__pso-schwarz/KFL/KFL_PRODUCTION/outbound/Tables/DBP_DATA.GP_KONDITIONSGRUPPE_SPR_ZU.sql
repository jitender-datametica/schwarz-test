--==============================================================
-- Table: gp_konditionsgruppe_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gp_konditionsgruppe_spr_zu
   generated from Powerdesigner on Montag, 9. Oktober 2023 20:58:22
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.gp_konditionsgruppe_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
konditionsgruppe_id STRING(10) NOT NULL
OPTIONS(description='Eindeutiger Schlüssel der Konditionsgruppen(Konditionsgruppen: Sammelbecken in denen Artikel Zusammengefasst sind, die in einer ähnlichen Art und Weise eine Preisreduktion erfahren)'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
gp_konditionsgruppe_bez STRING(100)
OPTIONS(description='Semantische Beschreibung der Kombination (Konditionsgruppe_Lieferant ): ergibts sich aus der Kombination aus Lieferantennummer (gp) und Konditionsnummer(Konditiongruppe_id). Die Konditionsnummer kann mehreren Lieferantennummern zugeordnet werden, jedoch mit unterschiedlicher Bezeichnung '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, gp_id, konditionsgruppe_id, spr_id) NOT ENFORCED
)
OPTIONS(description='diese Tabelle liefert die Bezeichnung für die Kombination gp und Konditionsgruppe in verschiedenen Sprachen ');