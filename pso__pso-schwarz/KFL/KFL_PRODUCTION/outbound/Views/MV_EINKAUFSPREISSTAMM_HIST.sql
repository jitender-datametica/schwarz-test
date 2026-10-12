CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_einkaufspreisstamm_hist (mandant_id, art_id, bezugsweg_id,
dat_von, dat, dat_bis, ek_kal_basis, ek_mep, logistikkostenzuschlag, sternchen_logik_sk, sx_id, s1_id, s2_id, s3_id,
s4_id, s5_id) AS SELECT DT1.mandant_id,
 DT1.art_id,
 DT1.bezugsweg_id,
 DT1.dat_von,
 M.dat,
 DT1.dat_bis,
 DT1.ek_kal_basis,
 DT1.ek_mep,
 DT1.logistikkostenzuschlag,
 DT2.sternchen_logik_sk,
 DT2.sx_id,
 DT2.s1_id,
 DT2.s2_id,
 DT2.s3_id,
 DT2.s4_id,
 DT2.s5_id
FROM (SELECT V01.mandant_id,
   V01.art_id,
   V01.bezugsweg_id,
   V01.dat_von,
   V01.dat_bis,
   MAX(COALESCE(CASE
      WHEN V01.wup_id = 6907
      THEN V01.ek_kal_basis
      ELSE NULL
      END, CASE
      WHEN V01.wup_id = 6906
      THEN V01.ek_kal_basis
      ELSE NULL
      END, CASE
      WHEN V01.wup_id = CAST(- 1 AS BIGNUMERIC)
      THEN V01.ek_kal_basis
      ELSE NULL
      END)) AS ek_kal_basis,
   MAX(COALESCE(CASE
      WHEN V01.wup_id = 6907
      THEN V01.ek_mep
      ELSE NULL
      END, CASE
      WHEN V01.wup_id = 6906
      THEN V01.ek_mep
      ELSE NULL
      END, CASE
      WHEN V01.wup_id = CAST(- 1 AS BIGNUMERIC)
      THEN V01.ek_mep
      ELSE NULL
      END)) AS ek_mep,
   MAX(COALESCE(CASE
      WHEN V01.wup_id = 6907
      THEN V01.logistikkostenzuschlag
      ELSE NULL
      END, CASE
      WHEN V01.wup_id = 6906
      THEN V01.logistikkostenzuschlag
      ELSE NULL
      END, CASE
      WHEN V01.wup_id = CAST(- 1 AS BIGNUMERIC)
      THEN V01.logistikkostenzuschlag
      ELSE NULL
      END)) AS logistikkostenzuschlag
  FROM kfl_production_dbp_view.v_art_gp_wup_zu_per AS V01
   INNER JOIN (SELECT art_id,
     gp_id,
     mandant_id
    FROM kfl_production_dbp_view.v_art_gp_zu_per
    WHERE mandant_id = 1
     AND dat_bis = DATE '9999-12-31') AS V02 ON V01.art_id = V02.art_id AND V01.gp_id = V02.gp_id AND V01.mandant_id =
     V02.mandant_id
  WHERE V01.wup_id IN (6907, 6906, - 1) -- AND V01.DAT_BIS = '9999-12-31'

   AND V01.mandant_id = 1
  GROUP BY V01.mandant_id,
   V01.art_id,
   V01.bezugsweg_id,
   V01.dat_von,
   V01.dat_bis) AS DT1
 INNER JOIN (SELECT LSL.art_id,
   LSL.mandant_id,
    LSL.bezugsweg1_fg + LSL.bezugsweg4_fg * 4 AS bezugsweg_id,
             MAX(SUBSTR(CAST(CASE
                 WHEN LSL.sm_id = CAST(- 1 AS BIGNUMERIC)
                 THEN LS.sternchen_id
                 ELSE '  '
                 END AS STRING), 1, 2)) || '/' || MAX(SUBSTR(CAST(CASE
                WHEN LSL.sm_id = 1
                THEN LS.sternchen_id
                ELSE '  '
                END AS STRING), 1, 2)) || '/' || MAX(SUBSTR(CAST(CASE
              WHEN LSL.sm_id = 2
              THEN LS.sternchen_id
              ELSE '  '
              END AS STRING), 1, 2)) || '/' || MAX(SUBSTR(CAST(CASE
            WHEN LSL.sm_id = 3
            THEN LS.sternchen_id
            ELSE '  '
            END AS STRING), 1, 2)) || '/' || MAX(SUBSTR(CAST(CASE
          WHEN LSL.sm_id = 4
          THEN LS.sternchen_id
          ELSE '  '
          END AS STRING), 1, 2)) || '/' || MAX(SUBSTR(CAST(CASE
        WHEN LSL.sm_id = 5
        THEN LS.sternchen_id
        ELSE '  '
        END AS STRING), 1, 2)) AS sternchen_logik_sk,
   MAX(SUBSTR(CAST(CASE
       WHEN LSL.sm_id = CAST(- 1 AS BIGNUMERIC)
       THEN LS.sternchen_id
       ELSE '  '
       END AS STRING), 1, 2)) AS sx_id,
   MAX(SUBSTR(CAST(CASE
       WHEN LSL.sm_id = 1
       THEN LS.sternchen_id
       ELSE '  '
       END AS STRING), 1, 2)) AS s1_id,
   MAX(SUBSTR(CAST(CASE
       WHEN LSL.sm_id = 2
       THEN LS.sternchen_id
       ELSE '  '
       END AS STRING), 1, 2)) AS s2_id,
   MAX(SUBSTR(CAST(CASE
       WHEN LSL.sm_id = 3
       THEN LS.sternchen_id
       ELSE '  '
       END AS STRING), 1, 2)) AS s3_id,
   MAX(SUBSTR(CAST(CASE
       WHEN LSL.sm_id = 4
       THEN LS.sternchen_id
       ELSE '  '
       END AS STRING), 1, 2)) AS s4_id,
   MAX(SUBSTR(CAST(CASE
       WHEN LSL.sm_id = 5
       THEN LS.sternchen_id
       ELSE '  '
       END AS STRING), 1, 2)) AS s5_id
  FROM kfl_production_dbp_view.v_sternchen_logik AS LSL
   INNER JOIN kfl_production_dbp_view.v_l_sternchen AS LS ON LSL.list_durchg_fg = LS.list_durchg_fg AND LSL.bezugsweg1_fg
          = LS.bezugsweg1_fg AND LSL.bezugsweg4_fg = LS.bezugsweg4_fg AND LSL.kdis0_fg = LS.kdis0_fg AND LSL.kdis1_fg =
      LS.kdis1_fg AND LSL.mandant_id = LS.mandant_id
  WHERE LSL.mandant_id = 1
   AND LSL.dat_bis = DATE '9999-12-31'
  GROUP BY LSL.art_id,
   LSL.mandant_id,
   bezugsweg_id) AS DT2 ON DT1.mandant_id = DT2.mandant_id AND DT1.art_id = DT2.art_id AND DT1.bezugsweg_id = DT2.bezugsweg_id
   
 INNER JOIN kfl_production_dbp_view.v_tag AS M ON M.dat BETWEEN DT1.dat_von AND DT1.dat_bis
WHERE DT1.dat_von <= CURRENT_DATE
 AND M.dat <= CURRENT_DATE;