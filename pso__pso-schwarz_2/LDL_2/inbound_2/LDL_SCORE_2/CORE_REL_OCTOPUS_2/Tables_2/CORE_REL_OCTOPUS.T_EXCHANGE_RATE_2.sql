CREATE TABLE CORE_REL_OCTOPUS.T_EXCHANGE_RATE_2 (
   src_curr_cd                         VARCHAR(3)      NOT NULL COMMENT 'The code identifying the currency, according to ISO 4217, that is to be converted into the target currency.',
   tgt_curr_cd                         VARCHAR(3)      NOT NULL COMMENT 'The code identifying the currency, according to ISO 4217, into which the source currency is converted.',
   exchange_rate_type_cd               VARCHAR(20)     NOT NULL COMMENT 'The code identifying the way in which one currency can be converted into another. E.g. Lidl''s reporting exchange rate, ECB rate, ...',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   exchange_rate                       NUMBER(38, 5)   NOT NULL COMMENT 'The factor by which the amount in the source currency needs to be multiplied, so that the result is in the target currency.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_EXCHANGE_RATE PRIMARY KEY (exchange_rate_type_cd, tgt_curr_cd, src_curr_cd, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'An exchange rate defines the way, how an amount in one currency can be converted into another currency. Exchange rates change frequently. Typically, there are several exchange rates for a given pair of currencies, such as a rate that his offered by a specific financial institution or the daily reference rate of the ECB.';
