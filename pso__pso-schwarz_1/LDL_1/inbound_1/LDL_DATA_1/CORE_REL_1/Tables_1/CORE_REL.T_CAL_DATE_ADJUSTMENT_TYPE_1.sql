CREATE TABLE core_rel.T_CAL_DATE_ADJUSTMENT_TYPE_1 (
   cal_dt_adjust_type_cd               VARCHAR(20)     NOT NULL COMMENT 'A code for the rule, which defines, how a calendar_1 date is related to its equivalent day(s) in the previous year(s).',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   cal_dt_adjust_type_descr            VARCHAR(250)    NOT NULL COMMENT 'A description of the rule, how a calendar_1 date is related to its equivalent day(s) in the previous year(s).',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_CAL_DATE_ADJUSTMENT_TYPE PRIMARY KEY (cal_dt_adjust_type_cd, lang_cd) NOT ENFORCED
)  COMMENT= 'This minor entity defines the rules, which describe, how a date is related to its equivalent date(s) in the previous year(s). In case of leap years this may result in a many-to-many relationship. One rule is used on month-level. E.g. 28th of February 2021 is mapped to both 28th and 29 of February 2020. Another rule maps the 28 of February 2021 to both March 1st and March 2nd of 2019, so that the integrity of business years is maintained.';
