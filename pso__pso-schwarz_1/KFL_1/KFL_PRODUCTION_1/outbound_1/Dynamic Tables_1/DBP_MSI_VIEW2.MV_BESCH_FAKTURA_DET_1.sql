CREATE OR REPLACE TABLE kfl_production_dbp_msi_view2.mv_besch_faktura_det_1 (
  art_id BIGNUMERIC(38, 0),
  mandant_id BIGNUMERIC(38, 0),
  vz_nb_id BIGNUMERIC(38, 0),
  vz_wup_id BIGNUMERIC(38, 0),
  dat_faktura DATE,
  faktura_typ_id STRING(4),
  wup_id BIGNUMERIC(38, 0),
  nb_id BIGNUMERIC(38, 0),
  gp_id BIGNUMERIC(38, 0),
  posten_kz_per STRING(2),
  retoure_fg BIGNUMERIC(38, 0),
  bestellart_id STRING(4),
  faktura_beleg_id INT64,
  faktura_menge_bme NUMERIC(18, 3),
  faktura_menge_kolli NUMERIC(18, 3),
  faktura_wert_ek_netto NUMERIC(18, 2),
  faktura_wert_ek_brutto NUMERIC(18, 2),
  faktura_zekp_ek_netto_bnk NUMERIC(18, 2),
  faktura_zekp_ek_mep NUMERIC(18, 2),
  faktura_zekp_ek_mepolk NUMERIC(18, 2)
) AS
SELECT
  v01.art_id AS art_id,
  v01.mandant_id AS mandant_id,
  v01.nb_id AS vz_nb_id,
  v01.wup_id AS vz_wup_id,
  v01.dat_faktura AS dat_faktura,
  v02.faktura_typ_id AS faktura_typ_id,
  v03.wup_id AS wup_id,
  v03.nb_id AS nb_id,
  v09.gp_id AS gp_id,
  SUBSTR(CASE WHEN NOT v10.posten_id IN ('PN', 'PF', 'SP') THEN 'SO' ELSE 'PN' END, 1, 2) AS posten_kz_per,
  CAST(CASE WHEN v02.faktura_typ_id IN ('O', 'S') THEN 1 ELSE 0 END AS BIGNUMERIC) AS retoure_fg,
  v01.bestellart_id AS bestellart_id,
  v01.faktura_beleg_id AS faktura_beleg_id,
  CAST(CASE
    WHEN v02.faktura_typ_id IN ('O', 'N')
    THEN v01.menge_faktura_bme * -1
    ELSE v01.menge_faktura_bme
  END AS NUMERIC) AS faktura_menge_bme,
  CAST(CASE
    WHEN v02.faktura_typ_id IN ('O', 'N')
    THEN v01.menge_faktura_kolli * -1
    ELSE v01.menge_faktura_kolli
  END AS NUMERIC) AS faktura_menge_kolli,
  ROUND(
    CAST(CASE
      WHEN v02.faktura_typ_id IN ('O', 'N')
      THEN (
        v01.zwsum_3_betrag - v01.zwsum_4_betrag - v01.zwsum_9_betrag
      ) * -1
      ELSE v01.zwsum_3_betrag - v01.zwsum_4_betrag - v01.zwsum_9_betrag
    END AS NUMERIC),
    2
  ) AS faktura_wert_ek_netto,
  ROUND(
    CAST(CASE
      WHEN v02.faktura_typ_id IN ('O', 'N')
      THEN (
        v01.zwsum_3_betrag - v01.zwsum_4_betrag - v01.zwsum_9_betrag
      ) * ROUND(CAST(v01.mwst / 100 + 1 AS BIGNUMERIC), 5) * -1
      ELSE (
        v01.zwsum_3_betrag - v01.zwsum_4_betrag - v01.zwsum_9_betrag
      ) * ROUND(CAST(v01.mwst / 100 + 1 AS BIGNUMERIC), 5)
    END AS NUMERIC),
    2
  ) AS faktura_wert_ek_brutto,
  ROUND(
    CAST(CASE
      WHEN v02.faktura_typ_id IN ('O', 'N')
      THEN v01.ek_netto_bnk * -1
      ELSE v01.ek_netto_bnk
    END AS NUMERIC),
    2
  ) AS faktura_zekp_ek_netto_bnk,
  ROUND(
    CAST(CASE WHEN v02.faktura_typ_id IN ('O', 'N') THEN v01.ek_mep * -1 ELSE v01.ek_mep END AS NUMERIC),
    2
  ) AS faktura_zekp_ek_mep,
  ROUND(
    CAST(CASE
      WHEN v02.faktura_typ_id IN ('O', 'N')
      THEN (
        v01.ek_mep - v01.zwsum_6_betrag
      ) * -1
      ELSE v01.ek_mep - v01.zwsum_6_betrag
    END AS NUMERIC),
    2
  ) AS faktura_zekp_ek_mepolk
FROM kfl_production_dbp_view.v_besch_faktura_det_1 AS v01
INNER JOIN kfl_production_dbp_view.v_besch_faktura_1 AS v02
  ON v01.faktura_beleg_id = v02.faktura_beleg_id
  AND v01.mandant_id = v02.mandant_id
  AND v01.dat_faktura_sap = v02.dat_faktura_sap
  AND v02.auftraggeber_id BETWEEN '0000001000' AND '0000009999'
INNER JOIN kfl_production_dbp_view.v_wup_1 AS v03
  ON ROUND(SAFE_CAST(v02.auftraggeber_id AS BIGNUMERIC), 0) = v03.wup_id
  AND v01.mandant_id = v03.mandant_id
INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS v05
  ON v01.art_id = v05.art_id
  AND v01.mandant_id = v05.mandant_id
  AND CURRENT_DATE BETWEEN v05.dat_von AND v05.dat_bis
INNER JOIN kfl_production_dbp_view.v_wg_per_1 AS v06
  ON v05.wg_id = v06.wg_id
  AND v05.mandant_id = v06.mandant_id
  AND CURRENT_DATE BETWEEN v06.dat_von AND v06.dat_bis
INNER JOIN kfl_production_dbp_view.v_owg_per_1 AS v07
  ON v06.owg_id = v07.owg_id
  AND v06.mandant_id = v07.mandant_id
  AND CURRENT_DATE BETWEEN v07.dat_von AND v07.dat_bis
INNER JOIN kfl_production_dbp_view.v_hwg_per_1 AS v08
  ON v07.hwg_id = v08.hwg_id
  AND v07.mandant_id = v08.mandant_id
  AND CURRENT_DATE BETWEEN v08.dat_von AND v08.dat_bis
INNER JOIN kfl_production_dbp_view.v_art_gp_zu_per_1 AS v09
  ON v01.art_id = v09.art_id
  AND v01.mandant_id = v09.mandant_id
  AND v01.dat_faktura BETWEEN v09.dat_von AND v09.dat_bis
  AND v08.hwg_id <> 64
LEFT JOIN kfl_production_dbp_view.v_art_per_1 AS v10
  ON v01.art_id = v10.art_id
  AND v01.mandant_id = v10.mandant_id
  AND v01.dat_faktura BETWEEN DATE_SUB(v10.dat_von, INTERVAL '1' DAY) AND (
    DATE_SUB(v10.dat_bis, INTERVAL '1' DAY)
  )
WHERE
  v01.mandant_id = 1
  AND v01.nb_id <> 99
  AND NOT v02.fakturaart_id IN ('ZIWU', 'ZIWV')
UNION ALL
SELECT
  v01.art_id,
  v01.mandant_id,
  v01.nb_id AS vz_nb_id,
  v01.wup_id AS vz_wup_id,
  v01.dat_preisfindung AS dat_faktura,
  v02.faktura_typ_id,
  v03.wup_id,
  v03.nb_id,
  v09.gp_id,
  SUBSTR(CASE WHEN NOT v10.posten_id IN ('PN', 'PF', 'SP') THEN 'SO' ELSE 'PN' END, 1, 2) AS posten_kz_per,
  CAST(CASE WHEN v02.faktura_typ_id IN ('O', 'S') THEN 1 ELSE 0 END AS BIGNUMERIC) AS retoure_fg,
  v01.bestellart_id,
  v01.faktura_beleg_id,
  CAST(CASE
    WHEN v02.faktura_typ_id IN ('O', 'N')
    THEN v01.menge_faktura_bme * -1
    ELSE v01.menge_faktura_bme
  END AS NUMERIC) AS faktura_menge_bme,
  CAST(CASE
    WHEN v02.faktura_typ_id IN ('O', 'N')
    THEN v01.menge_faktura_kolli * -1
    ELSE v01.menge_faktura_kolli
  END AS NUMERIC) AS faktura_menge_kolli,
  ROUND(
    CAST(CASE
      WHEN v02.faktura_typ_id IN ('O', 'N')
      THEN (
        v01.zwsum_3_betrag - v01.zwsum_4_betrag - v01.zwsum_9_betrag
      ) * -1
      ELSE v01.zwsum_3_betrag - v01.zwsum_4_betrag - v01.zwsum_9_betrag
    END AS NUMERIC),
    2
  ) AS faktura_wert_ek_netto,
  ROUND(
    CAST(CASE
      WHEN v02.faktura_typ_id IN ('O', 'N')
      THEN (
        v01.zwsum_3_betrag - v01.zwsum_4_betrag - v01.zwsum_9_betrag
      ) * ROUND(CAST(v01.mwst / 100 + 1 AS BIGNUMERIC), 5) * -1
      ELSE (
        v01.zwsum_3_betrag - v01.zwsum_4_betrag - v01.zwsum_9_betrag
      ) * ROUND(CAST(v01.mwst / 100 + 1 AS BIGNUMERIC), 5)
    END AS NUMERIC),
    2
  ) AS faktura_wert_ek_brutto,
  ROUND(
    CAST(CASE
      WHEN v02.faktura_typ_id IN ('O', 'N')
      THEN v01.ek_netto_bnk * -1
      ELSE v01.ek_netto_bnk
    END AS NUMERIC),
    2
  ) AS faktura_zekp_ek_netto_bnk,
  ROUND(
    CAST(CASE WHEN v02.faktura_typ_id IN ('O', 'N') THEN v01.ek_mep * -1 ELSE v01.ek_mep END AS NUMERIC),
    2
  ) AS faktura_zekp_ek_mep,
  ROUND(
    CAST(CASE
      WHEN v02.faktura_typ_id IN ('O', 'N')
      THEN (
        v01.ek_mep - v01.zwsum_6_betrag
      ) * -1
      ELSE v01.ek_mep - v01.zwsum_6_betrag
    END AS NUMERIC),
    2
  ) AS faktura_zekp_ek_mepolk
FROM kfl_production_dbp_view.v_besch_faktura_det_1 AS v01
INNER JOIN kfl_production_dbp_view.v_besch_faktura_1 AS v02
  ON v01.faktura_beleg_id = v02.faktura_beleg_id
  AND v01.mandant_id = v02.mandant_id
  AND v01.dat_faktura_sap = v02.dat_faktura_sap
  AND v02.auftraggeber_id BETWEEN '0000001000' AND '0000009999'
INNER JOIN kfl_production_dbp_view.v_wup_1 AS v03
  ON ROUND(SAFE_CAST(v02.auftraggeber_id AS BIGNUMERIC), 0) = v03.wup_id
  AND v01.mandant_id = v03.mandant_id
INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS v05
  ON v01.art_id = v05.art_id
  AND v01.mandant_id = v05.mandant_id
  AND CURRENT_DATE BETWEEN v05.dat_von AND v05.dat_bis
INNER JOIN kfl_production_dbp_view.v_wg_per_1 AS v06
  ON v05.wg_id = v06.wg_id
  AND v05.mandant_id = v06.mandant_id
  AND CURRENT_DATE BETWEEN v06.dat_von AND v06.dat_bis
INNER JOIN kfl_production_dbp_view.v_owg_per_1 AS v07
  ON v06.owg_id = v07.owg_id
  AND v06.mandant_id = v07.mandant_id
  AND CURRENT_DATE BETWEEN v07.dat_von AND v07.dat_bis
INNER JOIN kfl_production_dbp_view.v_hwg_per_1 AS v08
  ON v07.hwg_id = v08.hwg_id
  AND v07.mandant_id = v08.mandant_id
  AND CURRENT_DATE BETWEEN v08.dat_von AND v08.dat_bis
INNER JOIN kfl_production_dbp_view.v_art_gp_zu_per_1 AS v09
  ON v01.art_id = v09.art_id
  AND v01.mandant_id = v09.mandant_id
  AND v01.dat_preisfindung BETWEEN v09.dat_von AND v09.dat_bis
  AND v08.hwg_id = 64
LEFT JOIN kfl_production_dbp_view.v_art_per_1 AS v10
  ON v01.art_id = v10.art_id
  AND v01.mandant_id = v10.mandant_id
  AND v01.dat_faktura BETWEEN DATE_SUB(v10.dat_von, INTERVAL '1' DAY) AND (
    DATE_SUB(v10.dat_bis, INTERVAL '1' DAY)
  )
WHERE
  v01.mandant_id = 1
  AND v01.nb_id <> 99
  AND NOT v02.fakturaart_id IN ('ZIWU', 'ZIWV');
