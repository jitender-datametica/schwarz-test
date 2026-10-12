CREATE TABLE CORE_REL_OCTOPUS.T_REF_BUSINESS_COUNTRY (
   bus_country_cd                      VARCHAR(2)      NOT NULL COMMENT 'A two-character code according to the business definition of Kaufland or Lidl.',
   bus_country_descr                   VARCHAR(100)    NOT NULL COMMENT 'A textual description for bus_country_cd (written out) in group language (German).',
   bus_country_descr_de                VARCHAR(100)    COMMENT 'A textual description for bus_country_cd (written out) in German.',
   bus_country_descr_en                VARCHAR(100)    COMMENT 'A textual description for bus_country_cd (written out) in English.',
   reporting_country_descr             VARCHAR(100)    COMMENT 'The code for the country which is used for the reporting tool ',
   reporting_territory_descr           VARCHAR(100)    COMMENT 'The code for the territory (Bundesland) which is used for the reporting tool ',
   link_to_nat_flag_txt                VARCHAR(1000)   COMMENT 'The reporting tool uses a small picture file to show the national flag of the business country. This attribute contains the link to this file.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_BUSINESS_COUNTRY PRIMARY KEY (bus_country_cd) NOT ENFORCED 
)  COMMENT = 'The country defined by Lidl terms. It is different from a political country e.g. Beligum and Luxemburg or Spain and its islands. In this case Lidl separates the countries by its geographical borders.';
