CREATE TABLE IF NOT EXISTS ldl_fe_mstr_toolbox_spiegel.t_agg_spaceman_section_item_pas_fts_2 (
int_org_sid BIGNUMERIC(38,0) OPTIONS(description='Internal Organisation ID'),
spaceman_section_sid BIGNUMERIC(38,0) OPTIONS(description='Section ID'),
spaceman_item_sid BIGNUMERIC(38,0) OPTIONS(description='Spaceman item_2 ID'),
cases BIGNUMERIC(38,0)
OPTIONS(description='Number of cases with condition for reusing in different columns esp. Potential 1 calculation - KOLLI'),
mult_pos_cases BIGNUMERIC(38,0) OPTIONS(description='Number of cases (Mehrfachstellungen) - KOLLI'),
mult_pos_einzel BIGNUMERIC(38,0) OPTIONS(description='Number of cases (Mehrfachstellungen) - EINZEL'),
cases_einzel BIGNUMERIC(38,6)
OPTIONS(description='Number of individual items for reusing in different columns - EINZEL'),
placing STRING(6) OPTIONS(description='Placing of item_2 (EP, DD, Regal, ...)'),
item_merchandising_type_cd STRING(20) OPTIONS(description='Item_2 merchandising type code Hand or Case'),
cnt_item_2 INTEGER OPTIONS(description='Number of item_2'),
cnt_cases BIGNUMERIC(38,0) OPTIONS(description='Number of cases KOLLI (Mehrfachstellungen)'),
cnt_cases_einzel BIGNUMERIC(38,6) OPTIONS(description='Number of cases EINZEL (Mehrfachstellungen)'),
avg_kolli BIGNUMERIC(38,11) OPTIONS(description='Average kolli width'),
avg_einzel BIGNUMERIC(38,11) OPTIONS(description='Average einzel width'),
avg_contact_distance_per_item BIGNUMERIC(38,11)
OPTIONS(description='Average contact_2 distance (width of the position) per item_2'),
avg_facings_per_item BIGNUMERIC(38,0) OPTIONS(description='Average facings per item_2'),
potential_1 BIGNUMERIC(38,0) OPTIONS(description='Potential 1 (old calculation)'),
potential_1_in_cm BIGNUMERIC(38,11) OPTIONS(description='Potential 1 in cm KOLLI'),
potential_1_in_cm_einzel BIGNUMERIC(38,11) OPTIONS(description='Potential 1 in cm EINZEL'),
cnt_facings BIGNUMERIC(38,0) OPTIONS(description='Number of facings'),
cnt_facings_reduced BIGNUMERIC(38,0) OPTIONS(description='Number of reduced facings KOLLI'),
cnt_facings_reduced_einzel BIGNUMERIC(38,6) OPTIONS(description='Number of reduced facings EINZEL'),
capacity BIGNUMERIC(38,10) OPTIONS(description='Capacity of item_2'),
section_selection_id BIGNUMERIC(38,0)
OPTIONS(description='Technical column for export functionality in dashboard -> every section has one row for Yes and No'),
metric_system_id BIGNUMERIC(38,0)
OPTIONS(description='Technical column for selection the measurement unit_2 for KPIs: cm or inches'),
pas_type STRING(20),
higher_meas BIGNUMERIC(38,0)
OPTIONS(description='Factor to calculate higher meas of measurement value, e.g. cm to m -> divide by 100'),
shelf_meter BIGNUMERIC(38,6) OPTIONS(description='Shelf meter')
);