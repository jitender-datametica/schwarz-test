CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_art_user_zu_2 (mandant_id, user_id, art_id) AS (SELECT U_R.mandant_id
  ,
  U_R.user_id,
  a_vhd.art_id
 FROM kfl_production_dbp_security.user_rolle_ek_int_zu_2 AS U_R
  INNER JOIN (SELECT A.mandant_id,
    A.art_id,
    A.zek_id,
    EKL.wbl_id,
    GF.gf_id
   FROM kfl_production_dbp_view.v_art_2 AS A
    LEFT JOIN kfl_production_dbp_view.v_zek_2 AS EKL ON A.mandant_id = EKL.mandant_id AND A.zek_id = EKL.zek_id
    LEFT JOIN kfl_production_dbp_view.v_wbl_2 AS GF_2 ON EKL.mandant_id = GF.mandant_id AND EKL.wbl_id = GF.wbl_id) AS a_vhd
  ON U_R.mandant_id = a_vhd.mandant_id AND COALESCE(U_R.zek_id, a_vhd.zek_id) = a_vhd.zek_id AND COALESCE(U_R.wbl_id,
      a_vhd.wbl_id) = a_vhd.wbl_id AND COALESCE(U_R.gf_id, a_vhd.gf_id) = a_vhd.gf_id
 WHERE U_R.rolle_id IN (1, 2, 3)
 UNION DISTINCT
 SELECT U_R.mandant_id,
  U_R.user_id,
  a_vat.art_id
 FROM kfl_production_dbp_security.user_rolle_ek_int_zu_2 AS U_R
  INNER JOIN (SELECT A.mandant_id,
    A.art_id,
    A.zek_vat_id AS zek_id,
    EKL.wbl_id,
    GF.gf_id
   FROM kfl_production_dbp_view.v_art_2 AS A
    LEFT JOIN kfl_production_dbp_view.v_zek_2 AS EKL ON A.mandant_id = EKL.mandant_id AND A.zek_vat_id = EKL.zek_id
    LEFT JOIN kfl_production_dbp_view.v_wbl_2 AS GF_2 ON EKL.mandant_id = GF.mandant_id AND EKL.wbl_id = GF.wbl_id) AS a_vat
  ON U_R.mandant_id = a_vat.mandant_id AND COALESCE(U_R.zek_id, a_vat.zek_id) = a_vat.zek_id AND COALESCE(U_R.wbl_id,
      a_vat.wbl_id) = a_vat.wbl_id AND COALESCE(U_R.gf_id, a_vat.gf_id) = a_vat.gf_id
 WHERE U_R.rolle_id IN (1, 2, 3))
UNION DISTINCT
SELECT mandant_id,
 'Superuser',
 art_id
FROM kfl_production_dbp_view.v_art_2 AS ART_2;