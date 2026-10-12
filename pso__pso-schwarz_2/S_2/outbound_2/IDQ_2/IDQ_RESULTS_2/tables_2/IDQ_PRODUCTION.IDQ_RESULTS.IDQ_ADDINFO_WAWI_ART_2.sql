CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_wawi_art_2 (
id BIGNUMERIC(38,0) NOT NULL,
test_object_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
source_system_primary_key STRING(1000),
source_system_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
artnrvier STRING(14),
artikelnr STRING(18),
c215_int_itemnr STRING(20),
bez_lang STRING(100),
deutschtext STRING(40),
artgrupnr_beschreibung STRING(30),
artikel_familie STRING(16),
c270_listdescript STRING(1000),
c0603_reason_for_relevance STRING(250),
is_relevant BIGNUMERIC(38,0),
PRIMARY KEY (id) NOT ENFORCED
);