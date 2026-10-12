CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_blocklagertyp AS SELECT mandant_id,
 lagernummer_id,
 blocklagertyp_id
FROM kfl_production_dbp_data.l_blocklagertyp;