CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SB_AGG_GRUND_HELPER as
   -- Hilfstabelle für Rekursive View mv_sb_agg_grund_rek_spr_zu
   -- 20130611 Initial
   -- 2015KW05 : ohne geloeschte SB (Filter loesch_fg=0)

   SELECT
   s01.mandant_id, s01.beurteilung_id, 10::BYTEINT                   AS sb_ebene         -- Ebene 10 : Bereichs-Note + Gruende
   , s02.beurteilung_bereich_id     AS sb_id, COALESCE(s022.sb_grund_id, -1) AS sb_grund_id, ROW_NUMBER() OVER (PARTITION BY s01.mandant_id, s01.beurteilung_id, sb_ebene, sb_id ORDER BY s01.mandant_id, s01.beurteilung_id, sb_ebene, sb_id, sb_grund_id) sb_count

   FROM dbp_view.v_sb_beurteilung s01

   JOIN dbp_view.v_sb_beurteil_bereichsnote s02
   ON  s01.beurteilung_id = s02.beurteilung_id
   AND s01.mandant_id = s02.mandant_id
   LEFT JOIN dbp_view.v_sb_beurteil_brch_grund_zu s022
   ON  s02.bereichsnote_id = s022.bereichsnote_id
   AND s02.mandant_id = s022.mandant_id

   WHERE s01.loesch_fg = 0
   ;