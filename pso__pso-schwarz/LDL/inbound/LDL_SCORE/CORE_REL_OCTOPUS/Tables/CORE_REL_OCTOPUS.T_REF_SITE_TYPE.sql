CREATE TABLE CORE_REL_OCTOPUS.T_REF_SITE_TYPE (
   site_type_cd                        VARCHAR(20)     NOT NULL COMMENT 'The code for the type of site e.g. TRANS = Warenumschlagplatz..',
   site_type_descr                     VARCHAR(100)    NOT NULL COMMENT 'A textual description for the site_type_cd written out in group language (German).',
   site_type_descr_de                  VARCHAR(100)    COMMENT 'A textual description for the site_type_cd written out in German.',
   site_type_descr_en                  VARCHAR(100)    COMMENT 'A textual description for the site_type_cd written out in English.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_SITE_TYPE PRIMARY KEY (site_type_cd) NOT ENFORCED 
)  COMMENT = 'This Entity contains information about type of site. There are 5 possible types of site:
             (WH Lager, PROD Produktionsstätte, LOAD Verladestandort, TURNS Drehkreuz, HEAD Firmensitz)
             ';
