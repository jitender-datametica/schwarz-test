-- 10.07.2023 snik: SPEC0202038 Lookup Kasse Typ
 CREATE OR REPLACE VIEW dbp_msi_view_aad.mv_l_kasse_typ_2 (kasse_typ_id)
AS SELECT kasse_typ_id
FROM kfl_production_dbp_v_ods.v_l_kasse_typ_2;