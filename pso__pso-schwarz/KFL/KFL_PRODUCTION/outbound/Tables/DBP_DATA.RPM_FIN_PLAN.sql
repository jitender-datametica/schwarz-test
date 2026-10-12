--==============================================================
-- Table: rpm_fin_plan
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: rpm_fin_plan
   generated from Powerdesigner on Freitag, 23. September 2022 10:55:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.rpm_fin_plan (
fin_gruppe_hierarchie_id STRING(32) COLLATE 'und:ci' NOT NULL OPTIONS(description='Hierarchie ID der Finanzgruppe'),
dat_start DATE NOT NULL OPTIONS(description='Startdatum aus period'),
rpm_plantyp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID das Plantyps, z.Zt. zwischen 1 und 11'),
dat_von DATE NOT NULL
OPTIONS(description='Die Tabelle wird im DWH historisiert. Das Datum wird bei der Versorgung gesetzt'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
mandant_id BIGNUMERIC(38,0) OPTIONS(description='Mandant im DWH'),
betrag NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='geplanter Betrag aus amount'),
dat_bis DATE NOT NULL
OPTIONS(description='Die Tabelle wird im DWH historisiert. Das Datum wird bei der Versorgung gesetzt. Aktuelle Saetze haben das Datum 31.12.9999'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (dat_start, rpm_plantyp_id, dat_von) NOT ENFORCED
) OPTIONS(description='RPM - Finanzplandaten für rpm-Elemente aus rpm_fin_plan');