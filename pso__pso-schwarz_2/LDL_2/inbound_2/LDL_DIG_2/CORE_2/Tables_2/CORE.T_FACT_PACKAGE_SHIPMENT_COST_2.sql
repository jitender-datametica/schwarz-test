/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_PACKAGE_SHIPMENT_COST_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 29. Januar 2025 11:19:42
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_PACKAGE_SHIPMENT_COST_2 (
   EWM_PACK_SID                        NUMERIC         NOT NULL COMMENT 'The unique identifier (surrogate key) for the package_2 based on the EWM API data. This surrogate key is generated based on ewm_pack_nr and pack_tracking_nr.',
   EWM_PACK_NR                         VARCHAR(50)     COMMENT 'The warehouse(SAP EWM) system number which is being used to search within the EWM system',
   PACK_TRACKING_NR                    VARCHAR(1000)   COMMENT 'The tracking ID which links the shipment to customer with the actual package_2 and can also be searched for within the the carrier url',
   HAULER_COUNTRY_CD                   VARCHAR(5)      COMMENT 'The unique code for a country_2 where the hauler is based according to ISO-3166 Alpha-2. (e.g., DE for Germany)',
   HAULER_SID                          NUMERIC         COMMENT 'The unique identifier (surrogate key) for the hauler',
   HAULER_NAME                         VARCHAR(100)    COMMENT 'The name by which the hauler is known',
   WH_SID                              NUMERIC         COMMENT 'The unique identifier(surrogate key) of the physical warehouse that sends the package_2',
   WH_CD                               VARCHAR(5)      COMMENT 'A short unique code for the physical warehouse that sends the package_2',
   PACK_SIZE_TYPE_CD                   VARCHAR(50)     COMMENT 'The code for the package_2 size type  (Normal , Überlänge, XXL , Heavy etc)',
   SHIP_DIRECTION_CD                   VARCHAR(50)     COMMENT 'The code for the package_2 shipment direction ( Forward / Return )',
   SHIP_LABEL_CREATE_TMSP              TIMESTAMP_LTZ(9) COMMENT 'Technical timestamp for the creation of the shipping label within EWM (warehouse system). This timestamp also indicates when the TrackingId has been created and should therefore ne considered as start of the package_2 shipment.',
   TOTAL_SHIP_COST_NET_EUR_VAL         NUMERIC(38,5)   COMMENT 'The total net cost in euro that LIDL Digital has to pay to the hauler for shipping the package.',
   TOTAL_SHIP_COST_NET_LOCAL_VAL       NUMERIC(38,5)   COMMENT 'The total net cost in local currency that LIDL Digital has to pay to the hauler for shipping the package.',
   BASE_COST_NET_EUR_VAL               NUMERIC(38,5)   COMMENT 'Reflects the net euro price to be paid to the carrier for a parcel based on its weight and dimensions.',
   BASE_COST_NET_LOCAL_VAL             NUMERIC(38,5)   COMMENT 'Reflects the net price in local currency to be paid to the carrier for a parcel based on its weight and dimensions.',
   NONCOMPLIANT_PACK_COST_NET_EUR_VAL  NUMERIC(38,5)   COMMENT 'Surcharge in euro which will be invoiced if the package_2 does not comply with the physical restrictions.',
   NONCOMPLIANT_PACK_COST_NET_LOCAL_VAL NUMERIC(38,5)   COMMENT 'Surcharge in local currency which will be invoiced if the package_2 does not comply with the physical restrictions.',
   FUEL_COST_NET_EUR_VAL               NUMERIC(38,5)   COMMENT 'Surcharge in euro reflecting a floating diesel cost for the delivery. Some haulers charge an additional price for diesel fuel for deliveries transported with trucks.',
   FUEL_COST_NET_LOCAL_VAL             NUMERIC(38,5)   COMMENT 'Surcharge in local currency reflecting a floating diesel cost for the delivery. Some haulers charge an additional price for diesel fuel for deliveries transported with trucks.',
   ENERGY_COST_NET_EUR_VAL             NUMERIC(38,5)   COMMENT 'Surcharge in euro reflecting the net energy costs for package_2 deliveries with electric vehicles.',
   ENERGY_COST_NET_LOCAL_VAL           NUMERIC(38,5)   COMMENT 'Surcharge in local currency reflecting the net energy costs for package_2 deliveries with electric vehicles.',
   ECO_COST_NET_EUR_VAL                NUMERIC(38,5)   COMMENT 'Surcharge in euro reflecting the net cost to equalise the CO2 impact of delivering a package_2 (variable surcharge differing from hauler to hauler)',
   ECO_COST_NET_LOCAL_VAL              NUMERIC(38,5)   COMMENT 'Surcharge in local currency reflecting the net cost to equalise the CO2 impact of delivering a package_2 (variable surcharge differing from hauler to hauler)',
   GO_GREEN_COST_NET_EUR_VAL           NUMERIC(38,5)   COMMENT 'Surcharge in euro reflecting the net cost to equalise the CO2 impact of delivering a package_2 (fixed surcharge). Depends on the hauler - different haulers have different fixed surcharges',
   GO_GREEN_COST_NET_LOCAL_VAL         NUMERIC(38,5)   COMMENT 'Surcharge in local currency reflecting the net cost to equalise the CO2 impact of delivering a package_2 (fixed surcharge). Depends on the hauler - different haulers have different fixed surcharges',
   REMOTE_DEST_COST_NET_EUR_VAL        NUMERIC(38,5)   COMMENT 'Surcharge in euro for package_2 delivery to remote locations (such as islands or mountainous areas).',
   REMOTE_DEST_COST_NET_LOCAL_VAL      NUMERIC(38,5)   COMMENT 'Surcharge in local currency for package_2 delivery to remote locations (such as islands or mountainous areas).',
   MANUAL_HANDLING_COST_NET_EUR_VAL    NUMERIC(38,5)   COMMENT 'Surcharge in euro for package_2 shipment processing with man-power instead of conveyance.',
   MANUAL_HANDLING_COST_NET_LOCAL_VAL  NUMERIC(38,5)   COMMENT 'Surcharge in local currency for package_2 shipment processing with man-power instead of conveyance.',
   PEAK_SEASON_COST_NET_EUR_VAL        NUMERIC(38,5)   COMMENT 'Surcharge in euro for deliveries during seasonal peaks such as Christmas or Black Friday. Can vary from hauler to hauler',
   PEAK_SEASON_COST_NET_LOCAL_VAL      NUMERIC(38,5)   COMMENT 'Surcharge in local currency for deliveries during seasonal peaks such as Christmas or Black Friday. Can vary from hauler to hauler.',
   SECURITY_COST_NET_EUR_VAL           NUMERIC(38,5)   COMMENT 'Surcharge in euro for covering the security costs of delivery process, e.g. security cameras.',
   SECURITY_COST_NET_LOCAL_VAL         NUMERIC(38,5)   COMMENT 'Surcharge in local currency for covering the security costs of delivery process, e.g. security cameras.',
   TOLL_COST_NET_EUR_VAL               NUMERIC(38,5)   COMMENT 'Surcharge in euro that reflects the net cost for using highways in the respective country.',
   TOLL_COST_NET_LOCAL_VAL             NUMERIC(38,5)   COMMENT 'Surcharge in local currency that reflects the net cost for using highways in the respective country.',
   BULKY_PACK_COST_NET_EUR_VAL         NUMERIC(38,5)   COMMENT 'Surcharge in euro for delivery of extra heavy/volumetric packages.',
   BULKY_PACK_COST_NET_LOCAL_VAL       NUMERIC(38,5)   COMMENT 'Surcharge in local currency for delivery of extra heavy/volumetric packages.',
   PACK_PICK_UP_COST_NET_EUR_VAL       NUMERIC(38,5)   COMMENT 'Surcharge in euro for picking up the package_2 from the customer''s home.',
   PACK_PICK_UP_COST_NET_LOCAL_VAL     NUMERIC(38,5)   COMMENT 'Surcharge in local currency for picking up the package_2 from the customer''s home.',
   UNUSUAL_PACK_DENSITY_COST_NET_EUR_VAL NUMERIC(38,5)   COMMENT 'Surcharge in euro for light but huge or heavy but small packages (packages with uncommon densities). ',
   UNUSUAL_PACK_DENSITY_COST_NET_LOCAL_VAL NUMERIC(38,5)   COMMENT 'Surcharge in local currency for light but huge or heavy but small packages (packages with uncommon densities). ',
   CURR_CD                             VARCHAR(5)      COMMENT 'The code identifying the currency according to ISO-4217.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_FACT_PACKAGE_SHIPMENT_COST PRIMARY KEY (EWM_PACK_SID) NOT ENFORCED 
)  COMMENT = 'This table contains data coming from a new API about the shipping costs for packages sent from the warehouse to customers that LIDL Digital has to pay to the hauler. In the future, it is possible to store the data regarding the shipping costs for returns from the customer back to the warehouse. The data will be used for the process of invoice approval by LIDL Digital for invoices issued by haulers (e.g. DHL).
             This table has same granularity as T_FACT_GOODS_PACKAGE_SHIPMENT_2 and T_FACT_SALES_PACKAGE_SHIPMENT.
             At some point it was decided that enriching all data in T_FACT_GOODS_PACKAGE_SHIPMENT_2 will be unnecessary and would require a lot of processing time, so this table was separated and it includes only subset of all package_2 shipments. In the future this decision could be reevaluated.
             T_FACT_SALES_PACKAGE_SHIPMENT_2 on the other hand contains only subset data about shipments from the warehouse to the customer and is refreshed only twice a day. The shipping costs data from the new API will need to be refreshed more frequently than that and it is planned to include shipping costs for returns in the near future, which is why a decision was made to load it in this new fact table.
             
             Main Source is API (EWM)..';
