CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_pallet_type (pallet_type_cd
OPTIONS(description='Pallet code of the fact row'), pallet_type_descr
OPTIONS(description='A textual description for the pallet_type_cd written out in group language (German).'),
pallet_type_factor
OPTIONS(description='Space requirement of the pallet type compared to space requirement of Euro Pallet. eg. 1DD = 0,5 EP '),
octopus_pallet_type_id OPTIONS(description='External system numeric code'), elm_pallet_type_id
OPTIONS(description='ELM: elm_pallettypeid')) AS SELECT pallet_type_cd,
 pallet_type_descr,
 pallet_type_factor,
 octopus_pallet_type_id,
 elm_pallet_type_id
FROM ldl_score_core.t_dim_pallet_type;