CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SB_BT_BEREICH_SPR_ZU_2
-- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten
(
beurteilung_bereich_id
,mandant_id
,beurteilung_bereich_bez
,beurteilung_bereich_bez_de
,beurteilung_bereich_bez_cz
,beurteilung_bereich_bez_pl
,beurteilung_bereich_bez_sk
,beurteilung_bereich_bez_hr
,beurteilung_bereich_bez_ro
,beurteilung_bereich_bez_bg
)
AS
   SELECT
  beurteilung_bereich_id, mandant_id, MAX(CASE WHEN spr_id =  22 THEN beurteilung_bereich_bez ELSE NULL END) AS beurteilung_bereich_bez     --standard=deutsch
   , MAX(CASE WHEN spr_id =  22 THEN beurteilung_bereich_bez ELSE NULL END) AS beurteilung_bereich_bez_de  --deutsch
   , MAX(CASE WHEN spr_id = 124 THEN beurteilung_bereich_bez ELSE NULL END) AS beurteilung_bereich_bez_cz  --tschechisch
   , MAX(CASE WHEN spr_id =  90 THEN beurteilung_bereich_bez ELSE NULL END) AS beurteilung_bereich_bez_pl  --polnisch
   , MAX(CASE WHEN spr_id = 108 THEN beurteilung_bereich_bez ELSE NULL END) AS beurteilung_bereich_bez_sk  --slowakisch
   , MAX(CASE WHEN spr_id =  65 THEN beurteilung_bereich_bez ELSE NULL END) AS beurteilung_bereich_bez_hr  --kroatisch
   , MAX(CASE WHEN spr_id =  95 THEN beurteilung_bereich_bez ELSE NULL END) AS beurteilung_bereich_bez_ro  --rumänisch
   , MAX(CASE WHEN spr_id =  18 THEN beurteilung_bereich_bez ELSE NULL END) AS beurteilung_bereich_bez_bg  --bulgarisch
   FROM dbp_view.v_sb_beurteil_bereich_spr_zu_2  v01
   GROUP BY
   beurteilung_bereich_id
   ,mandant_id;