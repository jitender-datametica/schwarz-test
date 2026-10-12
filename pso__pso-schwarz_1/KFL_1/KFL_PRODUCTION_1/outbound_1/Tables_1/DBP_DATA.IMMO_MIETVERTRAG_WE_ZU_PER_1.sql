--==============================================================
-- Table: immo_mietvertrag_we_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_mietvertrag_we_zu_per_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.immo_mietvertrag_we_zu_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
mv_intreno STRING(20) NOT NULL OPTIONS(description='Interner Schlüssel des Immobilienobjekts'),
we_intreno STRING(20) NOT NULL OPTIONS(description='Interner Schlüssel der Wirtschaftseinheit'),
dat_von DATE NOT NULL OPTIONS(description='Datum: Beziehung gültig ab'),
dat_bis DATE NOT NULL OPTIONS(description='Datum: Beziehung gültig bis'),
zuordnung_info_kz STRING(1) NOT NULL OPTIONS(description='Intreno der Wirtschaftseinheit'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, mv_intreno, we_intreno, dat_von) NOT ENFORCED
)
OPTIONS(description='IMMO - Zuordnung Mietvertrag zu Wirtschaftseinheit - SAP REFX - ZBI_RE_DATA_CN_OBJECT_REL_VICNCN');