CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.MV_ART_LAGEMENGE_ZU_1
-- MR 01.03.2012 erstellt
-- AL 21.04.2012 mandant_id <> 1 / CAST zum Vermeiden Numeric Overflow
--       LEFT OUTER JOIN zu art_1, damit Attribut nicht filtert
(
 mandant_id
,art_id
,lagemenge
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS
   SELECT
   v01.mandant_id,
   v01.art_id,
   COALESCE(v02.lagemenge,1)

   FROM dbp_view.v_art_1 v01
   LEFT OUTER JOIN

   (  SELECT
   mandant_id,
   art_id,
   CAST(
  -- Runden durch CAST zu DECIMAL
  CAST(
   CAST(1 AS NUMBER(38,5)) /umrech_faktor
   AS DECIMAL (12,0))
   AS INTEGER) AS lagemenge
   FROM dbp_view.v_art_umrechnung_faktor_per_1
   WHERE  altnv_menge_einh_id = 'VST'
   AND dat_bis='9999-12-31' AND mandant_id <> 1
   ) v02
   ON
   v01.mandant_id =v02.mandant_id AND
   v01.art_id = v02.art_id

   WHERE v01.mandant_id <> 1;