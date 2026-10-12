--==============================================================
-- Table: l_ims_user_it_projekt
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_ims_user_it_projekt
   generated from Powerdesigner on Mittwoch, 19. Mai 2021 11:15:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_security.l_ims_user_it_projekt (
user_id STRING(30) NOT NULL OPTIONS(description='User-ID'),
it_projekt_id STRING(10) OPTIONS(description='Projek-ID'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description=' Mappingtabelle User zu IT_Projekte für die Security auf It_Projekt.');