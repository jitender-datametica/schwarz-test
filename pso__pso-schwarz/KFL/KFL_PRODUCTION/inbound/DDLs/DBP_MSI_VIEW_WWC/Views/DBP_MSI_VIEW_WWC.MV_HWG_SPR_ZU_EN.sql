CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_HWG_SPR_ZU_EN -- 05.04.2018, AP0021792, srom: OWG Umstellung
   -- 03.02.2020,AP0048407,SPEC0069946,baranowska: hwg_id >= 0 
   (
      hwg_id,
      arthiertyp_id,
      mandant_id,
      spr_id,
      hwg_bez,
      hwg_id_bez
   ) AS
SELECT v01.hwg_id,
   v01.arthiertyp_id,
   v01.mandant_id,
   MAX(v01.spr_id) AS spr_id,
   COALESCE(
      MAX(
         CASE
            WHEN v01.spr_id = 24 THEN v01.hwg_bez
         END
      ),
      MAX(
         CASE
            WHEN v01.spr_id = 22 THEN v01.hwg_bez
         END
      )
   ) AS hwg_bez,
   COALESCE(
      MAX(
         CASE
            WHEN v01.spr_id = 24 THEN CASE
               WHEN v01.hwg_id < 0 THEN TO_VARCHAR(v01.hwg_id, 'FM000')
               ELSE TO_VARCHAR(v01.hwg_id, 'FM000')
            END || ' ' || v01.hwg_bez
         END
      ),
      MAX(
         CASE
            WHEN v01.spr_id = 22 THEN CASE
               WHEN v01.hwg_id < 0 THEN TO_VARCHAR(v01.hwg_id, 'FM000')
               ELSE TO_VARCHAR(v01.hwg_id, 'FM000')
            END || ' ' || v01.hwg_bez
         END
      )
   ) AS hwg_id_bez
FROM dbp_view.v_hwg_spr_zu v01
WHERE v01.spr_id IN (22, 24)
   AND v01.arthiertyp_id = 2
   AND v01.hwg_id >= 0
GROUP BY v01.hwg_id,
   v01.mandant_id,
   v01.arthiertyp_id;