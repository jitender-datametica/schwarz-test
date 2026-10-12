 --[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.art_bestand_vw_sum_artbew_dat_2
(
  mandant_id,
  dat
)
SELECT
  mandant_id,
  dat
FROM DBP_ETL.artbew_agg_tmp_2
WHERE
  (mandant_id, dat)
  NOT IN
  (
    SELECT
      mandant_id,
      dat
    FROM DBP_ETL.art_bestand_vw_sum_artbew_dat_2
  )

GROUP BY mandant_id, dat
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.artbew_mis_2
WHERE (mandant_id, wup_id, dat) IN
  (
    SELECT
       mandant_id
      ,wup_id
      ,dat
    FROM DBP_ETL.artbew_agg_tmp_2
  )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.artbew_mis_2
(
   mandant_id
  ,art_id
  ,wup_id
  ,nb_id
  ,bewart_id
  ,dat
  ,wrg_2
  ,diff_umsatz_netto_konz
  ,diff_umsatz_mwst_betrag_konz
  ,menge
  ,umsatz_netto
  ,umsatz_mwst_betrag
)
SELECT
   mandant_id
  ,art_id
  ,wup_id
  ,nb_id
  ,1001
  ,dat
  ,wrg_2
  ,0 diff_umsatz_netto_konz
  ,0 diff_umsatz_mwst_betrag_konz
  ,SUM(menge                       )
  ,SUM(umsatz_netto                )
  ,SUM(umsatz_mwst_betrag          )
FROM _artbew_tmp
GROUP BY
1,2,3,4,5,6,7,8,9
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_ETL.artbew_mis_2

SET wg_id = dt.wg_id
,arthiertyp_id = dt.arthiertyp_id

FROM
(
SELECT
mandant_id
,art_id
,wg_id
,arthiertyp_id
FROM DBP_DATA.art_wg_zu_per_2
WHERE arthiertyp_id = 2 AND
dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
GROUP BY 1,2,3,4
) dt WHERE DBP_ETL.artbew_mis.mandant_id = dt.mandant_id
AND DBP_ETL.artbew_mis.art_id = dt.art_id
;


--2021-09-22 mfialkiewicz switched to bon_artbew_tmp_talon_2 as in TD BTEQ
UPDATE  DBP_DATA.wupcal_2
   SET  datenlieferung_artbew = 1,
        dat_extrakt_umsatz = CURRENT_DATE,
        umsatz_brutto_ods_verkauf = umsatz_brutto,
        td_update = CURRENT_TIMESTAMP
FROM (SELECT
        a.mandant_id mandant_id_
        ,a.wup_id wup_id_
        ,w.nb_id nb_id_
        ,a.dat dat_
        ,SUM(a.umsatz_brutto) AS umsatz_brutto
        FROM dbp_etl.bon_artbew_tmp_talon_2 a
        INNER JOIN DBP_DATA.wup_2 w
                ON w.mandant_id = a.mandant_id
                AND w.wup_id = a.wup_id
                GROUP BY 1,2,3,4 ) x1
WHERE
mandant_id = mandant_id_
AND wup_id = wup_id_
AND nb_id = nb_id_
AND dat = dat_
--AND nb_id IN (0, 2, 7)
;



UPDATE DBP_DATA.wupcal_2

SET bonanzahl = anz_kunden_
, bonanzahl_imbiss = anz_kunden_imbiss_
, umsatz_brutto_ods_kassenabschluss = umsatz_brutto_ods_kassenabschluss_
, datenlieferung_bonanzahl = 1
,td_update = CURRENT_TIMESTAMP

FROM (
        SELECT  k.mandant_id mandant_id_,
                k.wup_id wup_id_,
                k.bon_dat dat_,
                SUM(k.anz_kunden) - SUM(k.anz_kunden_imbiss) anz_kunden_,
                SUM(k.anz_kunden_imbiss) anz_kunden_imbiss_,
                SUM(k.umsatz_brutto) umsatz_brutto_ods_kassenabschluss_
          FROM    DBP_ODS.ods_bon_kassenabschluss_2 k
         INNER JOIN (SELECT DISTINCT mandant_id,wup_id,dat FROM DBP_ETL.artbew_agg_tmp_2) a
            ON a.mandant_id = k.mandant_id
           AND a.wup_id = k.wup_id
           AND a.dat = k.bon_dat
        GROUP BY 1,2,3
        ) S 
WHERE mandant_id = mandant_id_
  AND wup_id = wup_id_
  AND dat = dat_
;


/*2021-09-22 mfialkiewicz*/
DROP TABLE IF EXISTS dbp_etl.bon_artbew_tmp_talon_2;

/*2021-09-22 mfialkiewicz*/
DROP TABLE IF EXISTS dbp_etl.artbew_coupon_zu_tmp_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.bon_artbew_dat_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.bon_artbew_tag_2;



