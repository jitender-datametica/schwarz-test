CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_SB_AGGREGAT_1 as
   -- LOOKUP Bezeichnungen fuer Filiale/Gesamt - Bereich - Detail
   -- Denormaliserte Variante >> Internationalisierung : Gesamt anzupassen!
   -- 20120126 Initial
   -- 20120213 Optimierung + Erweiterung Grund
   -- 20120416 Anpassung Grund + Ebenen

   SELECT
   sub01.mandant_id, sub01.sb_ebene, sub01.sb_id
   FROM
   (
   -- Ebene 20 : Detail mit Grund
   SELECT
   mandant_id, 20::BYTEINT            AS sb_ebene, beurteilung_detail_id   AS sb_id, beurteilung_detail_bez  AS sb_bez
   FROM dbp_view.v_sb_beurteil_detail_spr_zu_1
   WHERE spr_id = 22
   -- Ebene 21 : Detail
   UNION ALL
   SELECT
   mandant_id, 21::BYTEINT            AS sb_ebene, beurteilung_detail_id   AS sb_id, beurteilung_detail_bez  AS sb_bez
   FROM dbp_view.v_sb_beurteil_detail_spr_zu_1
   WHERE spr_id = 22
   -- Ebene 22 : Detail / Grund
   UNION ALL
   SELECT
   mandant_id, 22::BYTEINT            AS sb_ebene, beurteilung_detail_id   AS sb_id, beurteilung_detail_bez  AS sb_bez
   FROM dbp_view.v_sb_beurteil_detail_spr_zu_1
   WHERE spr_id = 22

   -- Ebene 10 : Bereich mit Grund
   UNION ALL
   SELECT
   mandant_id, 10::BYTEINT            AS sb_ebene, beurteilung_bereich_id  AS sb_id, beurteilung_bereich_bez AS sb_bez
   FROM dbp_view.v_sb_beurteil_bereich_spr_zu_1
   WHERE spr_id = 22
   -- Ebene 11 : Bereich
   UNION ALL
   SELECT
   mandant_id, 11::BYTEINT            AS sb_ebene, beurteilung_bereich_id  AS sb_id, beurteilung_bereich_bez AS sb_bez
   FROM dbp_view.v_sb_beurteil_bereich_spr_zu_1
   WHERE spr_id = 22
   -- Ebene 12 : Bereich / Grund
   UNION ALL
   SELECT
   mandant_id, 12::BYTEINT            AS sb_ebene, beurteilung_bereich_id  AS sb_id, beurteilung_bereich_bez AS sb_bez
   FROM dbp_view.v_sb_beurteil_bereich_spr_zu_1
   WHERE spr_id = 22

   -- Ebene 0 : Gesamt mit Grund
   UNION ALL
   SELECT
   mandant_id, 0::BYTEINT             AS sb_ebene, -1::INTEGER            AS sb_id, 'Filiale/Gesamt'        AS sb_bez
   FROM dbp_view.v_mandant_1
   WHERE mandant_id <> 4
   -- Ebene 1 : Gesamt
   UNION ALL
   SELECT
   mandant_id, 1::BYTEINT             AS sb_ebene, -1::INTEGER            AS sb_id, 'Filiale/Gesamt'        AS sb_bez
   FROM dbp_view.v_mandant_1
   WHERE mandant_id <> 4
   -- Ebene 2 : Gesamt / Grund
   UNION ALL
   SELECT
   mandant_id, 2::BYTEINT             AS sb_ebene, -1::INTEGER            AS sb_id, 'Filiale/Gesamt'        AS sb_bez
   FROM dbp_view.v_mandant_1
   WHERE mandant_id <> 4
   ) sub01;