--==============================================================
-- Table: flw_kalk_erzeugnis_det_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_kalk_erzeugnis_det_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_kalk_erzeugnis_det_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
kalk_id INTEGER NOT NULL OPTIONS(description='Kalkulationsnummer aus kalnr'),
kalkulationsart_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID der Kalkulationsart aus kalka. Schlüssel, der die interne Steuerung der Kalkulationsanwendung steuert (Bezugsobjekt z.B. Material, Musterkalkulation, Auftrag, Projekt). Die Kalkulationsart wird in der Kalkulationsvariante hinterlegt.'),
bewertung_variante_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bewertungsvariante aus bwvar'),
kalk_version_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalkulationsversion aus tvers'),
vorstufe_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ist = 1, wenn Vorstufe, sonst 0 aus kkzst'),
dat_kalk DATE NOT NULL OPTIONS(description='Kalkulationsdatum (Key) - Datum, an dem die Kalkulation erstellt wurde'),
kst001 NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Mandant_2 1: Materialeinzelkosten Rohmaterial  Mandant_2 2: Materialeinzelkosten Rohmaterial  aus kst001'),
kst002 NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Mandant_2 1: MEK Verarbeitungsmaterial Mandant_2 2: --- aus kst002'),
kst003 NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Mandant_2 1: MEK Zusätze Mandant_2 2: --- aus kst003'),
kst004 NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Mandant_2 1: MEK Verpackung Mandant_2 2: --- aus kst004'),
kst005 NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Mandant_2 1: FEK Trennprozess Mandant_2 2: MEK Verarbeitungsmaterial aus kst005'),
kst006 NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Mandant_2 1: FEK Mischprozess Mandant_2 2:---  aus kst006'),
kst008 NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Mandant_2 1: Materialgemeinkosten  Mandant_2 2: --- aus kst008'),
kst009 NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Mandant_2 1: --- Mandant_2 2:  MEK Verpackung aus kst009'),
kst010 NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Mandant_2 1: Fertigungsgemeinkosten Mandant_2 2: --- aus kst010'),
kst011 NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Mandant_2 1: --- Mandant_2 2: FEK Trennprozess aus kst011'),
kst012 NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Mandant_2 1: Vertriebsgemeinkosten Mandant_2 2: --- aus kst012'),
kst013 NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Mandant_2 1: --- Mandant_2 2: FEK Mischprozess aus kst013'),
kst014 NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Mandant_2 1: Verwaltungsgemeinkosten Mandant_2 2: --- aus kst014'),
kst015 NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Mandant_2 1: --- Mandant_2 2:  Vertriebseinzelkosten aus kst015'),
kst017 NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Mandant_2 1: --- Mandant_2 2:  Materialgemeinkosten aus kst017'),
kst019 NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Mandant_2 1: --- Mandant_2 2: Fertigungsgemeinkosten aus kst019'),
kst021 NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Mandant_2 1: --- Mandant_2 2: Vertriebsgemeinkosten  aus kst021'),
kst023 NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Mandant_2 1: --- Mandant_2 2: Verwaltungsgemeinkosten aus kst023'),
kst007 NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Mandant_2 1: Vertriebseinzelkosten Mandant_2 2: MEK Zusätze aus kst007'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kalk_id, kalk_version_id, vorstufe_fg, dat_kalk) NOT ENFORCED
) OPTIONS(description='FLW - Positionsdaten zur Materialkalkulation aus keph');