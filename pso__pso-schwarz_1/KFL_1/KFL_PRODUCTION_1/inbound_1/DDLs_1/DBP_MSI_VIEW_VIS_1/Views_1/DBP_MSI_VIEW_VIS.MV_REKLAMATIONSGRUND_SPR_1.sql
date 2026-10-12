CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_REKLAMATIONSGRUND_SPR_1 as
   -- SPRACHE : Reklamationsgrund
   -- 2012KW07 : Initial (QBM-Bericht)
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten
   SELECT
   v01.mandant_id, v01.reklamationsgrund_id, MAX(CASE WHEN spr_id =   22 THEN reklamationsgrund_bez ELSE NULL END) AS reklamationsgrund_bez         --standard=deutsch
   , MAX(CASE WHEN spr_id =   22 THEN reklamationsgrund_bez ELSE NULL END) AS reklamationsgrund_bez_de  --deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN reklamationsgrund_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN reklamationsgrund_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN reklamationsgrund_bez  ELSE NULL END)
   END AS reklamationsgrund_bez_cz                     --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN reklamationsgrund_bez  ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN reklamationsgrund_bez  ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN reklamationsgrund_bez  ELSE NULL END)
   END AS reklamationsgrund_bez_pl                   --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN reklamationsgrund_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN reklamationsgrund_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN reklamationsgrund_bez ELSE NULL END)
   END AS reklamationsgrund_bez_sk                 --slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN reklamationsgrund_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN reklamationsgrund_bez  ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN reklamationsgrund_bez ELSE NULL END)
   END AS reklamationsgrund_bez_hr                   --kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN reklamationsgrund_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN reklamationsgrund_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN reklamationsgrund_bez  ELSE NULL END)
   END AS reklamationsgrund_bez_ro                   --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN reklamationsgrund_bez  ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN reklamationsgrund_bez  ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN reklamationsgrund_bez ELSE NULL END)
   END AS reklamationsgrund_bez_bg                 --bulgarisch
   , v02.mandant_kbez
   FROM dbp_view.v_reklamationsgrund_spr_zu_1 v01
   INNER JOIN dbp_view.v_mandant_1 v02
   ON v01.mandant_id = v02.mandant_id
   group by
   v01.mandant_id
   ,v01.reklamationsgrund_id
   ,v02.mandant_kbez;