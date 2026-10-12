CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_ART_SPR_ZU_1
(
spr_id
, art_id
, mandant_id
, art_bez
, art_id_bez
)
AS
   SELECT
   spr_id,
   art_id,
   mandant_id,
   CASE WHEN SUBSTR( art_bez, 1, 11) = 'Wertartikel'  AND art_id < 0 THEN 'Sachkonto WG '  || TRIM( art_id/-1000) ELSE art_bez END AS art_bez,
   CAST( CAST(art_id AS CHAR(10)) || '   ' || art_bez AS CHAR(50)) AS art_id_bez

  FROM dbp_view.v_art_spr_zu_1
  WHERE spr_id = 22
  AND mandant_id = 1
;