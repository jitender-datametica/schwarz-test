CREATE OR REPLACE VIEW dbp_msi_view_ek_sort.java_lieferant_spr_zu_msi
AS
SELECT
mandant_id,
kjwo_update AS A500,
akt_lieferant_id AS A16,
/*,spr_id*/
akt_lieferant_bez AS A418
/*, CASE WHEN spr_id =  22  THEN akt_lieferant_bez END AS A418
, CASE WHEN spr_id =  22  THEN akt_lieferant_bez END AS A418_de
, CASE WHEN spr_id =  124  THEN akt_lieferant_bez END AS A418_cz
, CASE WHEN spr_id =  108  THEN akt_lieferant_bez END AS A418_sk
, CASE WHEN spr_id =  65  THEN akt_lieferant_bez END AS A418_hr
, CASE WHEN spr_id =  90  THEN akt_lieferant_bez END AS A418_pl
, CASE WHEN spr_id =  95  THEN akt_lieferant_bez END AS A418_ro
, CASE WHEN spr_id =  18  THEN akt_lieferant_bez END AS A418_bg*/
FROM dbp_view.v_sort_lieferant_spr_zu
WHERE spr_id = 22;