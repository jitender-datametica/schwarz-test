CREATE TABLE CORE_REL.T_SALES_PROMOTION_ELEMENT_1 (
   client_id                           NUMBER(38, 0)   NOT NULL COMMENT 'Unique identifier of Lidl Country_1',
   country_cd                          VARCHAR(160)    NOT NULL COMMENT 'A string-based code code for the country_1 where the promotion is taking place ',
   orig_item_nr                        NUMBER(38, 0)   NOT NULL COMMENT 'Wawi Item_1 short number. This number distinguishes one product from another, regardless of its packaging or promotional status.',
   case_size                           NUMBER(38, 5)   NOT NULL COMMENT 'Wawi Case size, denotes the quantity of an item_1 within a single case or carton.',
   promo_start_dt                      DATE            NOT NULL COMMENT 'A start date of the promotion. This date marks the beginning of the promotional period for a specific product in a stationary business (physical store).',
   pallet_factor                       NUMBER(38, 0)   COMMENT 'A numeric value representing how many cases of a product fit onto a single pallet.',
   sale_promo_status_cd                VARCHAR(50)     COMMENT 'The unique code for the status_1 of a promotion/delivery, indicates the current status_1 of the promotional campaign. The code could represent different stages, such as ''Active'', ''Planned'', ''Completed'', or ''Cancelled''.',
   ian_nr                              NUMBER(38, 0)   COMMENT 'In AMC system there is a one-to-many relationship between product number and ian number - AMC users can create ian numbers in the system. Sometimes these ian numbers don''t match the SAP ian numbers.',
   base_sales_prod_cnt                 NUMBER(38, 0)   COMMENT 'This column represents the base sales_1 count of a product, which is the number of units sold under normal, non-promotional conditions. It provides a baseline for comparing sales_1 performance during a promotion.',
   promo_sales_prod_cnt                NUMBER(38, 0)   COMMENT 'This column represents the promotional sales_1 count of a product. It is the number of units sold during the promotional period. ',
   promo_factor                        NUMBER(38, 0)   COMMENT 'Specifies the factor by which the sale of all sales_1 plans is to be increased compared to a reference period.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   CONSTRAINT PK_T_SALES_PROMOTION_ELEMENT PRIMARY KEY (country_cd, orig_item_nr, case_size, promo_start_dt) NOT ENFORCED
 )  COMMENT= 'This table is designed to store and manage information about various promotional campaigns run for specific goods in retail shops. It serves as a central hub for tracking campaign details, their duration, associated products, and the type of promotion. ';
