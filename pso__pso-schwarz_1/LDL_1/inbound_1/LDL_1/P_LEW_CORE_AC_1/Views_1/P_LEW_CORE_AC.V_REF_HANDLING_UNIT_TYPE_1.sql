CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_HANDLING_UNIT_TYPE_1 (
   client_id                                COMMENT 'DWH-Mandant_1; FK auf CLIENT'
  ,handling_unit_type_cd                    COMMENT 'HU / Pallet type code.'
  ,handling_unit_type_descr                 COMMENT 'HU / Pallet type description.'
  ,pallet_type_cd                           COMMENT 'Code for the pallet type, i.e. EP, DD, AE, etc. (for the HU it can be the first 2 characters of the HU type code, but not always).'
  ,dwh_load_id                              COMMENT 'The identifier of the last load run which inserted or updated this row.'
  ,dwh_created                              COMMENT 'The point in time when this record was created in the data warehouse.'
  ,dwh_updated                              COMMENT 'The point in time when this record was last updated.'
)
COMMENT = 'Classification of handling units (HUs). It consists of the pallet type as well as load size and weight.
EWM source : /SCWM/THUTYP'
AS SELECT
   client_id
  ,handling_unit_type_cd
  ,handling_unit_type_descr
  ,pallet_type_cd
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_REF_HANDLING_UNIT_TYPE_1;