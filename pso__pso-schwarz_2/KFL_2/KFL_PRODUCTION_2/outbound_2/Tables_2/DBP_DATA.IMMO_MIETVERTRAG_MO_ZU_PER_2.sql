--==============================================================
-- Table: immo_mietvertrag_mo_zu_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_mietvertrag_mo_zu_per_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.immo_mietvertrag_mo_zu_per_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
mv_intreno STRING(20) NOT NULL OPTIONS(description='Interner Schlüssel des Immobilienobjekts'),
mo_intreno STRING(20) NOT NULL OPTIONS(description='Intreno des Mietobjekts'),
dat_von DATE NOT NULL OPTIONS(description='Datum: Beziehung gültig ab'),
dat_bis DATE NOT NULL OPTIONS(description='Datum: Beziehung gültig bis'),
zuordnung_info_kz STRING(1) NOT NULL OPTIONS(description='Informatorische Zuordnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, mv_intreno, mo_intreno, dat_von) NOT ENFORCED
) OPTIONS(description='IMMO - Zuordnung Mietvertrag zu Mietobjekt - SAP REFX - ZBI_RE_DATA_CN_OBJECT_REL_VICNCN');