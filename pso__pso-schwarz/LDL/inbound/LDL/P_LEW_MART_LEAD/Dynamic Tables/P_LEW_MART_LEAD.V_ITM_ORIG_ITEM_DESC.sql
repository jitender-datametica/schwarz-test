CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_LEAD.V_ITM_ORIG_ITEM_DESC COMMENT = 'Original Item description view'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  20.03.2018    -Sanjana Bharti - Initial version -20180319_1620_Create_Missing_Source_Rep3
#  1.1  06.08.2020    Roy,Ritanjal             Introduce new country LV
#  1.2  03.01.2022    Morris, Michael          Added Estonia EE
#-----------------------------------------------------------------------------
*/
(
  client_id      COMMENT 'Identifier of Client'
, orig_item_nr   COMMENT 'Original item id'
, dat_valid_from COMMENT 'Valid from date'
, item_desc_AT   COMMENT 'Item description in depending country language'
, item_desc_BE   COMMENT 'Item description in depending country language'
, item_desc_BG   COMMENT 'Item description in depending country language'
, item_desc_CH   COMMENT 'Item description in depending country language'
, item_desc_CY   COMMENT 'Item description in depending country language'
, item_desc_CZ   COMMENT 'Item description in depending country language'
, item_desc      COMMENT 'Main item description field'
, item_desc_DK   COMMENT 'Item description in depending country language'
, item_desc_EE   COMMENT 'Item description in depending country language'
, item_desc_ES   COMMENT 'Item description in depending country language'
, item_desc_FI   COMMENT 'Item description in depending country language'
, item_desc_FR   COMMENT 'Item description in depending country language'
, item_desc_GB   COMMENT 'Item description in depending country language'
, item_desc_GR   COMMENT 'Item description in depending country language'
, item_desc_HR   COMMENT 'Item description in depending country language'
, item_desc_HU   COMMENT 'Item description in depending country language'
, item_desc_IE   COMMENT 'Item description in depending country language'
, item_desc_IT   COMMENT 'Item description in depending country language'
, item_desc_LT   COMMENT 'Item description in depending country language'
, item_desc_LV   COMMENT 'Item description in depending country language'
, item_desc_NI   COMMENT 'Item description in depending country language'
, item_desc_NL   COMMENT 'Item description in depending country language'
, item_desc_DE   COMMENT 'Item description in depending country language'
, item_desc_PL   COMMENT 'Item description in depending country language'
, item_desc_PT   COMMENT 'Item description in depending country language'
, item_desc_RO   COMMENT 'Item description in depending country language'
, item_desc_SE   COMMENT 'Item description in depending country language'
, item_desc_SI   COMMENT 'Item description in depending country language'
, item_desc_SK   COMMENT 'Item description in depending country language'
, item_desc_CS   COMMENT 'Item description in depending country language'
, item_desc_MT   COMMENT 'Item description in depending country language'
, item_desc_US   COMMENT 'Item description in depending country language'
, item_desc_RS   COMMENT 'Item description in depending country language'
)

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_LEAD

AS
SELECT   client_id
       , CAST(orig_item_nr AS DECIMAL(10,0))                                 AS orig_item_nr
       , dat_valid_from
       , MAX(CASE WHEN lang_client = 1        THEN item_desc ELSE NULL END ) AS item_desc_AT
       , MAX(CASE WHEN lang_client = 2        THEN item_desc ELSE NULL END ) AS item_desc_BE
       , MAX(CASE WHEN lang_client = 3        THEN item_desc ELSE NULL END ) AS item_desc_BG
       , MAX(CASE WHEN lang_client = 4        THEN item_desc ELSE NULL END ) AS item_desc_CH
       , MAX(CASE WHEN lang_client = 5        THEN item_desc ELSE NULL END ) AS item_desc_CY
       , MAX(CASE WHEN lang_client = 6        THEN item_desc ELSE NULL END ) AS item_desc_CZ
       , MAX(CASE WHEN lang_cd     = '@'      THEN item_desc ELSE NULL END ) AS item_desc
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
        SELECT   a.client_id                                                                                     AS client_id
               , COALESCE(a.src_dat_valid_from,dwf1.src_dat_valid_from,dwf2.src_dat_valid_from,DATE'9999-12-31') AS dat_valid_from
               , COALESCE(d.item_descr, b.item_descr)                                                            AS item_desc
               , CAST(COALESCE(a.src_orig_item_nr, a.config_item_cd,a.src_matnr) AS DECIMAL(18,0))               AS orig_item_nr
               , cl.lang_cd                                                                                      AS lang_cd
               , CASE WHEN cl.lang_cd = '@'  THEN 0 ELSE cli.client_id END                                       AS lang_client /* bei Stiftung keinen Landesindikator */
               , CASE
                       /* prio 1 if description for config_item_cd equals the    */
                       /* description for item_sid for client language           */
                       WHEN COALESCE(d.lang_cd, '')  = cl.lang_cd AND COALESCE(b.lang_cd, '') =  cl.lang_cd THEN 1
                       /* prio 2 if description for config_item_cd has client language */
                       WHEN COALESCE(d.lang_cd, '')  = cl.lang_cd AND COALESCE(b.lang_cd, '') <> cl.lang_cd THEN 2
                       /* prio 3 if description for item_sid_cd has client language */
                       WHEN COALESCE(d.lang_cd, '')  <> cl.lang_cd AND COALESCE(b.lang_cd, '') = cl.lang_cd THEN 3
                       /* else prio 99 */
                       ELSE 99
                  END                                                                                            AS lng_prio
          FROM P_LEW_CORE_AC.v_item         AS a
          /* Ermittlung Land des Clienten */
         INNER JOIN P_LEW_CORE_AC.v_client  AS cli
            ON cli.client_id = a.client_id
         /* Ermittlung Sprache, Auffaechern auf Land und Stiftung */
         INNER JOIN P_LEW_CORE_AC.v_country AS cl
            ON cli.country_sid = cl.country_sid
               OR cl.src_country_lidl_cd = 'INT' /* Stiftung */
/* here comes the dat_valid_from logic originaly used by v_itm_item */
          LEFT OUTER JOIN (
                           SELECT   a.client_id
                                  , a.item_sid
                                  , b.src_dat_valid_from
                             FROM P_LEW_CORE_AC.v_item      AS a
                            INNER JOIN P_LEW_CORE_AC.v_item AS b
                               ON b.client_id       = a.client_id
                              AND b.item_sid_config = COALESCE(a.item_sid_config,a.item_sid)
                              AND b.src_dat_valid_from IS NOT NULL
                              AND NOT EXISTS (
                                              SELECT 1
                                                FROM P_LEW_CORE_AC.v_item AS c
                                               WHERE c.client_id           = a.client_id
                                                 AND c.item_sid_config     = COALESCE(a.item_sid_config,a.item_sid)
                                                 AND (c.src_dat_valid_from     > b.src_dat_valid_from
                                                      OR (c.src_dat_valid_from = b.src_dat_valid_from
                                                          AND c.item_sid       > b.item_sid))
                                             )
                           ) AS dwf1
            ON dwf1.client_id = a.client_id
           AND dwf1.item_sid  = a.item_sid
          LEFT OUTER JOIN (
                           SELECT   client_id
                                  , TRY_CAST(src_orig_item_nr AS INTEGER) AS origi
                                  , MAX(src_dat_valid_from)               AS src_dat_valid_from
                             FROM P_LEW_CORE_AC.v_item AS c
                            WHERE src_dat_valid_from IS NOT NULL
                              AND origi IS NOT NULL
                              AND src_case_size >= 0
                            GROUP BY   client_id
                                     , origi
                           ) AS dwf2
            ON dwf2.client_id = a.client_id
           AND dwf2.origi = TRY_CAST(COALESCE(a.src_orig_item_nr,a.config_item_cd,a.src_matnr) AS DECIMAL(18,0))
           AND a.log_var_cd IS NOT NULL
          /* the description for item_sid */
          LEFT OUTER JOIN P_LEW_CORE_AC.v_item_descr AS b
            ON b.client_id = a.client_id
           AND b.item_sid  = a.item_sid
          LEFT OUTER JOIN P_LEW_CORE_AC.v_item AS c
            ON c.client_id = a.client_id
           AND c.src_matnr = a.config_item_cd
          /* the description for config_item_cd */
          LEFT JOIN P_LEW_CORE_AC.v_item_descr AS d
            ON d.client_id = c.client_id
           AND d.item_sid  = c.item_sid
         WHERE TRY_TO_NUMBER(COALESCE(a.src_orig_item_nr, a.config_item_cd,a.src_matnr)) IS NOT NULL /* nur numerische Artikel */
         /* keep the most prior description based on lng_prio */
         QUALIFY MIN(lng_prio) OVER (PARTITION BY a.client_id, orig_item_nr, dat_valid_from)  = lng_prio
       ) AS e
 GROUP BY   client_id
          , orig_item_nr
          , dat_valid_from
;
