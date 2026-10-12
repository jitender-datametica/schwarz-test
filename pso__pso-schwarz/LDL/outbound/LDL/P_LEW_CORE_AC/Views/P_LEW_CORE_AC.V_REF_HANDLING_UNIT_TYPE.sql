CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_handling_unit_type (client_id
OPTIONS(description='DWH-Mandant; FK auf CLIENT'), handling_unit_type_cd OPTIONS(description='HU / Pallet type code.'),
handling_unit_type_descr OPTIONS(description='HU / Pallet type description.'), pallet_type_cd
OPTIONS(description='Code for the pallet type, i.e. EP, DD, AE, etc. (for the HU it can be the first 2 characters of the HU type code, but not always).'),
dwh_load_id OPTIONS(description='The identifier of the last load run which inserted or updated this row.'), dwh_created
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated
OPTIONS(description='The point in time when this record was last updated.'))
OPTIONS(DESCRIPTION = `CLASSIFICATION OF HANDLING UNITS (HUS). IT CONSISTS OF THE PALLET TYPE AS WELL AS LOAD SIZE AND WEIGHT.EWM SOURCE : /SCWM/THUTYP`)
AS SELECT client_id,
 handling_unit_type_cd,
 handling_unit_type_descr,
 pallet_type_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_handling_unit_type;