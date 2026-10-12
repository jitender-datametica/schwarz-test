CREATE TABLE IF NOT EXISTS szd_etl_process.t_etl_pset_responsible (
division STRING(20) NOT NULL,
project STRING(100) NOT NULL,
application STRING(50),
system_group STRING(50),
interface STRING(100),
pset STRING(200) NOT NULL,
email_developer STRING(100) NOT NULL,
email_team_lead STRING(100),
email_bse STRING(100),
last_reject_at DATETIME,
dwh_created_tmsp DATETIME
);