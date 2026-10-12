CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ITM_ITEM_DESC
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  06.11.2017    Klamann,Norbert          uses v_itm_item_desc_act now w
#  1.2  15.11.2017    Wieber,Harald            Release 1.1
#  1.4  29.11.2017    Michael Ueding           complete redesign, version 1.1 is false and slow
#  1.5  06.12.2017    Michael Ueding           for Lidl language use Language Code INT
#  1.6  17.01.2018    Wieber,Harald            Release 2.2
#  1.7  14.02.2018    Ueding,Michael           Initial: Logic aus v_itm_item_desc
#  1.8  17.11.2020    Meme, Yasin              Add LV DWHA-248 Patch 2665
#  1.9  16.12.2021    Michael Morris           Added Estonia EE
#  1.10 28.02.2022    Bachmann, Torsten        Adjust order in SELECT to fit to Column-Definition
#                                              INC4267807, ADO User-Story 291917
#----------------------------------------------------------------------------
*/
(
   client_id
  ,item_id
  ,orig_item_nr
  ,item_desc_AT
  ,item_desc_BE
  ,item_desc_BG
  ,item_desc_CH
  ,item_desc_CY
  ,item_desc_CZ
  ,item_desc
  ,item_desc_DK
  ,item_desc_EE
  ,item_desc_ES
  ,item_desc_FI
  ,item_desc_FR
  ,item_desc_GB
  ,item_desc_GR
  ,item_desc_HR
  ,item_desc_HU
  ,item_desc_IE
  ,item_desc_IT
  ,item_desc_LT
  ,item_desc_LV
  ,item_desc_NI
  ,item_desc_NL
  ,item_desc_DE
  ,item_desc_PL
  ,item_desc_PT
  ,item_desc_RO
  ,item_desc_SE
  ,item_desc_SI
  ,item_desc_SK
  ,item_desc_CS
  ,item_desc_MT
  ,item_desc_US
  ,item_desc_RS
)
AS
SELECT   client_id
       , item_id
       , orig_item_nr
       , MAX (CASE WHEN language_iso_cd = 'AT'          THEN item_desc ELSE NULL END) AS item_desc_AT
       , MAX (CASE WHEN language_iso_cd = 'BE'          THEN item_desc ELSE NULL END) AS item_desc_BE
       , MAX (CASE WHEN language_iso_cd = 'BG'          THEN item_desc ELSE NULL END) AS item_desc_BG
       , MAX (CASE WHEN language_iso_cd = 'CH'          THEN item_desc ELSE NULL END) AS item_desc_CH
       , MAX (CASE WHEN language_iso_cd = 'CY'          THEN item_desc ELSE NULL END) AS item_desc_CY
       , MAX (CASE WHEN language_iso_cd = 'CZ'          THEN item_desc ELSE NULL END) AS item_desc_CZ
       , MAX (CASE WHEN language_iso_cd = 'INT'         THEN item_desc ELSE NULL END) AS item_desc
       , MAX (CASE WHEN language_iso_cd = 'DK'          THEN item_desc ELSE NULL END) AS item_desc_DK
       , MAX (CASE WHEN language_iso_cd = 'EE'          THEN item_desc ELSE NULL END) AS item_desc_EE
       , MAX (CASE WHEN language_iso_cd IN ('ES', 'CS') THEN item_desc ELSE NULL END) AS item_desc_ES
       , MAX (CASE WHEN language_iso_cd = 'FI'          THEN item_desc ELSE NULL END) AS item_desc_FI
       , MAX (CASE WHEN language_iso_cd = 'FR'          THEN item_desc ELSE NULL END) AS item_desc_FR
       , MAX (CASE WHEN language_iso_cd = 'GB'          THEN item_desc ELSE NULL END) AS item_desc_GB
       , MAX (CASE WHEN language_iso_cd IN ('GR', 'CY') THEN item_desc ELSE NULL END) AS item_desc_GR
       , MAX (CASE WHEN language_iso_cd = 'HR'          THEN item_desc ELSE NULL END) AS item_desc_HR
       , MAX (CASE WHEN language_iso_cd = 'HU'          THEN item_desc ELSE NULL END) AS item_desc_HU
       , MAX (CASE WHEN language_iso_cd IN ('IE', 'NI') THEN item_desc ELSE NULL END) AS item_desc_IE
       , MAX (CASE WHEN language_iso_cd IN ('IT', 'MT') THEN item_desc ELSE NULL END) AS item_desc_IT
       , MAX (CASE WHEN language_iso_cd = 'LT'          THEN item_desc ELSE NULL END) AS item_desc_LT
       , MAX (CASE WHEN language_iso_cd = 'LV'          THEN item_desc ELSE NULL END) AS item_desc_LV
       , MAX (CASE WHEN language_iso_cd = 'NI'          THEN item_desc ELSE NULL END) AS item_desc_NI
       , MAX (CASE WHEN language_iso_cd = 'NL'          THEN item_desc ELSE NULL END) AS item_desc_NL
       , MAX (CASE WHEN language_iso_cd = 'DE'          THEN item_desc ELSE NULL END) AS item_desc_DE
       , MAX (CASE WHEN language_iso_cd = 'PL'          THEN item_desc ELSE NULL END) AS item_desc_PL
       , MAX (CASE WHEN language_iso_cd = 'PT'          THEN item_desc ELSE NULL END) AS item_desc_PT
       , MAX (CASE WHEN language_iso_cd = 'RO'          THEN item_desc ELSE NULL END) AS item_desc_RO
       , MAX (CASE WHEN language_iso_cd = 'SE'          THEN item_desc ELSE NULL END) AS item_desc_SE
       , MAX (CASE WHEN language_iso_cd = 'SI'          THEN item_desc ELSE NULL END) AS item_desc_SI
       , MAX (CASE WHEN language_iso_cd = 'SK'          THEN item_desc ELSE NULL END) AS item_desc_SK
       , MAX (CASE WHEN language_iso_cd = 'CS'          THEN item_desc ELSE NULL END) AS item_desc_CS
       , MAX (CASE WHEN language_iso_cd = 'MT'          THEN item_desc ELSE NULL END) AS item_desc_MT
       , MAX (CASE WHEN language_iso_cd = 'US'          THEN item_desc ELSE NULL END) AS item_desc_US
       , MAX (CASE WHEN language_iso_cd = 'RS'          THEN item_desc ELSE NULL END) AS item_desc_RS
 FROM (
       SELECT   itm.client_id
              , itm.item_sid AS item_id
              , COALESCE(descr_sammel.item_descr, descr.item_descr/*, descr_stiftung_sammel.item_descr, descr_stiftung.item_descr*/) AS item_desc
              , CAST(COALESCE(itm_s.src_matnr, itm.src_matnr, itm.src_orig_item_nr) AS DECIMAL(18,0))                                AS orig_item_nr
              , lang.language_iso_cd /* Sprachschluessel analog zu WAWI Definition (z.B. AT fuer Oesterreich DE Sprache)    */
         FROM P_LEW_CORE_AC.v_item itm
        INNER JOIN P_LEW_CORE_AC.v_client      AS cli
           ON cli.client_id = itm.client_id
        INNER JOIN P_LEW_CORE_AC.v_country     AS ctry
           ON cli.country_sid             = ctry.country_sid
              OR ctry.src_country_lidl_cd = 'INT'               /* Stiftung     */

        INNER JOIN P_LEW_CORE_AC.v_report_language AS rlang
           ON ctry.lang_sid = rlang.lang_sid
        INNER JOIN P_LEW_CORE_AC.v_map_lang_spras  AS lang
           ON TRIM(lang.sap_lang_cd)         = TRIM(rlang.iso_cd)
          AND TRIM(ctry.src_country_lidl_cd) = TRIM(language_iso_cd)
         LEFT OUTER JOIN P_LEW_CORE_AC.v_item_descr AS descr
           ON itm.client_id  = descr.client_id
          AND itm.item_sid   = descr.item_sid
          AND rlang.lang_sid = descr.lang_sid
         LEFT OUTER JOIN P_LEW_CORE_AC.v_item_descr AS descr_stiftung
           ON itm.client_id          = descr_stiftung.client_id
          AND itm.item_sid           = descr_stiftung.item_sid
          AND descr_stiftung.lang_cd = '@'
         LEFT OUTER JOIN P_LEW_CORE_AC.v_item       AS itm_s
           ON itm.client_id       = itm_s.client_id
          AND itm.item_sid_config = itm_s.item_sid
         LEFT OUTER JOIN P_LEW_CORE_AC.v_item_descr AS descr_sammel
           ON itm.client_id  = descr_sammel.client_id
          AND itm_s.item_sid = descr_sammel.item_sid
          AND rlang.lang_sid = descr_sammel.lang_sid
         LEFT OUTER JOIN P_LEW_CORE_AC.v_item_descr AS descr_stiftung_sammel
           ON itm.client_id                 = descr_stiftung_sammel.client_id
          AND itm_s.item_sid                = descr_stiftung_sammel.item_sid
          AND descr_stiftung_sammel.lang_cd = '@'

 WHERE TRY_CAST(itm.src_matnr AS DECIMAL(20)) IS NOT NULL
   OR itm.src_matnr IS NULL
) a
GROUP BY   client_id
         , item_id
         , orig_item_nr
;