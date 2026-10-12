CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.tupel_mat_forecast_1 (
id STRING(50) NOT NULL OPTIONS(description='Unique Forecast ID'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Country_1'),
a500_kjwo_update BIGNUMERIC(38,0) NOT NULL OPTIONS(description='week definition of Sortimentstool'),
matching_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Tupel identifier'),
a51_listung_sst_pflege INTEGER OPTIONS(description='Setting of SST-Listung from Enduser'),
a52_listung_k_sst_pflege STRING(4) COLLATE 'und:ci' OPTIONS(description='Setting of KSST-Listung from Enduser'),
a426_ost_basis_pflege STRING(4) COLLATE 'und:ci' OPTIONS(description='Setting of Ost Basis Listung from Enduser'),
a427_ost_gross_pflege STRING(4) COLLATE 'und:ci' OPTIONS(description='Setting of Ost gross Listung from Enduser'),
a428_sued_ost_pflege STRING(4) COLLATE 'und:ci' OPTIONS(description='Setting of Sued-Ost Listung from Enduser'),
a429_sued_west_pflege STRING(4) COLLATE 'und:ci' OPTIONS(description='Setting of Sued-West Listung from Enduser'),
a430_west_pflege STRING(4) COLLATE 'und:ci' OPTIONS(description='Setting of West Listung from Enduser'),
a431_nord_pflege STRING(4) COLLATE 'und:ci' OPTIONS(description='Setting of Nord Listung from Enduser'),
a411_stk_rohertrag_pflege NUMERIC(18,4) OPTIONS(description='Setting of Rohertrag Stueck from Enduser'),
a412_umsatz_brutto_hochrechnung NUMERIC(18,4) OPTIONS(description='Forecast Umsatz'),
a413_absatz_hochrechnung NUMERIC(18,4) OPTIONS(description='Forecast Absatz'),
a414_rohertrag_hochrechnung NUMERIC(18,4)
OPTIONS(description='Forecast Rohertrag (A413_ABSATZ_HOCHRECHNUNG x A411_STK_ROHERTRAG_PFLEGE)'),
a415_kannibalisierungsfaktor NUMERIC(18,4) OPTIONS(description='Factor for Forecasts from Enduser'),
a50_listungsaktion STRING(255) COLLATE 'und:ci' OPTIONS(description='Impact of Forecast'),
listing_proposal_pflege STRING(255) COLLATE 'und:ci' OPTIONS(description='Input field from Enduser'),
execution_timestamp TIMESTAMP
OPTIONS(description='Timestamp of row creation done by Service Layer'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (id) NOT ENFORCED
) OPTIONS(description='Forecast Sortimentstool filled by Service Layer');