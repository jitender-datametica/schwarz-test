/* --------------------------------------------------------------------------------
   DDL for table: t_ref_handling_unit_type
   generated from Powerdesigner on Mittwoch, 5. Juni 2024 15:46:08
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_handling_unit_type (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
handling_unit_type_cd STRING(100) NOT NULL OPTIONS(description='HU / Pallet type code.'),
handling_unit_type_descr STRING(250) OPTIONS(description='HU / Pallet type description.'),
pallet_type_cd STRING(100)
OPTIONS(description='Code for the pallet type, i.e. EP, DD, AE, etc. (for the HU it can be the first 2 characters of the HU type code, but not always).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (handling_unit_type_cd) NOT ENFORCED
)
OPTIONS(description='Classification of handling units (HUs). It consists of the pallet type as well as load size and weight.             EWM source : /SCWM/THUTYP');