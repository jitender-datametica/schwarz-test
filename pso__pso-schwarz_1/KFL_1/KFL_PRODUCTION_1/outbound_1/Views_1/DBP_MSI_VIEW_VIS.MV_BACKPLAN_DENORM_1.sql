CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_backplan_denorm_1 (
   mandant_id,
   kl_art_nr,
   art_backen_bez,
   art_id,
   wup_id,
   nb_id,
   loesch_id,
   listung_id,
   aktion_fg,
   art_aktion_id,
   ofen_typ_id,
   anz_ofen,
   anz_backblech,
   back_programm_id,
   back_dauer,
   back_hinweis_id,
   back_hinweis_bez,
   back_aufbereitung_id,
   back_aufbereitung_bez,
   blech_belegung,
   bb,
   dat,
   menge_check,
   menge_avg,
   faktor,
   menge_prog_org,
   menge_prog,
   menge_prog01,
   menge_prog02,
   menge_prog03,
   menge_prog04,
   menge_prog12,
   blech_prog01,
   blech_prog02,
   blech_prog03,
   blech_prog12,
   blech_prog,
   blech_rund01,
   blech_rund02,
   blech_rund03,
   blech_rund12,
   langsam,
   std,
   uld,
   min_sicherh_bestand,
   min_rest,
   rest01,
   blech01s,
   rest02,
   blech02s,
   rest03,
   blech03s,
   blech04s,
   rest12,
   blech01u,
   blech03u,
   blech01,
   blech02,
   blech03,
   blech04,
   menge01,
   menge02,
   menge03,
   menge04
) AS

WITH base_data AS (
   SELECT
      bp.mandant_id,
      FORMAT('%08d', CAST(CASE WHEN bp.mandant_id=1 THEN (bp.art_id/100) ELSE (bp.art_id/10) END AS INT64)) AS kl_art_nr,
      absz.art_backen_bez,
      bp.art_id,
      bp.wup_id,
      bp.nb_id AS nb_id,
      CAST('' AS STRING) AS loesch_id,
      bp.listung_id,
      bp.aktion_fg,
      bp.aktion_fg AS art_aktion_id,
      back.ofen_typ_id,
      back.anz_ofen,
      back.anz_backblech,
      back.back_programm_id,
      back.back_dauer,
      back.back_hinweis_id,
      back.back_hinweis_bez,
      back.back_aufbereitung_id,
      COALESCE(back.back_aufbereitung_bez, '') AS back_aufbereitung_bez,
      back.blech_belegung,
      COALESCE(back.blech_belegung, 1) AS bb,
      bp.dat,
      bp.menge_check,
      bp.anteil_01 + bp.anteil_02 + bp.anteil_03 + bp.anteil_04 AS menge_avg,
      CAST(bp.menge_prognose AS NUMERIC) AS menge_prog_org,
      bp.menge_prognose,
      bp.anteil_01, bp.anteil_02, bp.anteil_03, bp.anteil_04,
      bp.min_sicherh_bestand
   FROM kfl_production_dbp_msi_v_view.v_backshop_prognose_1 bp
   JOIN kfl_production_dbp_view.v_art_backen_spr_zu_1 absz
     ON bp.art_id = absz.art_id
    AND bp.mandant_id = absz.mandant_id
    AND ((absz.mandant_id=1 AND absz.spr_id=22) OR (absz.mandant_id<>1 AND absz.spr_id<>22))
   JOIN (
      SELECT
         wbp.mandant_id, wbp.wup_id, wbp.anz_ofen, aoz.art_id, aoz.ofen_typ_id, lo.anz_backblech, aoz.blech_belegung, abz.back_programm_id, lb.back_dauer, lb.gp_backen_bez,
         abhz.back_hinweis_id, bhsz.back_hinweis_bez, abaz.back_aufbereitung_id, basz.back_aufbereitung_bez
      FROM kfl_production_dbp_view.v_wup_backshop_per_1 wbp
      JOIN kfl_production_dbp_view.v_art_ofentyp_zu_1 aoz
        ON wbp.mandant_id = aoz.mandant_id
       AND wbp.ofen_typ_id = aoz.ofen_typ_id
      JOIN kfl_production_dbp_view.v_l_ofentyp_1 lo
        ON wbp.mandant_id = lo.mandant_id
       AND wbp.ofen_typ_id = lo.ofen_typ_id
      JOIN kfl_production_dbp_view.v_art_backprogramm_zu_1 abz
        ON aoz.mandant_id = abz.mandant_id
       AND aoz.art_id = abz.art_id
      JOIN kfl_production_dbp_view.v_l_backzeit_1 lb
        ON wbp.mandant_id = lb.mandant_id
       AND wbp.ofen_typ_id = lb.ofen_typ_id
       AND abz.back_programm_id = lb.back_programm_id
       AND (wbp.gp_backen_bez = lb.gp_backen_bez OR lb.gp_backen_bez = '')
      JOIN kfl_production_dbp_view.v_art_back_aufbereitung_zu_1 abaz
        ON aoz.mandant_id = abaz.mandant_id
       AND aoz.art_id = abaz.art_id
      JOIN kfl_production_dbp_view.v_back_aufbereitung_spr_zu_1 basz
        ON aoz.mandant_id = basz.mandant_id
       AND abaz.back_aufbereitung_id = basz.back_aufbereitung_id
      JOIN kfl_production_dbp_view.v_art_back_hinweis_zu_1 abhz
        ON aoz.mandant_id = abhz.mandant_id
       AND aoz.art_id = abhz.art_id
      JOIN kfl_production_dbp_view.v_back_hinweis_spr_zu_1 bhsz
        ON aoz.mandant_id = bhsz.mandant_id
       AND abhz.back_hinweis_id = bhsz.back_hinweis_id
      WHERE wbp.nb_id = 0
        AND wbp.dat_bis = CAST('9999-12-31' AS DATE)
   ) back
     ON bp.art_id = back.art_id
    AND bp.mandant_id = back.mandant_id
    AND bp.wup_id = back.wup_id
),
step1 AS (
   SELECT *,
      menge_prognose / NULLIF(menge_avg, 0) AS faktor,
      0.999 + CAST(menge_prognose AS INT64) AS menge_prog,
      CAST(menge_prognose AS NUMERIC) / CAST(bb AS NUMERIC) AS blech_prog,
      4 AS langsam
   FROM base_data
),
step2 AS (
   SELECT *,
      CAST(COALESCE(anteil_01 * faktor, menge_prog_org) AS NUMERIC) AS menge_prog01,
      CAST(COALESCE(anteil_02 * faktor, 0) AS NUMERIC) AS menge_prog02,
      CAST(COALESCE(anteil_03 * faktor, 0) AS NUMERIC) AS menge_prog03,
      CAST(COALESCE(anteil_04 * faktor, 0) AS NUMERIC) AS menge_prog04,
      CASE WHEN blech_prog <= langsam THEN 0 ELSE 1 END AS STD,
      CASE WHEN blech_prog <= langsam THEN 1 ELSE 0 END AS ULD,
      blech_prog - (min_sicherh_bestand / bb) AS min_rest
   FROM step1
),
step3 AS (
   SELECT *,
      menge_prog01 + menge_prog02 AS menge_prog12,
      menge_prog01 / CAST(bb AS NUMERIC) AS blech_prog01,
      menge_prog02 / CAST(bb AS NUMERIC) AS blech_prog02,
      menge_prog03 / CAST(bb AS NUMERIC) AS blech_prog03
   FROM step2
),
step4 AS (
   SELECT *,
      menge_prog12 / CAST(bb AS NUMERIC) AS blech_prog12,
      0.999 + CAST(blech_prog01 AS INT64) AS blech_rund01,
      0.999 + CAST(blech_prog02 AS INT64) AS blech_rund02,
      0.999 + CAST(blech_prog03 AS INT64) AS blech_rund03
   FROM step3
),
step5 AS (
   SELECT *,
      0.999 + CAST(blech_prog12 AS INT64) AS blech_rund12,
      blech_prog - (0.999 + CAST(blech_prog01 AS INT64)) AS rest01
   FROM step4
),
step6 AS (
   SELECT *,
      CASE
         WHEN menge_avg = 0 THEN menge_prog / bb
         WHEN rest01 >= blech_rund01 THEN blech_rund01
         WHEN rest01 >= blech_prog01 THEN blech_prog01
         ELSE rest01
      END AS blech01s
   FROM step5
),
step7 AS (
   SELECT *,
      (blech_prog - blech01s) AS rest02
   FROM step6
),
step8 AS (
   SELECT *,
      CASE
         WHEN menge_avg = 0 THEN 0.000
         WHEN rest02 >= blech_rund02 THEN blech_rund02
         WHEN rest02 >= blech_prog02 THEN blech_prog02
         ELSE rest02
      END AS blech02s
   FROM step7
),
step9 AS (
   SELECT *,
      (blech_prog - (blech01s + blech02s)) AS rest03
   FROM step8
),
step10 AS (
   SELECT *,
      CASE
         WHEN menge_avg = 0 THEN 0.000
         WHEN rest03 >= blech_rund03 THEN blech_rund03
         WHEN rest03 >= blech_prog03 THEN blech_prog03
         ELSE rest03
      END AS blech03s,
      (blech_prog - blech_rund12) AS rest12
   FROM step9
),
step11 AS (
   SELECT *,
      CASE
         WHEN menge_avg = 0 THEN 0.000
         ELSE (blech_prog - (blech01s + blech02s + blech03s))
      END AS blech04s,
      CASE
         WHEN blech_rund12 <= blech_prog THEN blech_rund12
         WHEN blech_prog12 <= blech_prog12 THEN blech_prog12
         ELSE 0
      END AS blech01u
   FROM step10
),
step12 AS (
   SELECT *,
      (blech_prog - blech01u) AS blech03u
   FROM step11
),
step13 AS (
   SELECT *,
      STD * blech01s + ULD * blech01u AS blech01,
      STD * blech02s AS blech02,
      STD * blech03s + ULD * blech03u AS blech03,
      STD * blech04s AS blech04
   FROM step12
),
step14 AS (
   SELECT *,
      0.999 + CAST((blech01 * bb) AS INT64) AS menge01,
      0.999 + CAST((blech02 * bb) AS INT64) AS menge02
   FROM step13
),
step15 AS (
   SELECT *,
      CASE
         WHEN menge_prog - (menge01 + menge02 + (blech03 * bb)) < 0 THEN 0
         ELSE 0.999
      END + CAST((blech03 * bb) AS INT64) AS menge03
   FROM step14
)
SELECT
   mandant_id,
   kl_art_nr,
   art_backen_bez,
   art_id,
   wup_id,
   nb_id,
   loesch_id,
   listung_id,
   aktion_fg,
   art_aktion_id,
   ofen_typ_id,
   anz_ofen,
   anz_backblech,
   back_programm_id,
   back_dauer,
   back_hinweis_id,
   back_hinweis_bez,
   back_aufbereitung_id,
   back_aufbereitung_bez,
   blech_belegung,
   bb,
   dat,
   menge_check,
   menge_avg,
   faktor,
   menge_prog_org,
   menge_prog,
   menge_prog01,
   menge_prog02,
   menge_prog03,
   menge_prog04,
   menge_prog12,
   blech_prog01,
   blech_prog02,
   blech_prog03,
   blech_prog12,
   blech_prog,
   blech_rund01,
   blech_rund02,
   blech_rund03,
   blech_rund12,
   langsam,
   std,
   uld,
   min_sicherh_bestand,
   min_rest,
   rest01,
   blech01s,
   rest02,
   blech02s,
   rest03,
   blech03s,
   blech04s,
   rest12,
   blech01u,
   blech03u,
   blech01,
   blech02,
   blech03,
   blech04,
   menge01,
   menge02,
   menge03,
   0.999 + CAST(menge_prog - (menge01 + menge02 + menge03) AS INT64) AS MENGE04
FROM step15;