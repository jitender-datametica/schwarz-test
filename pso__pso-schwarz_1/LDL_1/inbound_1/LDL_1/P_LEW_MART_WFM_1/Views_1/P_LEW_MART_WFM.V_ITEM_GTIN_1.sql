CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_ITEM_GTIN_1
(
 client_id
,orig_item_nr
,item_ean
)
AS
/* WAWI part */
SELECT
client_id
,orig_item_nr
,item_ean
FROM (SELECT
sig.client_id                    AS client_id
,cl.src_country_lidl_cd           AS land_1
,imi.orig_itm_nr                  AS orig_item_nr
,sig.item_sid                     AS item_sid
,Cast(sig.ean_1 AS VARCHAR(20))     AS item_ean
/* wir muessen auf die t_wawi_itm_ean_1 gehen weil die neue DWH 2.0 view alle orig_item_nr hat, aber nicht die richtigen EANs ( wegen des neuen QUALIFY ) */
FROM p_lew_core_ac.v_wawi_itm_ean_1  sig

INNER JOIN p_lew_core_ac.v_client_1 cl
ON cl.client_id = sig.client_id

/* JOIN, um die Artikeln Nummer zu kriegen */
INNER JOIN  (SELECT
i.client_id
,i.item_sid
,CASE WHEN i.src_orig_item_nr IS NULL
                                THEN CAST(COALESCE (TRY_CAST(i.config_item_cd AS BIGINT), TRY_CAST(i.src_matnr AS BIGINT), i.src_orig_item_nr) AS  BIGINT)
ELSE CAST(i.src_orig_item_nr AS BIGINT)
END AS orig_itm_nr
FROM p_lew_core_ac.v_item_1 i
INNER JOIN p_lew_core_ac.v_wawi_itm_item_wh_1 w
ON i.client_id = w.client_id
AND i.item_sid = w.item_sid
AND (w.item_status BETWEEN 5 AND 11 OR w.item_status BETWEEN 12 AND 13)
AND Current_Date BETWEEN w.dat_rec_start AND w.dat_rec_end
INNER JOIN p_lew_core_ac.v_wawi_itm_item_act_1 a
ON i.client_id = a.client_id
AND i.item_sid = a.item_sid
AND a.status_id_hq NOT IN (1,2,15)
AND a.orig_item_nr > 0
WHERE orig_itm_nr IS NOT NULL
GROUP BY 1,2,3
) imi
ON imi.client_id = sig.client_id
AND imi.item_sid = sig.item_sid

-- Steuerung für das Ausfildern von WAWI Ländern
INNER JOIN p_lew_core_ac.v_client_migration_per_1 AS mig
ON sig.client_id = mig.client_id


WHERE Current_Date BETWEEN sig.dat_rec_start AND sig.dat_rec_end
/* nur Daten mit numerischen EANs */
AND
TRY_CAST(sig.ean_1 AS BIGINT) > 0
AND To_Number(sig.ean_1) = sig.ean_1

/* Nur die noch nicht migrierte Ländern */
AND (    Current_Date < mig.migration_dat_valid_from
         OR Current_Date > mig.migration_dat_valid_to
    )
QUALIFY sig.dat_rec_start = Max(sig.dat_rec_start) Over(PARTITION BY sig.client_id, sig.ean_1)

) AS x
GROUP BY 1,2,3
;


