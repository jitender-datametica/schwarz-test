-- 10.07.2023 snik: SPEC0202038 L_REKLAMATIONSGRUND_1
 CREATE OR REPLACE VIEW dbp_msi_view_aad.mv_l_reklamationsgrund_1 (mandant_id
, reklamationsgrund_id) AS SELECT mandant_id,
 reklamationsgrund_id
FROM kfl_production_dbp_view.v_l_reklamationsgrund_1 AS v01;