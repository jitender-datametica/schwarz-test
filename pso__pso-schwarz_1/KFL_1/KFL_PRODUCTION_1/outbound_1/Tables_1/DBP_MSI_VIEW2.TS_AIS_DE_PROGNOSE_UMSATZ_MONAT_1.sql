--==============================================================
-- Table: ts_ais_de_prognose_umsatz_monat_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_ais_de_prognose_umsatz_monat_1
   generated from Powerdesigner on Wednesday, 15 May 2024 20:19:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view2.ts_ais_de_prognose_umsatz_monat_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
kjmo_prognose BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Monat_1 für den die Prognose erstellt wurde.'),
abt_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Abteilungs-ID, negative Werte: im DWH generierte IDs; positive Werte: aus Stammdatensystem übernommen.'),
betrag_umsatz_prognose_bestandsmaerkte BIGNUMERIC(38,2) NOT NULL
OPTIONS(description='Umsatzprognose für alle Filialen, ausgenommen der Real2021-Übernahmefilialen.'),
betrag_umsatz_prognose_realmaerkte BIGNUMERIC(38,2) NOT NULL
OPTIONS(description='Umsatzprognose für Filialen, welche Teil der Real2021 Übernahme waren.'),
betrag_wa_kalk_prognose_bestandsmaerkte BIGNUMERIC(38,2) NOT NULL
OPTIONS(description='WA-Kalk. nach PV Prognose für alle Filialen, ausgenommen der Real2021-Übernahmefilialen.'),
betrag_wa_kalk_prognose_realmaerkte BIGNUMERIC(38,2) NOT NULL
OPTIONS(description='WA-Kalk. nach PV Prognose für Filialen, welche Teil der Real2021-Übernahme waren.'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kjmo_prognose, abt_id) NOT ENFORCED
) OPTIONS(description='AIS-DE - Monatsprognose Umsatz und WA Kalk. nach PV für EKCO DE Dossiers.');