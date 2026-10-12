CREATE TABLE CORE.T_DIM_TRAVEL_PRINT_ADVERTISEMENT (
   trav_print_adv_cd                   VARCHAR(20)     NOT NULL COMMENT 'The unique code for print advertisement',
   trav_print_adv_name                 VARCHAR(100)    COMMENT 'The name of print advertisement (e.g. seasonal flyer, theme flyer)',
   trav_print_adv_page_cnt             NUMBER          COMMENT 'The number of pages in the print advertising',
   trav_print_adv_publish_dt           DATE            COMMENT 'The date when the print advertisement been published',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_TRAVEL_PRINT_ADVERTIS PRIMARY KEY (trav_print_adv_cd)
)
COMMENT = 'This dimension defines the print advertising details for an offer';
