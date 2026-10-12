CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_cust_reg_dereg_ldpl_interface_grp_name_1 (reg_interface_grp_id
OPTIONS(description='ID of the registration interface group through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.'),
reg_interface_grp_name
OPTIONS(description='Name of the interface group through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.'),
reg_interface_grp_descr
OPTIONS(description='Description of the interface group through which the user registered or reregistered for the geographical area in the loyalty program by accepting the legal terms the first time.'),
load_id OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row created time'), dwh_updated
OPTIONS(description='Row update time'))
OPTIONS(DESCRIPTION = `Lidlplus view : Table that is used as lookup for registration interface attribute`) AS SELECT
 reg_interface_grp_id,
 reg_interface_grp_name,
 reg_interface_grp_descr,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_cust_reg_dereg_ldpl_interface_grp_name_1;