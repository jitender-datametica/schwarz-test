CREATE OR REPLACE VIEW szd_production_fe_mstr_wholesale.v_fact_broker_report_line_per_day (cds_acceptance_dt,
authority_country_location_sid, broker_declarant_party_sid, consignor_party_sid, customs_declaration_type_cd,
customs_product_sid, customs_procedure_cd, total_line_cnt, alcoholic_line_cnt, non_alcoholic_line_cnt, dwh_created_tmsp
, dwh_updated_tmsp) AS SELECT cds_acceptance_dt,
 authority_country_location_sid,
 broker_declarant_party_sid,
 consignor_party_sid,
 customs_declaration_type_cd,
 customs_product_sid,
 customs_procedure_cd,
 total_line_cnt,
 alcoholic_line_cnt,
 non_alcoholic_line_cnt,
 dwh_created_tmsp,
 dwh_updated_tmsp
FROM szd_production_core.t_fact_broker_report_line_per_day;