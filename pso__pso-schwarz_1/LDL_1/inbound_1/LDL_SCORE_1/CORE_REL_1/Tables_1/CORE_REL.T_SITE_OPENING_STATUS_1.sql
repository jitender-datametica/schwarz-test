--==============================================================
-- Table: t_site_opening_status_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_site_opening_status_1
   generated from Powerdesigner on Montag, 26. August 2024 09:05:14
*/ --------------------------------------------------------------------------------

CREATE TABLE core_rel.T_SITE_OPENING_STATUS_1 (
   cal_dt                              DATE            NOT NULL COMMENT 'Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse',
   site_sid                            NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the site.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   site_open_status_type_cd            VARCHAR(20)     NOT NULL COMMENT 'Code for the opening status_1 of the site (crossdock). ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_SITE_OPENING_STATUS PRIMARY KEY (cal_dt, site_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'Contains the opening date information of the sites (crossdocks).
             There is one record for each site and each day defining whether the site is open. ';
