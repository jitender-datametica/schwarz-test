CREATE OR REPLACE VIEW dbp_msi_view2.mv_einkaufspreisstamm_hist_1
                                                                                                                                                                                  AS
 SELECT
 dt1.mandant_id,
 dt1.art_id,
 dt1.bezugsweg_id,
 dt1.dat_von,
 m.dat,
 dt1.dat_bis,
 dt1.ek_kal_basis,
 dt1.ek_mep,
 dt1.logistikkostenzuschlag,
 dt2.sternchen_logik_sk,
 dt2.sX_id,
 dt2.s1_id,
 dt2.s2_id,
 dt2.s3_id,
 dt2.s4_id,
 dt2.s5_id
 FROM (SELECT
 v01.mandant_id,
 v01.art_id,
 v01.bezugsweg_id,
 v01.dat_von,
 v01.dat_bis,
 Max(Coalesce(
 CASE wup_id WHEN 6907 THEN ek_kal_basis END,
 CASE wup_id WHEN 6906 THEN ek_kal_basis END,
 CASE wup_id WHEN -1 THEN ek_kal_basis END
 )) ek_kal_basis,
 Max(Coalesce(
 CASE wup_id WHEN 6907 THEN ek_mep END,
 CASE wup_id WHEN 6906 THEN ek_mep END,
 CASE wup_id WHEN -1 THEN ek_mep END
 )) ek_mep,
 Max(Coalesce(
 CASE wup_id WHEN 6907 THEN logistikkostenzuschlag END,
 CASE wup_id WHEN 6906 THEN logistikkostenzuschlag END,
 CASE wup_id WHEN -1 THEN logistikkostenzuschlag END
 )) logistikkostenzuschlag
 FROM dbp_view.v_art_gp_wup_zu_per_1 v01
 JOIN
 (SELECT
 art_id,
 gp_id,
 mandant_id
 FROM dbp_view.v_art_gp_zu_per_1
                                                                                                                                 WHERE mandant_id = 1 AND dat_bis = '9999-12-31'
                                                                                                                                 ) v02
 ON v01.art_id = v02.art_id
 AND v01.gp_id = v02.gp_id
 AND v01.mandant_id = v02.mandant_id

 WHERE wup_id IN (6907, 6906, -1)
 --AND v01.dat_bis = '9999-12-31'
 AND v01.mandant_id = 1
 GROUP BY 1,2,3,4,5
 ) AS dt1
 INNER JOIN
 (SELECT
 sk.art_id,
 sk.mandant_id,
 bezugsweg_id,
 Max(sX_id)||'/'||Max(s1_id)||'/'||Max(s2_id)||'/'||Max(s3_id)||'/'||Max(s4_id)||'/'||Max(s5_id) AS sternchen_logik_sk,
 Max(sX_id) AS sX_id,
 Max(s1_id) AS s1_id,
 Max(s2_id) AS s2_id,
 Max(s3_id) AS s3_id,
 Max(s4_id) AS s4_id,
 Max(s5_id) AS s5_id
 FROM
 (SELECT
 lsl.art_id AS art_id,
 lsl.mandant_id,
 (lsl.bezugsweg1_fg * 1) + ( lsl.bezugsweg4_fg * 4 ) AS bezugsweg_id,
 Cast (CASE lsl.sm_id WHEN -1 THEN ls.sternchen_id ELSE '  ' END AS CHAR(2)) AS sX_id,
 Cast (CASE lsl.sm_id WHEN 1 THEN ls.sternchen_id ELSE '  ' END AS CHAR(2)) AS s1_id,
 Cast (CASE lsl.sm_id WHEN 2 THEN ls.sternchen_id ELSE '  ' END AS CHAR(2)) AS s2_id,
 Cast (CASE lsl.sm_id WHEN 3 THEN ls.sternchen_id ELSE '  ' END AS CHAR(2)) AS s3_id,
 Cast (CASE lsl.sm_id WHEN 4 THEN ls.sternchen_id ELSE '  ' END AS CHAR(2)) AS s4_id,
 Cast (CASE lsl.sm_id WHEN 5 THEN ls.sternchen_id ELSE '  ' END AS CHAR(2)) AS s5_id
 FROM dbp_view.v_sternchen_logik_1 AS lsl
 INNER JOIN dbp_view.v_l_sternchen_1 AS ls
 ON  lsl.list_durchg_fg = ls.list_durchg_fg
 AND lsl.bezugsweg1_fg  = ls.bezugsweg1_fg
 AND lsl.bezugsweg4_fg  = ls.bezugsweg4_fg
 AND lsl.kdis0_fg       = ls.kdis0_fg
 AND lsl.kdis1_fg       = ls.kdis1_fg
 AND lsl.mandant_id     = ls.mandant_id

 WHERE lsl.mandant_id = 1
 AND lsl.dat_bis = '9999-12-31'
 ) AS sk
 GROUP BY 1, 2, 3
 )dt2
 ON dt1.mandant_id = dt2.mandant_id
 AND dt1.art_id = dt2.art_id
 AND dt1.bezugsweg_id=dt2.bezugsweg_id
 JOIN dbp_view.v_tag_1 m
 ON m.dat BETWEEN dt1.dat_von AND dt1.dat_bis
 WHERE dt1.dat_von<=Current_Date AND m.dat<=Current_Date;