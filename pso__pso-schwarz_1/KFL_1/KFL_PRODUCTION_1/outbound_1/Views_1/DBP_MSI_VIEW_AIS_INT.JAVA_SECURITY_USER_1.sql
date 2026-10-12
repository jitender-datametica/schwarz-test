CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.java_security_user_1 (mandant_id, user_id, wg_id) AS SELECT A.mandant_id
 ,
 C.user_id,
 A.wg_id
FROM kfl_production_dbp_view.v_art_wg_zu_per_1 AS A
 INNER JOIN kfl_production_dbp_view.v_art_1 AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
 INNER JOIN kfl_production_dbp_security.user_zek_zu_1 AS C ON B.mandant_id = C.mandant_id AND B.zek_id = C.zek_id
WHERE A.arthiertyp_id = 2
 AND A.dat_bis = DATE '9999-12-31'
 AND B.loesch_id NOT IN ('L')
GROUP BY A.mandant_id,
 C.user_id,
 A.wg_id;