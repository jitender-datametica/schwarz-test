CREATE OR REPLACE view DBP_MSI_VIEW_WWC.MV_ALTERSSTRUKTUR_SPR_ZU_HR as
   SELECT
   v01.altersstruktur_id, COALESCE(MAX(CASE WHEN v01.spr_id = 65 THEN  v01.altersstruktur_bez END),
   MAX(CASE WHEN v01.spr_id = 22 THEN v01.altersstruktur_bez END)
   ) AS altersstruktur_bez, MAX(v01.spr_id) AS spr_id

   FROM dbp_view.v_altersstruktur_spr_zu  v01

   WHERE v01.spr_id IN (65,22) -- kroatisch , deutsch

   GROUP BY v01.altersstruktur_id
;