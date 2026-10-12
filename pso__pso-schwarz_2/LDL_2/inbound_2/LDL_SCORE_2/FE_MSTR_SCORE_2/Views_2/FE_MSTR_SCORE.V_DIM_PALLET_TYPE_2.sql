CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_DIM_PALLET_TYPE_2(
	PALLET_TYPE_CD COMMENT 'Pallet code of the fact row',
	PALLET_TYPE_DESCR COMMENT 'A textual description for the pallet_type_cd written out in group language (German).',
	PALLET_TYPE_FACTOR COMMENT 'Space requirement of the pallet type compared to space requirement of Euro Pallet. eg. 1DD = 0,5 EP ',
	OCTOPUS_PALLET_TYPE_ID COMMENT 'External system numeric code',
	ELM_PALLET_TYPE_ID COMMENT 'ELM: elm_pallettypeid'
) AS
SELECT
   pallet_type_cd
  ,pallet_type_descr
  ,pallet_type_factor
  ,octopus_pallet_type_id
  ,elm_pallet_type_id
FROM core.t_dim_pallet_type_2;