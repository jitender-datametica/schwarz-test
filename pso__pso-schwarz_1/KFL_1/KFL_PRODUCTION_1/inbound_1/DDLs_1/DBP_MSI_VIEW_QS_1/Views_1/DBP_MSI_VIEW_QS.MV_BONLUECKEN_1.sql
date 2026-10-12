CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_BONLUECKEN_1
AS
(
SELECT
  x.mandant_id
, x.wup_id
, x.dat_booking
, x.bon_dat
, x.kasse_nr
, x.previous_bon_nr
, x.bon_nr
, x.bon_beginn
, x.bon_ende
, x.datei_name
, x.next_bon_nr
, x.anz_fehlender_bons +1 AS anz_fehlende_bons
, CASE WHEN anz_fehlende_bons = -1 THEN TRIM(x.previous_bon_nr + 1) ELSE TRIM(x.previous_bon_nr + 1) || ' - ' || TRIM(x.bon_nr - 1) END AS fehlende_bon_nr
FROM
(
SELECT  
  t.mandant_id
, t.wup_id
, t.dat_booking
, t.bon_dat
, t.kasse_nr
, t.bon_nr
, t.bon_beginn
, t.bon_ende
, t.datei_name
, COALESCE(MIN(t.bon_nr) OVER (PARTITION BY  t.mandant_id, t.wup_id, t.bon_dat, t.kasse_nr ORDER BY t.bon_nr ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING), 0) AS previous_bon_nr
, COALESCE(MIN(t.bon_nr) OVER (PARTITION BY  t.mandant_id, t.wup_id, t.bon_dat, t.kasse_nr ORDER BY t.bon_nr ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING), 0) AS next_bon_nr
, previous_bon_nr - t.bon_nr  AS anz_fehlender_bons
FROM dbp_v_ods.v_ods_bon_transaction_1 t
WHERE t.mandant_id = 1 
/*AND t.wup_id IN (1390)*/
/*AND t.kasse_nr = 2*/
/*AND CAST( t.bon_booking AS DATE ) = 1160919 */
/*AND t.bon_dat = 1160927*/
) x

WHERE x.anz_fehlender_bons NOT IN (-1,0)
);
