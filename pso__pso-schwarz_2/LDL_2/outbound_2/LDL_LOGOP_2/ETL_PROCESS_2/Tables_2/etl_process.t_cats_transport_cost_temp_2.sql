CREATE TABLE IF NOT EXISTS ldl_logop_etl_process.t_cats_transport_cost_temp_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
country_cd STRING(5) OPTIONS(description='Country_2 code (two digits). Original name: Country_2'),
rdc STRING(512) OPTIONS(description='Company name'),
rdc_id STRING(5) OPTIONS(description='Company code (three digits)'),
rdc_id_nr STRING(10)
OPTIONS(description='Company number consisting of two-digit country_2 code and four-digit company number (total of six digits)'),
carrier_name STRING(512) OPTIONS(description='Full carrier name'),
carrier_id STRING(512) OPTIONS(description='Unique forwarding ID; corresponds to the Business Partner ID from SAP'),
delivery_dt DATE OPTIONS(description='Delivery day of the tour. Original name: Date'),
cw BIGNUMERIC(38,0) OPTIONS(description='Calendar_2 week of the tour_2'),
resource_set_id STRING(512) OPTIONS(description='Individual ID of the resource set from Quintiq'),
shift BIGNUMERIC(38,0)
OPTIONS(description='Specification in the number of shifts of a day of a resource set the tour_2 takes place (single digit)'),
tour_id STRING(512) OPTIONS(description='Tour_2 number (unique per day and company, multiple digits)'),
licence_plate STRING(512)
OPTIONS(description='License plate of the truck or tractor unit_2 with which the tour_2 was carried out'),
shift_indicator STRING(512)
OPTIONS(description='Shift indicator of the tour_2 (use dependent on regional distribution center and setting in Quintiq)'),
means_of_transport STRING(512)
OPTIONS(description='Transport resource with which the tour_2 was carried out (INTEGER definition of individual vehicle resources, data from Quintiq) (e.g. tractor or trailer)'),
unique_tour_id STRING(512)
OPTIONS(description='Unique ID for each tour_2 within a country_2; Combination of delivery date and tour_2 ID (YYMMDDTourID). Original name: UID'),
stores STRING(512)
OPTIONS(description='Store numbers or numbers of the special addresses that are approached with the route separated by - in the order of approach'),
resource_type STRING(512)
OPTIONS(description='Vehicle type with which the tour_2 is carried out (e.g. articulated truck) (data from Quintiq)'),
resource_technique STRING(512)
OPTIONS(description='Vehicle technology with which the tour_2 is carried out (e.g. mono- / bi-temp) (data from Quintiq)'),
fuel_type STRING(512) OPTIONS(description='Type of drive with which the tour_2 was carried out (data from Quintiq)'),
total_tour_km FLOAT64 OPTIONS(description='Total number of kilometers of the tour. Original name: KM'),
toll_km FLOAT64
OPTIONS(description='Total number of kilometers subject to tolls for the route (use depends on country_2 configuration)'),
total_pallets FLOAT64 OPTIONS(description='Total number of pallet spaces loaded on route (accurate to 0.5)'),
duration FLOAT64 OPTIONS(description='Total duration of the tour_2 in hours'),
cost_indicator STRING(512) OPTIONS(description='Predefined comments per tour_2 (can store country_2 in Quintiq)'),
cost_indicator_amount STRING(512) OPTIONS(description='Numerical value (country_2-specific definition from Quintiq)'),
comment_txt STRING(2048) OPTIONS(description='Free comment field of the tour_2 from Quintiq. Original name: Comment'),
fix_costs FLOAT64 OPTIONS(description='Fixed costs associated with the tour_2 in local currency'),
variable_costs FLOAT64 OPTIONS(description='Variable costs associated with the tour_2 in local currency'),
floater FLOAT64 OPTIONS(description='Fuel floater costs in local currency associated with the tour_2'),
surcharges FLOAT64 OPTIONS(description='Tour_2 surcharges in local currency'),
additional_services FLOAT64 OPTIONS(description='Additional costs for the tour_2 in local currency'),
toll FLOAT64 OPTIONS(description='Toll costs for the tour_2 in local currency'),
other_costs FLOAT64 OPTIONS(description='Other costs of the tour_2 in local currency'),
invoice_matching STRING(512) OPTIONS(description='Negative total invoice amount'),
total FLOAT64 OPTIONS(description='Total costs of the tour_2 in local currency'),
hotrun STRING(512)
OPTIONS(description='Has the event that is associated with the tour_2 in CATS, the status_2 Hotrun and thus ended the process in CATS (states Y and N)'),
invoice_status STRING(512) OPTIONS(description='Status_2 of invoice processing'),
invoice_number STRING(512)
OPTIONS(description='Unique number of the billing document created in CnB for each country. Before Hotrun: RDC-Abbreviation_Carrier Abbreviation_KW_Year_Number_Rechnungsnummer. After Hotrun: six-digit counter / year number'),
external_invoice_number STRING(2048) OPTIONS(description='Unique invoice number for each country_2'),
currency STRING(512) OPTIONS(description='National currency, stored for each freight forwarder'),
total_consumption FLOAT64 OPTIONS(description='Fuel consumption of the tour_2'),
reference_price FLOAT64
OPTIONS(description='Reference price of the fuel floater calculation in local currency associated with the tour_2'),
calculated_fuel_costs FLOAT64 OPTIONS(description='Total fuel costs associated with the tour_2'),
total_excl_fuel_costs FLOAT64 OPTIONS(description='Total cost of the tour_2 excluding fuel costs'),
pallets_1a FLOAT64 OPTIONS(description='Number of 1a pallets on the route (accurate to 0.5). Original name: 1A Pallets'),
xwh_pallets_1b FLOAT64
OPTIONS(description='Number of 1b external warehouse pallets on the route (accurate to 0.5). Original name: 1B XWH Pallets'),
rdc_pallets_1b FLOAT64
OPTIONS(description='Number of 1b redistribution pallets on the route (accurate to 0.5). Original name: 1B RDC Pallets'),
nf_pallets_1b FLOAT64
OPTIONS(description='Number of 1b non-food pallets on the route (accurate to 0.5). Original name: 1B NF Pallets'),
total_standard_costs FLOAT64 OPTIONS(description='Total standard costs of the tour_2 in local currency'),
costs_1a FLOAT64
OPTIONS(description='1A standard costs in local currency (part of Total Standard Costs). Original name: 1A Costs'),
xwh_costs_1b FLOAT64
OPTIONS(description='1b- External warehouse standard costs in local currency (part of Total Standard Costs). Original name: 1B XWH Costs'),
rdc_costs_1b FLOAT64
OPTIONS(description='1b standard stock transfer costs in local currency (part of Total Standard Costs). Original name: 1B RDC Costs'),
nf_costs_1b FLOAT64 OPTIONS(description='1b non-food costs (part of total standard costs). Original name: 1B NF Costs'),
total_toll_costs FLOAT64 OPTIONS(description='Total toll costs for the tour_2 in local currency'),
toll_costs_1a FLOAT64
OPTIONS(description='1A share of total toll costs in local currency. Original name: 1A Toll Costs'),
xwh_toll_costs_1b FLOAT64
OPTIONS(description='Share of 1B external warehouse in total toll costs in local currency. Original name: 1B XWH Toll Costs'),
rdc_toll_costs_1b FLOAT64
OPTIONS(description='Share of 1B regional stock transfer of total toll costs in local currency. Original name: 1B RDC Toll Costs'),
nf_toll_costs_1b FLOAT64
OPTIONS(description='Share of 1b non-food in total toll costs in local currency. Original name: 1B NF Toll Costs'),
other_costs2 FLOAT64 OPTIONS(description='Other costs in local currency. Original name: Other Costs'),
fix_costs_shift FLOAT64 OPTIONS(description='Fixed shift costs in local currency associated with tour_2'),
fix_costs_oneway FLOAT64 OPTIONS(description='Fixed one-way costs in local currency associated with the tour_2'),
fix_costs_day FLOAT64 OPTIONS(description='Fixed daily costs in local currency associated with the tour_2'),
fix_costs_tour FLOAT64 OPTIONS(description='Fixed tour_2 costs in local currency associated with tour_2'),
fix_costs_predefined_tour FLOAT64
OPTIONS(description='Fixed, predefined tour_2 costs in local currency associated with tour_2'),
variable_costs_km FLOAT64 OPTIONS(description='Variable costs per km associated with the tour_2 in local currency'),
variable_costs_hour FLOAT64 OPTIONS(description='Cost per hour associated with the tour_2 in local currency'),
variable_costs_stop FLOAT64 OPTIONS(description='Variable costs per stop in local currency'),
surcharge_sunday FLOAT64 OPTIONS(description='Sunday surcharge in local currency associated with the tour_2'),
surcharge_tail_lift FLOAT64 OPTIONS(description='Lifting platform surcharge in local currency associated with tour_2'),
surcharge_frozen_goods FLOAT64 OPTIONS(description='Frozen surcharge in local currency associated with tour_2'),
fuel_floater_km FLOAT64 OPTIONS(description='Number of kilometers used for the fuel floater calculation'),
toll_costs_quintiq FLOAT64 OPTIONS(description='Toll costs transferred from Quintiq in local currency'),
placeholder_14 STRING(512) OPTIONS(description='Free columns for country_2-specific use. Original name: 14'),
placeholder_15 STRING(512) OPTIONS(description='Free columns for country_2-specific use. Original name: 15'),
carrier_day_id STRING(512) OPTIONS(description='Combination of columns RDC ID NR _ Carrier ID _ Date (format YYMMDD)'),
carrier_resourceset_id STRING(512)
OPTIONS(description='Combination of columns RDC ID _ Carrier ID _ Date (format YYMMDD) _ Resource Set ID'),
carrier_shift_id STRING(512)
OPTIONS(description='Combination of columns RDC ID _ Carrier ID _ Date (format YYMMDD) _ Resource Set ID _ Preceding S directly followed by the contents of the Shift column'),
carrier_tour_id STRING(512) NOT NULL
OPTIONS(description='Combination of columns RDC ID _ Carrier ID _ Date (format YYMMDD) _ Resource Set ID _ Leading S directly followed by contents of the Shift column _ Leading T followed by contents of the Tour_2 ID column'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
PRIMARY KEY (client_id, carrier_tour_id) NOT ENFORCED
) OPTIONS(description='CATS - an overview of the transport costs.');