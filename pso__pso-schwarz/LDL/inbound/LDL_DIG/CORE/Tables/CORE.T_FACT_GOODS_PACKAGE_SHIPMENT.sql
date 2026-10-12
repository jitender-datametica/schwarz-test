/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_GOODS_PACKAGE_SHIPMENT
   GENERATED FROM POWERDESIGNER ON Mittwoch, 16. Oktober 2024 15:50:44
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_GOODS_PACKAGE_SHIPMENT (
   PACK_SID                            NUMBER          NOT NULL COMMENT 'The unique identifier(surrogate key) of the package',
   PACK_ORDER_NR                       VARCHAR(20)     NOT NULL COMMENT 'Order number within warehouse system, which tells which articles are part of which package',
   PACK_TRACKING_NR                    VARCHAR(1000)   COMMENT 'ID, whcih links the shipment to customer with the actual package and can also be searched for within the the carrier url',
   PACK_TRACKING_URL                   VARCHAR(500)    COMMENT 'The URL which can be used in the browser to get all customer information which the carrier/hauler is providing to the customer',
   EWM_PACK_SID                        NUMBER(38,0)    COMMENT 'The unique identifier (surrogate key) for the package based on the EWM API data. This surrogate key is generated based on ewm_pack_nr and pack_tracking_nr.',
   EWM_PACK_NR                         VARCHAR(50)     COMMENT 'The warehouse (SAP EWM) system number which is being used to search within the EWM system',
   DELIVERY_ORDER_SID                  NUMBER          COMMENT 'The unique identifier (surrogate key) for delivery order ',
   PACK_ORDER_ACTUAL_CREATE_TMSP       TIMESTAMP_TZ(9) COMMENT 'Technical timestamp when the order has been created within EWM (warehouse system). This also indicates when the TrackingId has been created and is therefore the start of a Shipment',
   PACK_MATERIAL_NR                    VARCHAR(20)     COMMENT 'The packaging material number (e..g 420000026,  420000028)',
   PACK_VOLUME_UOM_SID                 NUMBER          COMMENT 'Package volume unit of measure',
   PACK_VOLUME_MEAS                    NUMBER(38, 5)   COMMENT 'Package volume',
   PACK_HEIGHT_UOM_SID                 NUMBER          COMMENT 'Package height unit of measure',
   PACK_HEIGHT_MEAS                    NUMBER(38, 5)   COMMENT 'Package height',
   PACK_WEIGHT_UOM_SID                 NUMBER          COMMENT 'Package weight unit of measure',
   PACK_WEIGHT_MEAS                    NUMBER(38, 5)   COMMENT 'Package weight',
   PACK_WIDTH_UOM_SID                  NUMBER          COMMENT 'Package width unit of measure',
   PACK_WIDTH_MEAS                     NUMBER(38, 5)   COMMENT 'Package width',
   PACK_LONGEST_LENGTH_MEAS            NUMBER(38, 5)   COMMENT 'Package length longest value',
   PACK_SHORTEST_LENGTH_MEAS           NUMBER(38, 5)   COMMENT 'Package length shortest value',
   PACK_MEAN_LENGTH_MEAS               NUMBER(38, 5)   COMMENT 'Package length mean value',
   PACK_LENGTH_UOM_SID                 NUMBER          COMMENT 'Package length unit of measure',
   PACK_LENGTH_MEAS                    NUMBER(38, 5)   COMMENT 'Package length',
   PACK_GIRTH_UOM_SID                  NUMBER          COMMENT 'Package girth unit of measure',
   PACK_GIRTH_EAST_MEAS                NUMBER(38, 5)   COMMENT 'Package girth east',
   PACK_GIRTH_WEST_MEAS                NUMBER(38, 5)   COMMENT 'Package girth West',
   IS_PRODUCTSIZE_USED_FG              BOOLEAN         COMMENT 'Discriminator which tells whether trackingId is using Article sizes or is within a Package and therefore the package size',
   DELIVERY_ORDER_NR                   VARCHAR(20)     COMMENT 'Delivery order number ',
   PACK_VOLUME_UOM_CD                  VARCHAR(5)      COMMENT 'A code for the unit of measure for volume',
   PACK_HEIGHT_UOM_CD                  VARCHAR(5)      COMMENT 'A code for the unit of measure for height',
   PACK_WEIGHT_UOM_CD                  VARCHAR(5)      COMMENT 'A code for the unit of measure for weight',
   PACK_WIDTH_UOM_CD                   VARCHAR(5)      COMMENT 'A code for the unit of measure for width',
   PACK_LENGTH_UOM_CD                  VARCHAR(5)      COMMENT 'A code for the unit of measure for length',
   PACK_GIRTH_UOM_CD                   VARCHAR(5)      COMMENT 'A code for the unit of measure for girth',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_FACT_GOODS_PACKAGE_SHIPMENT PRIMARY KEY (PACK_SID) NOT ENFORCED 
)  COMMENT = 'The transactional fact that holds the package shipment details ( including dropshipments)
             Same granularity and main source as T_FACT_SALES_PACKAGE_SHIPMENT, however this table contains less details (fewer cols) but for all package shipments.
             Delivery Order SID can be used to link this table to T_FACT_GOODS_MOVEMENT ( Delivery Orders) and see additional details, like "is this dropshipment or not"
             
             Main Src - SAP ERP, table VEKP';
