CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_pallet_type_1 (pallet_type_cd
OPTIONS(description='Code for the pallet type, i.e. EP, DD, AE, etc.'), pallet_type_descr
OPTIONS(description='Description of the main pallet type.'), pallet_type_factor
OPTIONS(description='Conversion factor of logical pallet to euro pallet equivalent.'), dwh_load_id
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'), dwh_created
OPTIONS(description='The point in time when this record was created in the data warehouse.'), dwh_updated
OPTIONS(description='The point in time when this record was last updated.'))
OPTIONS(DESCRIPTION = `TABLE HOLDS THE PALLET TYPES, AS WELL AS THE CONVERSION FACTOR TO THE EQUIVALENT EURO PALLET. NUMBER OF PALLETS * FACTOR = NUMBER OF PALLETS IN TERMS OF EURO PALLETS.`)
AS SELECT pallet_type_cd,
 pallet_type_descr,
 pallet_type_factor,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_pallet_type_1;