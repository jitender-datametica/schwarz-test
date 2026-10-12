CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MA_HIERARCHIE_TYP_SPR_ZU as
   -- SPRACHE MA-Hierachietyp
   -- 20120405 Update
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten
   SELECT
   mandant_id, ma_hierarchie_typ_id, MAX(CASE WHEN spr_id =   22 THEN ma_hierarchie_typ_bez ELSE NULL END) AS ma_hierarchie_typ_bez   --standard=deutsch
   , MAX(CASE WHEN spr_id =   22 THEN ma_hierarchie_typ_bez ELSE NULL END) AS ma_hierarchie_typ_bez_de  --deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN ma_hierarchie_typ_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN ma_hierarchie_typ_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_hierarchie_typ_bez  ELSE NULL END)
   END AS ma_hierarchie_typ_bez_cz                     --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN ma_hierarchie_typ_bez  ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN ma_hierarchie_typ_bez  ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_hierarchie_typ_bez  ELSE NULL END)
   END AS ma_hierarchie_typ_bez_pl                   --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN ma_hierarchie_typ_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN ma_hierarchie_typ_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_hierarchie_typ_bez ELSE NULL END)
   END AS ma_hierarchie_typ_bez_sk                   -- slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN ma_hierarchie_typ_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN ma_hierarchie_typ_bez  ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_hierarchie_typ_bez ELSE NULL END)
   END AS ma_hierarchie_typ_bez_hr                   -- kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN ma_hierarchie_typ_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN ma_hierarchie_typ_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_hierarchie_typ_bez  ELSE NULL END)
   END AS ma_hierarchie_typ_bez_ro                   --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN ma_hierarchie_typ_bez  ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN ma_hierarchie_typ_bez  ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ma_hierarchie_typ_bez ELSE NULL END)
   END AS ma_hierarchie_typ_bez_bg                 -- bulgarisch
   FROM dbp_view.v_ma_hierarchie_typ_spr_zu  v01
   GROUP BY
   mandant_id
   ,ma_hierarchie_typ_id;