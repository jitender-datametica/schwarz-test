/* --------------------------------------------------------------------------------
   DDL for table: t_product_variant_2
   generated from Powerdesigner on Mittwoch, 6. Dezember 2023 19:12:38
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_PRODUCT_VARIANT_2 (
   prod_variant_sid                    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for a variant of a product.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   prod_sid                            NUMBER(38, 0)   COMMENT 'The unique identifier (surrogate key) for the product.',
   prod_variant_nr                     VARCHAR(500)    COMMENT 'The number which identifies the product variant. (If a GTIN is assigned, this number may be empty.)',
   gtin                                VARCHAR(14)     COMMENT 'The Global Trade Item_2 Number (GTIN) that identifies this item_2 variant.',
   prod_variant_name                   VARCHAR(500)    NOT NULL COMMENT 'The name of the product variant. It describes, in which aspects the variant differs from the product.',
   prod_variant_type_cd                VARCHAR(20)     NOT NULL COMMENT 'The code identifying the subtype discriminator for product variants.',
   weight_based_fg                     BOOLEAN         COMMENT 'An indicator showing, if the product variant is sold by weight instead of count.',
   logistic_variant_type_cd            VARCHAR(20)     COMMENT 'The code identifying the subtype discriminator for logistic variants.',
   case_size_cnt                       NUMBER(38, 0)   COMMENT 'The number of individual items that are contained in the logistic variant. (Note that the individual item_2 represents the smallest sellable unit. E.g. if a packed try of meat contains two slices, the entire tray is considered one sellable unit.)',
   sales_variant_type_cd               VARCHAR(20)     COMMENT 'The code identifying the subtype discriminator for sales_2 variants.',
   sales_variant_content_meas          NUMBER(38, 5)   COMMENT 'The content or size of the sales_2 variant. E.g. 750ml. In case the sales_2 variant consists of several units (e.g. 6 bottles with 1 liter each), this is the total content (i.e. 6 liters in this example). For weight-based products, this attribute is empty.',
   unit_cnt                            NUMBER(38, 0)   COMMENT 'In case the sales_2 variant consists of several units, this is the number of units, which are contained in the sales_2 variant. E.g. for a pack of 6 bottles this is 6. For weight-based products, this attribute is empty.',
   unit_content_meas                   NUMBER(38, 5)   COMMENT 'In case the sales_2 variant consists of several units, this is the content or size of a single unit. E.g. for a pack of 6 bottles of 1 liter each, this is 1 liter. For weight-based products, this attribute is empty.',
   content_uom_cd                      VARCHAR(20)     COMMENT 'The code identifying the unit_2 of measure for the content of the sales_2 variant. For weight-based products, this attribute is empty.',
   non_food_variant_type_cd            VARCHAR(20)     COMMENT 'The code identifying the subtype discriminator for non food variants.',
   size_name                           VARCHAR(500)    COMMENT 'The name for the size of the sales_2 variant. E.g. small / medium / large.',
   style_name                          VARCHAR(500)    COMMENT 'The name for the style of the sales_2 variant, e.g. the color.',
   kind_name                           VARCHAR(500)    COMMENT 'The name of the local variation of the product, e.g. for the kind of plug (European vs. UK vs. US style of plugs) or of the kind of fruits or vegetables.',
   fruits_and_vegetables_class_cd      VARCHAR(20)     COMMENT 'The code identifying the(quality) class for fruits and vegetables.',
   min_caliber_meas                    NUMBER(38, 5)   COMMENT 'The minimum size (in the indicated unit_2 of measure) for this caliber.',
   max_caliber_meas                    NUMBER(38, 5)   COMMENT 'The maximum size (in the indicated unit_2 of measure) for this caliber.',
   caliber_uom_cd                      VARCHAR(20)     COMMENT 'The code identifying the unit_2 of measure for the caliber.',
   country_of_origin_sid               NUMBER(38, 0)   COMMENT 'The unique identifier (surrogate key) for the country.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_PRODUCT_VARIANT PRIMARY KEY (prod_variant_sid, dwh_valid_from_tmsp) NOT ENFORCED
)  COMMENT= 'A product can exist in different forms, which differ from each other in one or several characteristics, e.g. with regard to the packaging unit_2 (e.g. single item_2 vs. a box with 20 items), size (S, M, L, XL, ...) or colour. The item_2 variant describes the lowest level of detail, by which the various forms of a product can be distinguished.';
