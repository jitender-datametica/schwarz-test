CREATE TABLE IF NOT EXISTS ldl_data_etl_process.t_etl_pset_responsible (
division STRING(20) COLLATE 'und:ci' NOT NULL,
project STRING(100) COLLATE 'und:ci' NOT NULL,
application STRING(50) COLLATE 'und:ci',
system_group STRING(50) COLLATE 'und:ci',
interface STRING(100) COLLATE 'und:ci',
pset STRING(200) COLLATE 'und:ci' NOT NULL,
email_developer STRING(100) COLLATE 'und:ci' NOT NULL,
email_team_lead STRING(100) COLLATE 'und:ci',
email_bse STRING(100) COLLATE 'und:ci',
last_reject_at DATETIME,
dwh_created_tmsp DATETIME
);