CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_egin_we_paletten_nach_anlieferbereich_2 (client_id
OPTIONS(description='Indicator of country_2'), wh_id OPTIONS(description='Warehouse number'), wh_staging_area_cd
OPTIONS(description='Warehouse area number'), wh_docking_gate_nr OPTIONS(description='Tor'), sup_sid
OPTIONS(description='Supplier_2 sid number'), spedition OPTIONS(description='Name of the carrier '), dat_entry_rcv
OPTIONS(description='task completed date and time'), euro_pal OPTIONS(description='Amount of Euro pallets'),
euro_pal_rejected OPTIONS(description='Amount of rejected euro pallets'), dd_pal
OPTIONS(description='Amount of Düsseldorf pallets'), dd_pal_rejected
OPTIONS(description='Amount of rejected Düsseldorf pallets'), euro_pal_aufgelaufen
OPTIONS(description='cumulative euro pallets'), dd_pal_aufgelaufen OPTIONS(description='cumulative Düsseldorf pallets'),
euro_pal_rejected_aufgelaufen OPTIONS(description='cumulative rejected euro pallets'), dd_pal_rejected_aufgelaufen
OPTIONS(description='cumulative rejected Düsseldorf pallets'), euro_pal_vj
OPTIONS(description='Amount of Euro pallets mapped to previous year'), euro_pal_rejected_vj
OPTIONS(description='Amount of rejected euro pallets mapped to previous year'), dd_pal_vj
OPTIONS(description='Amount of Düsseldorf pallets mapped to previous year'), dd_pal_rejected_vj
OPTIONS(description='Amount of rejected Düsseldorf mapped to previous year'), euro_pal_vj_aufgelaufen
OPTIONS(description='cumulative euro pallets previous year'), dd_pal_vj_aufgelaufen
OPTIONS(description='cumulative Düsseldorf pallets previous year'), euro_pal_rejected_vj_aufgelaufen
OPTIONS(description='cumulative rejected euro pallets previous year'), dd_pal_rejected_vj_aufgelaufen
OPTIONS(description='cumulative rejected Düsseldorf pallets previous year')) AS SELECT *
FROM ldl_p_lew_mart_lead.v_egin_we_paletten_nach_anlieferbereich_2;