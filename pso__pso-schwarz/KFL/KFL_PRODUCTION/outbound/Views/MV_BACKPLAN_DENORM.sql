CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_backplan_denorm AS

   -- BACKPLANUNG DENORMALISIERT : ARTIKEL - TAG - FILIALE
   -- 2014-05-12 : VERSION05, AGGREGAT; INNER JOIN BACKDATEN; LOGIK VERFEINERT
   -- 2014-05-21 : FINETUNING LOGIK; PROD-VERSION
   -- 2014-06-24 : ANPASSUNG JOIN BACKZEIT/LIEFERANT
   -- 2014-06-27 : KORREKTUR FORMEL ULD
   -- 2015-06-19 2015KW26 : KMO. KL_ART_NR 8STELLIG. ANPASSUNG MANDANT/SPRACHE/JOINS. JOIN ART_SPR_ZU ENTFERNT.
   -- 2016-06-07 : KORREKTUR ZAHLENFORMAT AUF DECIMAL(18,3), ANPASSUNG FORMELN/LOGIK BEI 'NEUEN' ARTIKELN (MENGE_AVG=0)

SELECT
t.*,

t.menge_prog01 + t.menge_prog02 AS menge_prog12,

t.menge_prog01 / t.bb AS blech_prog01,
t.menge_prog02 / t.bb AS blech_prog02,
t.menge_prog03 / t.bb AS blech_prog03,

(t.menge_prog01 + t.menge_prog02) / t.bb AS blech_prog12,
t.menge_prog_org / t.bb AS blech_prog,

0.999 + CAST((t.menge_prog01 / t.bb) AS INT64) AS blech_rund01,
0.999 + CAST((t.menge_prog02 / t.bb) AS INT64) AS blech_rund02,
0.999 + CAST((t.menge_prog03 / t.bb) AS INT64) AS blech_rund03,

0.999 + CAST(((t.menge_prog01 + t.menge_prog02) / t.bb) AS INT64) AS blech_rund12,

4 AS langsam       -- SCHWELLWERT ULTRALANGSAMDREHER (4 BLECHE/TAG)

, CASE WHEN (t.menge_prog_org / t.bb) <= 4 THEN 0 ELSE 1 END AS std           -- STANDARD > 4 BLECH
, CASE WHEN (t.menge_prog_org / t.bb) <= 4 THEN 1 ELSE 0 END AS uld           -- ULTRALANGSAMDREHER <= 4 BLECH

FROM (

SELECT
bp.mandant_id,

LPAD(
CAST(
CASE WHEN bp.mandant_id = 1 THEN (bp.art_id/100)
ELSE (bp.art_id/10)
END AS STRING
),
8,'0') AS kl_art_nr,

absz.art_backen_bez,
bp.art_id           -- VK-ARTIKEL

, bp.wup_id
, bp.nb_id AS nb_id
, CAST('' AS STRING) AS loesch_id
, bp.listung_id
, bp.aktion_fg
, bp.aktion_fg AS art_aktion_id -- AUSBAUEN

, back.ofen_typ_id
, back.anz_ofen
, back.anz_backblech
, back.back_programm_id
, back.back_dauer
, back.back_hinweis_id
, back.back_hinweis_bez
, back.back_aufbereitung_id
, COALESCE(back.back_aufbereitung_bez,'') AS back_aufbereitung_bez
, back.blech_belegung                                                              -- ANZAHL ARTIKEL PRO BLECH

, COALESCE(back.blech_belegung,1) AS bb            -- FUER BERECHNUNG

, bp.dat
, bp.menge_check                                                  AS menge_check   -- DURCHSCHN. MENGE/ABVERKAUF BIS 16H

, bp.anteil_01 + bp.anteil_02 + bp.anteil_03 + bp.anteil_04       AS menge_avg     -- DURCHSCHN. MENGE/ABVERKAUF TAG

, bp.menge_prognose /
NULLIF((bp.anteil_01 + bp.anteil_02 + bp.anteil_03 + bp.anteil_04),0) AS faktor        -- FAKTOR PROGNOSE/ABVERKAUF

, CAST(bp.menge_prognose AS NUMERIC)                               AS menge_prog_org -- PROGNOSE TAG (WIE GESPEICHERT) FUR

, 0.999 + CAST(bp.menge_prognose AS INT64)                             AS menge_prog    -- PROGNOSE TAG (AUFGERUNDET) FUR

, CAST(
COALESCE(bp.anteil_01 *
(bp.menge_prognose /
NULLIF((bp.anteil_01 + bp.anteil_02 + bp.anteil_03 + bp.anteil_04),0)),
bp.menge_prognose)
AS NUMERIC) AS menge_prog01  -- PROGNOSE BACKINTERVALL 01 (TAGSWERT WENN KEINE VERTEILUNG)

, CAST(
COALESCE(bp.anteil_02 *
(bp.menge_prognose /
NULLIF((bp.anteil_01 + bp.anteil_02 + bp.anteil_03 + bp.anteil_04),0)),
0)
AS NUMERIC) AS menge_prog02  -- PROGNOSE BACKINTERVALL 01 (0 WENN KEINE VERTEILUNG)

, CAST(
COALESCE(bp.anteil_03 *
(bp.menge_prognose /
NULLIF((bp.anteil_01 + bp.anteil_02 + bp.anteil_03 + bp.anteil_04),0)),
0)
AS NUMERIC) AS menge_prog03  -- PROGNOSE BACKINTERVALL 01 (0 WENN KEINE VERTEILUNG)

, CAST(
COALESCE(bp.anteil_04 *
(bp.menge_prognose /
NULLIF((bp.anteil_01 + bp.anteil_02 + bp.anteil_03 + bp.anteil_04),0)),
0)
AS NUMERIC) AS menge_prog04  -- PROGNOSE BACKINTERVALL 01 (0 WENN KEINE VERTEILUNG)

, bp.min_sicherh_bestand                                                           -- MINDESTBESTAND >> AKTUELL NICHT VERWENDET

FROM kfl_production_dbp_msi_v_view.v_backshop_prognose bp

-- BEZEICHNUNG BACKARTIKEL
JOIN kfl_production_dbp_view.v_art_backen_spr_zu absz  

ON bp.art_id = absz.art_id
AND bp.mandant_id = absz.mandant_id
AND ((absz.mandant_id=1 AND absz.spr_id=22) OR (absz.mandant_id<>1 AND absz.spr_id<>22))

JOIN
( -- BACKSHOP-OFEN-ARTIKEL
SELECT
wbp.mandant_id, wbp.wup_id, wbp.anz_ofen, aoz.art_id, aoz.ofen_typ_id, lo.anz_backblech, aoz.blech_belegung, abz.back_programm_id, lb.back_dauer, lb.gp_backen_bez -- NEU LIEFERANT (NUR BEI MANCHEN PROGRAMMEN)
, abhz.back_hinweis_id, bhsz.back_hinweis_bez, abaz.back_aufbereitung_id, basz.back_aufbereitung_bez
FROM kfl_production_dbp_view.v_wup_backshop_per wbp

JOIN kfl_production_dbp_view.v_art_ofentyp_zu aoz
ON wbp.mandant_id = aoz.mandant_id
AND wbp.ofen_typ_id = aoz.ofen_typ_id

JOIN kfl_production_dbp_view.v_l_ofentyp lo
ON wbp.mandant_id = lo.mandant_id
AND wbp.ofen_typ_id = lo.ofen_typ_id

JOIN kfl_production_dbp_view.v_art_backprogramm_zu abz
ON aoz.mandant_id = abz.mandant_id
AND aoz.art_id = abz.art_id

JOIN kfl_production_dbp_view.v_l_backzeit lb
ON wbp.mandant_id = lb.mandant_id
AND wbp.ofen_typ_id = lb.ofen_typ_id
AND abz.back_programm_id = lb.back_programm_id
AND (wbp.gp_backen_bez = lb.gp_backen_bez OR lb.gp_backen_bez = '') -- NEU LIEFERANTENABHAENGIG

JOIN kfl_production_dbp_view.v_art_back_aufbereitung_zu abaz
ON aoz.mandant_id = abaz.mandant_id
AND aoz.art_id = abaz.art_id

JOIN kfl_production_dbp_view.v_back_aufbereitung_spr_zu basz
ON aoz.mandant_id = basz.mandant_id
AND abaz.back_aufbereitung_id = basz.back_aufbereitung_id

JOIN kfl_production_dbp_view.v_art_back_hinweis_zu abhz
ON aoz.mandant_id = abhz.mandant_id
AND aoz.art_id = abhz.art_id

JOIN kfl_production_dbp_view.v_back_hinweis_spr_zu bhsz
ON aoz.mandant_id = bhsz.mandant_id
AND abhz.back_hinweis_id = bhsz.back_hinweis_id

WHERE wbp.nb_id = 0
AND wbp.dat_bis = DATE '9999-12-31'
) back

ON  bp.art_id = back.art_id
AND bp.mandant_id = back.mandant_id
AND bp.wup_id = back.wup_id

) t;