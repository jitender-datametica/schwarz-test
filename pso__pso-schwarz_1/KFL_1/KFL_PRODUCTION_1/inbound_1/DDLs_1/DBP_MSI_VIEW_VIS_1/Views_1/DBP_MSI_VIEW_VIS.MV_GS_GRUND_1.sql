CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GS_GRUND_1 as
   -- SPRACHE Geschenk-Karten Grund [ausgeber/ausgeber_typ]
   -- 2010KW17 GSS Redesign + Rollout KMO
   -- 2011KW37 Internationaliserung (feste Sprache)
   -- 2011Kw46 Erweiterung Dummy_1
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten

   SELECT
   mandant_id, ausgeber_typ_id  --> Bereich
   , ausgeber_id   --> Grund
   , MAX(CASE WHEN spr_id =   22 THEN ausgeber_bez ELSE NULL END)    AS ausgeber_bez        --standard=deutsch
   , MAX(CASE WHEN spr_id =   22 THEN ausgeber_bez ELSE NULL END)    AS ausgeber_bez_de     --deutsch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 124 THEN ausgeber_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 124 THEN ausgeber_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ausgeber_bez ELSE NULL END)
   END  AS ausgeber_bez_cz                   --tschechisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 90 THEN ausgeber_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 90 THEN ausgeber_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ausgeber_bez ELSE NULL END)
   END  AS ausgeber_bez_pl                 --polnisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 108 THEN ausgeber_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 108 THEN ausgeber_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ausgeber_bez ELSE NULL END)
   END  AS ausgeber_bez_sk                 --slowakisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 65 THEN ausgeber_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 65 THEN ausgeber_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ausgeber_bez ELSE NULL END)
   END  AS ausgeber_bez_hr                 --kroatisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 95 THEN ausgeber_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 95 THEN ausgeber_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ausgeber_bez ELSE NULL END)
   END  AS ausgeber_bez_ro                 --rumänisch
   , CASE
   WHEN MAX(CASE WHEN spr_id = 18 THEN ausgeber_bez ELSE NULL END) IS NOT NULL
   THEN MAX(CASE WHEN spr_id = 18 THEN ausgeber_bez ELSE NULL END)
   ELSE
   MAX(CASE WHEN spr_id =   22 THEN ausgeber_bez ELSE NULL END)
   END  AS ausgeber_bez_bg                 --bulgarisch
   FROM dbp_view.v_ausgeber_spr_zu_1  v01
   GROUP BY
   mandant_id
   ,ausgeber_typ_id    --> Bereich
   ,ausgeber_id      --> Grund
   UNION ALL
   SELECT
   mandant_id, ausgeber_typ_id                --> Bereich
   , '0'::VARCHAR(10)         AS ausgeber_id      --> Grund
   , 'nicht zugeordnet ' || ausgeber_typ_bez || '' AS ausgeber_bez, 'nicht zugeordnet ' || ausgeber_typ_bez || '' AS ausgeber_bez_de, 'nicht zugeordnet ' || ausgeber_typ_bez || '' AS ausgeber_bez_cz, 'nicht zugeordnet ' || ausgeber_typ_bez || '' AS ausgeber_bez_pl, 'nicht zugeordnet ' || ausgeber_typ_bez || '' AS ausgeber_bez_sk, 'nicht zugeordnet ' || ausgeber_typ_bez || '' AS ausgeber_bez_hr, 'nicht zugeordnet ' || ausgeber_typ_bez || '' AS ausgeber_bez_ro, 'nicht zugeordnet ' || ausgeber_typ_bez || '' AS ausgeber_bez_bg
   FROM dbp_view.v_ausgeber_typ_spr_zu_1 v01
   WHERE
   spr_id = 22;