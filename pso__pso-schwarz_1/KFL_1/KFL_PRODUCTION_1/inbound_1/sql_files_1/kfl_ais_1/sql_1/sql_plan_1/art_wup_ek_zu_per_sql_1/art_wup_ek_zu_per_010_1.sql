--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.art_wup_ek_zu_per_1
(
   art_id
  ,mandant_Id
  ,wup_id
  ,nb_id
  ,dat_von
  ,dat_bis
  ,ek_netto
  ,ek_netto_bnk
  ,ek_mep
  ,einstandspreis
  ,ek_nettonetto
  ,komponentenmenge
  ,wrg_id
  ,kein_zekp_fg
)
SELECT
   art_id
  ,mandant_id
  ,wup_id
  ,nb_id
  ,to_date('1900-01-01','YYYY-MM_1-DD') AS dat_von
  ,min_dat_von - 1 AS dat_bis
  ,  (0.00  ) AS ek_netto
  ,  (0.00  ) AS ek_netto_bnk
  ,  (0.00  ) AS ek_mep
  ,  (0.00  ) AS einstandspreis
  ,  (0.00  ) AS ek_nettonetto
  ,1.0000 AS komponentenmenge
  ,'EUR' AS wrg_id
  ,0 AS kein_zekp_fg
FROM
(
  SELECT
     art_id
    ,mandant_id
    ,wup_id
    ,nb_id
    ,MIN(dat_von) AS min_dat_von
  FROM DBP_DATA.art_wup_ek_zu_per_1
  GROUP BY 1, 2, 3, 4
) a
WHERE min_dat_von > to_date('1900-01-01','YYYY-MM_1-DD')
;

