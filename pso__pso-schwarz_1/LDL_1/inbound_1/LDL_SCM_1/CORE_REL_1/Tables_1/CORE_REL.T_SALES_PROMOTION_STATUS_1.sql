CREATE TABLE CORE_REL.T_SALES_PROMOTION_STATUS_1 (
   sales_promo_status_cd               VARCHAR(50)     NOT NULL COMMENT 'The unique code for the status_1 of a promotion.',
   sales_promo_status_descr            VARCHAR(250)    NOT NULL COMMENT 'The textual description for the status_1 of a promotion.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   CONSTRAINT PK_T_SALES_PROMOTION_STATUS PRIMARY KEY (sales_promo_status_cd) NOT ENFORCED
 )  COMMENT= 'The entity that describes the status_1 of a promotion.';
