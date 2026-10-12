--==============================================================
-- Table: flw_art_monat_vw_plan
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_monat_vw_plan
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_art_monat_vw_plan (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Monat eines Kalenderjahres, Format JJJJMM'),
flw_vw_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Vertriebswegs aus vtweg'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
wa_menge_kg NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='geplante Warenausgangsmenge in KG'),
wa_menge_bme NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='geplante Warenausgangsmenge in BME            '),
wa_betrag NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='geplanter Warenausgangswert  in Währungseinheit'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (flw_art_id, kjmo, flw_vw_id, werk_id, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Planwerte für Fleischwaren pro Artikel,  Monat und Vertriebsweg. Quelle ist Hyperion HFM');