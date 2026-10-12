CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ART_PALMENGE_ZU_2
-- AP0032822, SPEC0041631 - 31.10.2108, mkub1811 neue View
(
mandant_id
,art_id
,palettenmenge
)
AS
   SELECT
   v01.mandant_id, v01.art_id, COALESCE(v02.palettenmenge, 1) AS palettenmenge
   FROM dbp_view.v_art_2 v01
   LEFT OUTER JOIN
   (
   SELECT
   mandant_id, art_id, CAST (CAST(TRUNC(   CAST( 1 AS NUMBER(38,5)) /umrech_faktor)
   AS
   DECIMAL(12,0))
   AS INTEGER ) AS palettenmenge
   FROM dbp_view.v_art_umrechnung_faktor_per_2
   WHERE altnv_menge_einh_id = 'PAL'
   AND dat_bis='9999-12-31' --AND mandant_id <> 1
   )
   v02
   ON v01.mandant_id =v02.mandant_id
   AND
   v01.art_id = v02.art_id
   --WHERE v01.mandant_id <> 1
   ;