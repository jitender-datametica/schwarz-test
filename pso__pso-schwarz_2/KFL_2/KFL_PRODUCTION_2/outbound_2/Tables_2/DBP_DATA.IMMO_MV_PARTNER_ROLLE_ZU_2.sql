--==============================================================
-- Table: immo_mv_partner_rolle_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_mv_partner_rolle_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.immo_mv_partner_rolle_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
mv_intreno STRING(20) NOT NULL OPTIONS(description='Interner Schlüssel des Immobilienobjekts'),
rolle_kz STRING(7) NOT NULL OPTIONS(description='Geschäftspartner: Rolle'),
partner_id STRING(10) NOT NULL OPTIONS(description='Geschäftspartnernummer'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, mv_intreno, rolle_kz, partner_id) NOT ENFORCED
)
OPTIONS(description='IMMO - Zuordnung Partner (Zuständigkeit) zum Mietvertrag - SAP REFX - ZBI_RE_DATA_CN_IVS_PARTNER_VICNCN');