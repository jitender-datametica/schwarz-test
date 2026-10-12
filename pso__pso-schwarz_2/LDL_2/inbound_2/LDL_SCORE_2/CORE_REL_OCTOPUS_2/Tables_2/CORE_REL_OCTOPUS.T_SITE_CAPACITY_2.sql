CREATE TABLE CORE_REL_OCTOPUS.T_SITE_CAPACITY_2 (
   site_sid                            NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the site.',
   logistic_temp_cd                    VARCHAR(20)     NOT NULL COMMENT 'The code for the type of the temperature zone, e.g. TK, TL.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   site_capacity                       NUMBER          COMMENT 'Capacity of a site in the form of storage spaces.',
   site_capacity_reserve               NUMBER          COMMENT 'Additional capacity of a site in the form of storage spaces.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_SITE_CAPACITY PRIMARY KEY (site_sid, logistic_temp_cd, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'Indicates how much capacity a site still has to store goods. If the capacity is exhausted, you can also access any existing reserves of the site. ';
