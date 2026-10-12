CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_REGIONAL_KZ_2
(
   REGIONAL_KZ,
   regional_bez
)
AS
   SELECT  --CAST(2 AS BYTEINT)  AS mandant_id,
   CAST(0 AS BYTEINT) AS regional_kz,
   'national' AS regional_bez
   FROM dbp_view.v_tag_2
   WHERE dat= CURRENT_DATE

   /*
   Ausblenden mandant_id zwecks Vermeidung von Mehrfachdarstellung im Elementprompt/ sschuecke 05.03.2025 
   UNION

   SELECT  3,
   0,
   'national'
  FROM dbp_view.v_tag_2
  WHERE dat= CURRENT_DATE

  UNION

  SELECT  4,
   0,
   'national'
  FROM dbp_view.v_tag_2
  WHERE dat= CURRENT_DATE

  UNION

  SELECT  5,
   0,
   'national'
  FROM dbp_view.v_tag_2
  WHERE dat= CURRENT_DATE

  UNION

  SELECT  6,
   0,
   'national'
  FROM dbp_view.v_tag_2
  WHERE dat= CURRENT_DATE

  UNION

  SELECT  7,
   0,
   'national'
  FROM dbp_view.v_tag_2
  WHERE dat= CURRENT_DATE

  UNION


  SELECT  8,
   0,
   'national'
  FROM dbp_view.v_tag_2
  WHERE dat= CURRENT_DATE*/

  UNION


  SELECT  --2,
   1,
   'regional'
  FROM dbp_view.v_tag_2
  WHERE dat = CURRENT_DATE

  /*UNION


  SELECT  3,
   1,
   'regional'
  FROM dbp_view.v_tag_2
  WHERE dat= CURRENT_DATE

  UNION


  SELECT  4,
   1,
   'regional'
  FROM dbp_view.v_tag_2
  WHERE dat= CURRENT_DATE

  UNION


  SELECT  5,
   1,
   'regional'
  FROM dbp_view.v_tag_2
  WHERE dat= CURRENT_DATE

  UNION


  SELECT  6,
   1,
   'regional'
  FROM dbp_view.v_tag_2
  WHERE dat= CURRENT_DATE

  UNION


  SELECT  7,
   1,
   'regional'
  FROM dbp_view.v_tag_2
  WHERE dat= CURRENT_DATE

  UNION


  SELECT  8,
   1,
   'regional'
  FROM dbp_view.v_tag_2
  WHERE dat= CURRENT_DATE */;