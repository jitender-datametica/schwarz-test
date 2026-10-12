CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_PALLET_TYPE (
   pallet_type_cd                           COMMENT 'Code for the pallet type, i.e. EP, DD, AE, etc.'
  ,pallet_type_descr                        COMMENT 'Description of the main pallet type.'
  ,pallet_type_factor                       COMMENT 'Conversion factor of logical pallet to euro pallet equivalent.'
  ,dwh_load_id                              COMMENT 'The identifier of the last load run which inserted or updated this row.'
  ,dwh_created                              COMMENT 'The point in time when this record was created in the data warehouse.'
  ,dwh_updated                              COMMENT 'The point in time when this record was last updated.'
)
COMMENT = 'Table holds the pallet types, as well as the conversion factor to the equivalent euro pallet. Number of pallets * factor = number of pallets in terms of euro pallets.'
AS SELECT
   pallet_type_cd
  ,pallet_type_descr
  ,pallet_type_factor
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_PALLET_TYPE;