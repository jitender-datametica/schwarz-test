--==============================================================
-- Table: l_ims_user_it_projekt
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_ims_user_it_projekt
   generated from Powerdesigner on Mittwoch, 19. Mai 2021 11:15:30
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_SECURITY.l_ims_user_it_projekt (
   user_id                             VARCHAR(30)     NOT NULL COMMENT 'User-ID',
   it_projekt_id                       VARCHAR(10)     COMMENT 'Projek-ID'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = ' Mappingtabelle User zu IT_Projekte für die Security auf It_Projekt.';