CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_FLW_QUAL_MELDUNG_DET -- 26.10.2011 system_id entfernt
(
   mandant_id --  ,system_id
,
   qual_meldung_id,
   qual_meldung_pos_id,
   katalogart_id,
   codegruppe_id,
   pruefcode_id,
   fehlgrund_id,
   fehlerklasse_id,
   kopf_fehlerpunkte,
   fehlgrund_gefiltert_bez
) AS
SELECT
   v01.mandant_id,
   v01.qual_meldung_id,
   v01.qual_meldung_pos_id,
   v01.katalogart_id,
   v01.codegruppe_id,
   v01.pruefcode_id,
   v01.fehlgrund_id,
   v01.fehlerklasse_id,
   CAST(
      zeroifnull(v03.fehlerklasse_kennzahl_ber) as NUMBER(38, 5)
   ) AS kopf_fehlerpunkte,
   CASE
      WHEN v02.fehlgrund_id IS NULL THEN ''
      ELSE v01.fehlgrund_id
   END AS fehlgrund_gefiltert_bez
FROM
   dbp_view.v_flw_qual_meldung_det v01
   LEFT OUTER JOIN dbp_view.v_flw_l_fehlgrund v02 ON v01.mandant_id = v02.mandant_id
   AND v01.fehlgrund_id = v02.fehlgrund_id
   LEFT OUTER JOIN dbp_msi_view_flw.mv_l_flw_l_fehlerklasse_qual v03 ON v01.fehlerklasse_id = v03.fehlerklasse_id
   AND v01.mandant_id = v03.mandant_id;