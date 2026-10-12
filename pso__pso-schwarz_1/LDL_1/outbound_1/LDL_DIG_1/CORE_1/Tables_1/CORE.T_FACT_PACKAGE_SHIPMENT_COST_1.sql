/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_PACKAGE_SHIPMENT_COST_1
   GENERATED FROM POWERDESIGNER ON Mittwoch, 29. Januar 2025 11:19:42
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_package_shipment_cost_1 (
ewm_pack_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the package_1 based on the EWM API data. This surrogate key is generated based on ewm_pack_nr and pack_tracking_nr.'),
ewm_pack_nr STRING(50)
OPTIONS(description='The warehouse(SAP EWM) system number which is being used to search within the EWM system'),
pack_tracking_nr STRING(1000)
OPTIONS(description='The tracking ID which links the shipment to customer with the actual package_1 and can also be searched for within the the carrier url'),
hauler_country_cd STRING(5)
OPTIONS(description='The unique code for a country_1 where the hauler is based according to ISO-3166 Alpha-2. (e.g., DE for Germany)'),
hauler_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the hauler'),
hauler_name STRING(100) OPTIONS(description='The name by which the hauler is known'),
wh_sid BIGNUMERIC
OPTIONS(description='The unique identifier(surrogate key) of the physical warehouse that sends the package_1'),
wh_cd STRING(5) OPTIONS(description='A short unique code for the physical warehouse that sends the package_1'),
pack_size_type_cd STRING(50)
OPTIONS(description='The code for the package_1 size type  (Normal , Überlänge, XXL , Heavy etc)'),
ship_direction_cd STRING(50) OPTIONS(description='The code for the package_1 shipment direction ( Forward / Return )'),
ship_label_create_tmsp TIMESTAMP
OPTIONS(description='Technical timestamp for the creation of the shipping label within EWM (warehouse system). This timestamp also indicates when the TrackingId has been created and should therefore ne considered as start of the package_1 shipment.'),
total_ship_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='The total net cost in euro that LIDL Digital has to pay to the hauler for shipping the package.'),
total_ship_cost_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='The total net cost in local currency that LIDL Digital has to pay to the hauler for shipping the package.'),
base_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Reflects the net euro price to be paid to the carrier for a parcel based on its weight and dimensions.'),
base_cost_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Reflects the net price in local currency to be paid to the carrier for a parcel based on its weight and dimensions.'),
noncompliant_pack_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in euro which will be invoiced if the package_1 does not comply with the physical restrictions.'),
noncompliant_pack_cost_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in local currency which will be invoiced if the package_1 does not comply with the physical restrictions.'),
fuel_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in euro reflecting a floating diesel cost for the delivery. Some haulers charge an additional price for diesel fuel for deliveries transported with trucks.'),
fuel_cost_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in local currency reflecting a floating diesel cost for the delivery. Some haulers charge an additional price for diesel fuel for deliveries transported with trucks.'),
energy_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in euro reflecting the net energy costs for package_1 deliveries with electric vehicles.'),
energy_cost_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in local currency reflecting the net energy costs for package_1 deliveries with electric vehicles.'),
eco_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in euro reflecting the net cost to equalise the CO2 impact of delivering a package_1 (variable surcharge differing from hauler to hauler)'),
eco_cost_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in local currency reflecting the net cost to equalise the CO2 impact of delivering a package_1 (variable surcharge differing from hauler to hauler)'),
go_green_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in euro reflecting the net cost to equalise the CO2 impact of delivering a package_1 (fixed surcharge). Depends on the hauler - different haulers have different fixed surcharges'),
go_green_cost_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in local currency reflecting the net cost to equalise the CO2 impact of delivering a package_1 (fixed surcharge). Depends on the hauler - different haulers have different fixed surcharges'),
remote_dest_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in euro for package_1 delivery to remote locations (such as islands or mountainous areas).'),
remote_dest_cost_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in local currency for package_1 delivery to remote locations (such as islands or mountainous areas).'),
manual_handling_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in euro for package_1 shipment processing with man-power instead of conveyance.'),
manual_handling_cost_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in local currency for package_1 shipment processing with man-power instead of conveyance.'),
peak_season_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in euro for deliveries during seasonal peaks such as Christmas or Black Friday. Can vary from hauler to hauler'),
peak_season_cost_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in local currency for deliveries during seasonal peaks such as Christmas or Black Friday. Can vary from hauler to hauler.'),
security_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in euro for covering the security costs of delivery process, e.g. security cameras.'),
security_cost_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in local currency for covering the security costs of delivery process, e.g. security cameras.'),
toll_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in euro that reflects the net cost for using highways in the respective country.'),
toll_cost_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in local currency that reflects the net cost for using highways in the respective country.'),
bulky_pack_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in euro for delivery of extra heavy/volumetric packages.'),
bulky_pack_cost_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in local currency for delivery of extra heavy/volumetric packages.'),
pack_pick_up_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in euro for picking up the package_1 from the customer\'s home.'),
pack_pick_up_cost_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in local currency for picking up the package_1 from the customer\'s home.'),
unusual_pack_density_cost_net_eur_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in euro for light but huge or heavy but small packages (packages with uncommon densities). '),
unusual_pack_density_cost_net_local_val BIGNUMERIC(38,5)
OPTIONS(description='Surcharge in local currency for light but huge or heavy but small packages (packages with uncommon densities). '),
curr_cd STRING(5) OPTIONS(description='The code identifying the currency according to ISO-4217.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (ewm_pack_sid) NOT ENFORCED
)
OPTIONS(description='This table contains data coming from a new API about the shipping costs for packages sent from the warehouse to customers that LIDL Digital has to pay to the hauler. In the future, it is possible to store the data regarding the shipping costs for returns from the customer back to the warehouse. The data will be used for the process of invoice approval by LIDL Digital for invoices issued by haulers (e.g. DHL).             This table has same granularity as T_FACT_GOODS_PACKAGE_SHIPMENT_1 and T_FACT_SALES_PACKAGE_SHIPMENT.             At some point it was decided that enriching all data in T_FACT_GOODS_PACKAGE_SHIPMENT_1 will be unnecessary and would require a lot of processing time, so this table was separated and it includes only subset of all package_1 shipments. In the future this decision could be reevaluated.             T_FACT_SALES_PACKAGE_SHIPMENT_1 on the other hand contains only subset data about shipments from the warehouse to the customer and is refreshed only twice a day. The shipping costs data from the new API will need to be refreshed more frequently than that and it is planned to include shipping costs for returns in the near future, which is why a decision was made to load it in this new fact table.                          Main Source is API (EWM)..');