CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.sort_monat_woche_2 (
kjmo_sort BIGNUMERIC(38,0) NOT NULL,
kjwo_sort_von BIGNUMERIC(38,0) NOT NULL,
kjwo_sort_bis BIGNUMERIC(38,0) NOT NULL,
dat_sort_von DATE,
dat_sort_bis DATE,
sort_monate BIGNUMERIC(38,0) NOT NULL,
kjwo_sort_von_kpi BIGNUMERIC(38,0),
kjwo_sort_bis_kpi BIGNUMERIC(38,0),
dat_sort_von_kpi DATE,
dat_sort_bis_kpi DATE,
sort_monate_kpi BIGNUMERIC(38,0),
td_insert TIMESTAMP,
td_update TIMESTAMP
);