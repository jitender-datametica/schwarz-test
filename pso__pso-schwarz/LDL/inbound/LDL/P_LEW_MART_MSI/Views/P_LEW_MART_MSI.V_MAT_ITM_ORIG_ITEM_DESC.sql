CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ITM_ORIG_ITEM_DESC
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_msi.v_mat_itm_orig_item_desc
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber.Harald            Release 1.1
#  1.2  18.12.2017    Harald Wieber            Change the Stiftung Language from DE to @
#  1.3  17.01.2018    Wieber.Harald            Release 2.2
#  1.4  29.01.2018    Toth.Gabriel             Refactored
#  1.5  31.01.2018    Wieber,Harald            Release 2.3
#  1.6  02.02.2018    Toth,Gabriel             Applied dat_valid_from Logic from v_itm_item
#  1.7  05.02.2018    Toth,Gabriel             Finetuning of dat_valid_from_logic
#  1.8  14.02.2018    Ueding,Michael           Initial: Logik aus v_itm_orig_item_desc
#  1.9  05.03.2018    Ueding,Michael           Logikanpassung fuer Stiftungssprache
# 1.10  02.05.2018    Arnold,Arne              Logik für DAT_VALID_FROM erweitert
#  1.3  06.08.2020    Roy,Ritanjal             Introduce new country LV
# 1.12  13.01.2022    Bachmann,Torsten         Adjust logic: Get desc from mapped item instead of config_item
#                                              IT4You: INC3998056
# 1.13  17.01.2022    Morris, Michael          New country Estonia EE
#----------------------------------------------------------------------------
*/
(
  client_id
, orig_item_nr
, dat_valid_from
, item_desc_AT
, item_desc_BE
, item_desc_BG
, item_desc_CH
, item_desc_CY
, item_desc_CZ
, item_desc
, item_desc_DK
, item_desc_EE
, item_desc_ES
, item_desc_FI
, item_desc_FR
, item_desc_GB
, item_desc_GR
, item_desc_HR
, item_desc_HU
, item_desc_IE
, item_desc_IT
, item_desc_LT
, item_desc_LV
, item_desc_NI
, item_desc_NL
, item_desc_DE
, item_desc_PL
, item_desc_PT
, item_desc_RO
, item_desc_SE
, item_desc_SI
, item_desc_SK
, item_desc_CS
, item_desc_MT
, item_desc_US
, item_desc_RS
)
AS
SELECT   client_id
       , CAST(tmp_orig_item_nr AS DECIMAL(10,0))                             AS orig_item_nr
       , tmp_dat_valid_from                                                  AS dat_valid_from
       , MAX(CASE WHEN lang_client = 1        THEN item_desc ELSE NULL END ) AS item_desc_AT
       , MAX(CASE WHEN lang_client = 2        THEN item_desc ELSE NULL END ) AS item_desc_BE
       , MAX(CASE WHEN lang_client = 3        THEN item_desc ELSE NULL END ) AS item_desc_BG
       , MAX(CASE WHEN lang_client = 4        THEN item_desc ELSE NULL END ) AS item_desc_CH
       , MAX(CASE WHEN lang_client = 5        THEN item_desc ELSE NULL END ) AS item_desc_CY
       , MAX(CASE WHEN lang_client = 6        THEN item_desc ELSE NULL END ) AS item_desc_CZ
       , MAX(CASE WHEN lang_cd = '@'          THEN item_desc ELSE NULL END ) AS item_desc
       , MAX(CASE WHEN lang_client = 8        THEN item_desc ELSE NULL END ) AS item_desc_DK
       , MAX(CASE WHEN lang_client = 9        THEN item_desc ELSE NULL END ) AS item_desc_EE
       , MAX(CASE WHEN lang_client IN (10,31) THEN item_desc ELSE NULL END ) AS item_desc_ES
       , MAX(CASE WHEN lang_client = 11       THEN item_desc ELSE NULL END ) AS item_desc_FI
       , MAX(CASE WHEN lang_client = 12       THEN item_desc ELSE NULL END ) AS item_desc_FR
       , MAX(CASE WHEN lang_client = 13       THEN item_desc ELSE NULL END ) AS item_desc_GB
       , MAX(CASE WHEN lang_client = 14       THEN item_desc ELSE NULL END ) AS item_desc_GR
       , MAX(CASE WHEN lang_client = 15       THEN item_desc ELSE NULL END ) AS item_desc_HR
       , MAX(CASE WHEN lang_client = 16       THEN item_desc ELSE NULL END ) AS item_desc_HU
       , MAX(CASE WHEN lang_client IN (17,21) THEN item_desc ELSE NULL END ) AS item_desc_IE
       , MAX(CASE WHEN lang_client IN (18,32) THEN item_desc ELSE NULL END ) AS item_desc_IT
       , MAX(CASE WHEN lang_client = 19       THEN item_desc ELSE NULL END ) AS item_desc_LT
       , MAX(CASE WHEN lang_client = 20       THEN item_desc ELSE NULL END ) AS item_desc_LV
       , MAX(CASE WHEN lang_client = 21       THEN item_desc ELSE NULL END ) AS item_desc_NI
       , MAX(CASE WHEN lang_client = 22       THEN item_desc ELSE NULL END ) AS item_desc_NL
       , MAX(CASE WHEN lang_client = 23       THEN item_desc ELSE NULL END ) AS item_desc_DE
       , MAX(CASE WHEN lang_client = 24       THEN item_desc ELSE NULL END ) AS item_desc_PL
       , MAX(CASE WHEN lang_client = 25       THEN item_desc ELSE NULL END ) AS item_desc_PT
       , MAX(CASE WHEN lang_client = 26       THEN item_desc ELSE NULL END ) AS item_desc_RO
       , MAX(CASE WHEN lang_client = 27       THEN item_desc ELSE NULL END ) AS item_desc_SE
       , MAX(CASE WHEN lang_client = 28       THEN item_desc ELSE NULL END ) AS item_desc_SI
       , MAX(CASE WHEN lang_client = 29       THEN item_desc ELSE NULL END ) AS item_desc_SK
       , MAX(CASE WHEN lang_client = 31       THEN item_desc ELSE NULL END ) AS item_desc_CS
       , MAX(CASE WHEN lang_client = 32       THEN item_desc ELSE NULL END ) AS item_desc_MT
       , MAX(CASE WHEN lang_client = 33       THEN item_desc ELSE NULL END ) AS item_desc_US
       , MAX(CASE WHEN lang_client = 34       THEN item_desc ELSE NULL END ) AS item_desc_RS
  FROM (
        SELECT   a.client_id                                                                            AS client_id
               , COALESCE(wiia.dat_valid_from, a.src_dat_valid_from, dwf1.src_dat_valid_from, dwf2.src_dat_valid_from, TO_DATE('31.12.9999', 'dd.mm.yyyy')) AS tmp_dat_valid_from
               , COALESCE(NULLIF(d.item_descr, 'XX'), NULLIF(b.item_descr, 'XX'))                       AS item_desc
               , CAST(COALESCE(a.src_orig_item_nr, a.config_item_cd,a.src_matnr) AS DECIMAL(18,0))      AS tmp_orig_item_nr
               , cl.lang_cd                                                                             AS lang_cd
               , CASE WHEN cl.lang_cd = '@'
                      THEN 0
                      ELSE cli.client_id
                 END                                                                                    AS lang_client /* bei Stiftung keinen Landesindikator */
               , CASE
                      /* prio 1 if description for config_item_cd equals the description for item_sid for client language */
                      WHEN COALESCE(d.lang_cd, '')  = cl.lang_cd
                       AND COALESCE(b.lang_cd, '')  = cl.lang_cd
                      THEN 1
                      /* prio 2 if description for config_item_cd has client language */
                      WHEN COALESCE(d.lang_cd, '')  = cl.lang_cd
                       AND COALESCE(b.lang_cd, '') <> cl.lang_cd
                      THEN 2
                      /* prio 3 if description for item_sid_cd has client language */
                      WHEN COALESCE(d.lang_cd, '')  <> cl.lang_cd
                       AND COALESCE(b.lang_cd, '')   = cl.lang_cd
                      THEN 3
                      /* else prio 99 */
                      ELSE 99
                 END + ZEROIFNULL(ihist.deleted_fg)                                                     AS lng_prio
               , MIN(lng_prio) OVER (PARTITION BY a.client_id, tmp_orig_item_nr, tmp_dat_valid_from)    AS min_prio
          FROM P_LEW_CORE_AC.v_item                        AS a
         /*  Ermittlung Land des Clienten */
         INNER JOIN P_LEW_CORE_AC.v_client                 AS cli
            ON cli.client_id = a.client_id
         /* Ermittlung Sprache, Auffaechern auf Land und Stiftung */
         INNER JOIN P_LEW_CORE_AC.v_country                AS cl
            ON cli.country_sid = cl.country_sid
               OR cl.src_country_lidl_cd = 'INT' /* Stiftung */
         /* previously, desc was taken from config_item with higher prio. Now, we're using mapped item instead */
         INNER JOIN P_LEW_CORE_AC.v_item_map_key           AS mkey
            ON a.client_id = mkey.client_id
           AND a.item_sid  = mkey.item_sid
          /* Optional: DAT_VALID_FROM aus WaWI bestimmen. Dies ist für Dummy Artikel (CASE_SIZE = -1) notwendig, deren fachlicher Schlüssel später aktualisiert wird. */
          LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_itm_item_act AS wiia
            ON a.client_id = wiia.client_id
           AND a.item_sid  = wiia.item_sid
           /* check, if item is deleted which lowers the prio */
          LEFT OUTER JOIN P_LEW_CORE_AC.v_item_hist         AS ihist
            ON a.client_id = ihist.client_id
           AND a.item_sid  = ihist.item_sid
           AND CURRENT_DATE BETWEEN ihist.dwh_valid_from AND ihist.DWH_VALID_TO 
          /* here comes the dat_valid_from logic originaly used by v_itm_item */
          LEFT OUTER JOIN (
                           SELECT   a.client_id
                                  , a.item_sid
                                  , b.src_dat_valid_from
                             FROM P_LEW_CORE_AC.v_item             AS a
                            INNER JOIN P_LEW_CORE_AC.v_item        AS b
                               ON b.client_id       = a.client_id
                              AND b.item_sid_config = COALESCE(a.item_sid_config,a.item_sid)
                              AND b.src_dat_valid_from IS NOT NULL
                              AND NOT EXISTS (
		 					                 SELECT 1
                                                FROM P_LEW_CORE_AC.v_item      AS c
                                               WHERE c.client_id = a.client_id
                                                 AND c.item_sid_config          = COALESCE(a.item_sid_config,a.item_sid)
                                                 AND (c.src_dat_valid_from      > b.src_dat_valid_from
                                                       OR (c.src_dat_valid_from = b.src_dat_valid_from AND c.item_sid > b.item_sid)
                                                      )
                                             )
                           ) AS dwf1
            ON dwf1.client_id = a.client_id
           AND dwf1.item_sid = a.item_sid
          LEFT OUTER JOIN (
                           SELECT   client_id
                                  , TRY_CAST(src_orig_item_nr AS INTEGER) AS origi
                                  , MAX(src_dat_valid_from)               AS src_dat_valid_from
                             FROM P_LEW_CORE_AC.v_item           AS c
                            WHERE src_dat_valid_from IS NOT NULL
                              AND origi IS NOT NULL
                              AND src_case_size >= 0
                            GROUP BY   client_id
                                     , TRY_CAST(src_orig_item_nr AS INTEGER)
                           ) AS dwf2
            ON dwf2.client_id = a.client_id
           AND dwf2.origi = TRY_CAST(COALESCE(a.src_orig_item_nr,a.config_item_cd,a.src_matnr) AS DECIMAL(18,0))
           AND a.log_var_cd IS NOT NULL
           /* the description for item_sid */
          LEFT OUTER JOIN P_LEW_CORE_AC.v_item_descr AS b
            ON b.client_id = a.client_id
           AND b.item_sid = a.item_sid
          LEFT OUTER JOIN P_LEW_CORE_AC.v_item       AS c
            ON c.client_id = a.client_id
           AND c.src_matnr = a.config_item_cd
          /* the description for config_item_cd */
          LEFT OUTER JOIN P_LEW_CORE_AC.v_item_descr AS d
            ON mkey.client_id     = d.client_id
           AND mkey.item_sid_map  = d.item_sid
         WHERE TRY_TO_NUMBER(COALESCE(a.src_orig_item_nr, a.config_item_cd,a.src_matnr)) IS NOT NULL /* nur numerische Artikel */
       QUALIFY min_prio = lng_prio
        ) e
  GROUP BY   client_id
           , CAST(tmp_orig_item_nr AS DECIMAL(10,0))
           , tmp_dat_valid_from
;
