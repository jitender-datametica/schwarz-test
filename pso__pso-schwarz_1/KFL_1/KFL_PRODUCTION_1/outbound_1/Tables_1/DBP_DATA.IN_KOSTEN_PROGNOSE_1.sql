--==============================================================
-- Table: in_kosten_prognose_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_kosten_prognose_1
   generated from Powerdesigner on Mittwoch, 24. April 2024 15:12:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_kosten_prognose_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
in_projekt_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Projektdefinition (intern) aus pspnr'),
psp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='eindeutiger numerischer Schlüssel eines PSP-Elements. Im DWH generierte PSP-Elemente haben ein negatives Vorzeichen'),
in_wg_id STRING(10) COLLATE 'und:ci' DEFAULT '          ' NOT NULL
OPTIONS(description='Warengruppe aus dem Industriesystem. Quelle ist matkl'),
kosten_prognose_version_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kostenprognose Version aus zz_kos_kopvers'),
betrag_kosten_prognose BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Wert der Kostenprognose aus zz_kos_kopwert'),
betrag_mmk_prognose BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Mehr- Minderkosten-Schätzung aus zz_kos_mmkwer'),
betrag_zea_prognose BIGNUMERIC(38,4) DEFAULT 0 NOT NULL
OPTIONS(description='Wert offene Aufträge aus ZEA (EinzelAbruf) Quellfeld ist zz_kos_zeawer'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
dat_kosten_prognose_version DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL
OPTIONS(description='ZZ_KOS_KOPDAT - Datum der Kostenprognose (zur Version_ID)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, in_projekt_id, psp_id) NOT ENFORCED
) OPTIONS(description='IOS - Tabelle der Kostenprognosen aus der Quelle zfm_kostenprog');