CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tupel_mat_substitute (
tupel_mat_substitute_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Automatical generated key , like column "kl_listung_id" in table dbp_msi_data.kl_listung'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
kjwo_update BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahreswoche. Format JJJJWW'),
matching_id_parent BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Matching_id auf die sich die Substitute beziehen'),
matching_id_substitute BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Matching_id die als Substitute geeignet sind'),
rank_substitute BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Absteigendes Ranking der Wahrscheinlichkeit dass es sich um ein relevantes Substitut handelt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Quelle dbp_data.fanquote, Aufschlüsselung der Substitute');