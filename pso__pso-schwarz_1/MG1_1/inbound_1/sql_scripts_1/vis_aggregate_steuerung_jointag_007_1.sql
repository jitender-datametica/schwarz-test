/* AW check 2021-05-10*/
INSERT INTO DBP_ETL.dat_vj_vergleich_1 (mandant_id
                                       ,wup_id
                                       ,nb_id
                                       ,join_dat
                                       ,dat
                                       ,gj
                                       ,kjwo
                                       ,kjmo
                                       ,mo_kj
                                       ,akt_gj
                                       ,akt_mo
                                       ,akt_wo
                                       ,akt_tag
                                       ,wtag_id
                                       ,akt_gj_fg
                                       ,vj_1_fg
                                       ,vj_2_fg
                                       ,vj_wt_1_fg
                                       ,vj_wt_2_fg)
SELECT dt1.mandant_id
      ,dt1.wup_id
      ,dt1.nb_id
      ,t1.join_dat
      ,t1.dat
      ,t1.gj
      ,t1.kjwo
      ,t1.kjmo
      ,t1.mo_kj
      ,t1.akt_gj
      ,t1.akt_mo
      ,t1.akt_wo
      ,t1.akt_tag
      ,t1.wtag_id
      ,t1.akt_gj_fg
      ,t1.vj_1_fg
      ,t1.vj_2_fg
      ,t1.vj_wt_1_fg
      ,t1.vj_wt_2_fg
FROM DBP_ETL.dat_vj_vergleich_tmp_1 t1_1
CROSS JOIN (SELECT t2.wup_id
                  ,t2.mandant_id
                  ,t2.nb_id
            FROM DBP_DATA.wup_1 t2
            JOIN DBP_ETL.vis_mandant_1 t3
              ON t2.mandant_id = t3.mandant_id
            WHERE t2.nb_id in (-2,-1,0,2,7) AND 
                  --t2.dat_eroeffnung > 101) dt1
                  t2.dat_eroeffnung > '1900-01-01') dt1
;

INSERT INTO DBP_ETL.dat_vj_vergl_abschrift_1 (mandant_id
                                             ,wup_id
                                             ,nb_id
                                             ,join_dat
                                             ,dat
                                             ,gj
                                             ,kjwo
                                             ,kjmo
                                             ,mo_kj
                                             ,akt_gj
                                             ,akt_mo
                                             ,akt_wo
                                             ,akt_tag
                                             ,wtag_id
                                             ,akt_gj_fg
                                             ,vj_1_fg
                                             ,vj_2_fg
                                             ,vj_wt_1_fg
                                             ,vj_wt_2_fg)
SELECT dt1.mandant_id
      ,dt1.wup_id
      ,dt1.nb_id
      ,t1.join_dat
      ,t1.dat
      ,t1.gj
      ,t1.kjwo
      ,t1.kjmo
      ,t1.mo_kj
      ,t1.akt_gj
      ,t1.akt_mo
      ,t1.akt_wo
      ,t1.akt_tag
      ,t1.wtag_id
      ,t1.akt_gj_fg
      ,t1.vj_1_fg
      ,t1.vj_2_fg
      ,t1.vj_wt_1_fg
      ,t1.vj_wt_2_fg
FROM DBP_ETL.dat_vj_vergleich_tmp_1 t1_1
CROSS JOIN (SELECT t2.wup_id
                  ,t2.mandant_id
                  ,t2.nb_id
            FROM DBP_DATA.wup_1 t2
            WHERE t2.nb_id in (-2,-1,0,2,7) AND 
                  --t2.dat_eroeffnung > 101) dt1
                  t2.dat_eroeffnung > '1900-01-01') dt1
;

