create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_POSTEN_KZ_SAP_SPR_ZU_PROMPT(
	POSTEN_KZ_SAP,
	POSTEN_BEZ_SAP,
	POSTEN_BEZ_SAP_DE,
	POSTEN_BEZ_SAP_CZ,
	POSTEN_BEZ_SAP_SK,
	POSTEN_BEZ_SAP_HR,
	POSTEN_BEZ_SAP_PL,
	POSTEN_BEZ_SAP_RO,
	POSTEN_BEZ_SAP_BG
) as
--2023-02-13,dknop, AP0162072, initial
SELECT
   
   posten_kz_sap,
   MAX(
      CASE
         WHEN (
            spr_id = 22
            AND NOT posten_kz_sap = ''
         ) THEN posten_bez_sap
         WHEN (
            spr_id = 22
            AND posten_kz_sap = ''
         ) THEN 'Sortimentsartikel'
      END
   ) AS posten_bez_sap,
   MAX(
      CASE
         WHEN (
            spr_id = 22
            AND NOT posten_kz_sap = ''
         ) THEN posten_bez_sap
         WHEN (
            spr_id = 22
            AND posten_kz_sap = ''
         ) THEN 'Sortimentsartikel'
      END
   ) AS posten_bez_sap_de,
   COALESCE(
      MAX(
         CASE
            WHEN (
               spr_id = 124
               AND NOT posten_kz_sap = ''
            ) THEN posten_bez_sap
            WHEN (
               spr_id = 124
               AND posten_kz_sap = ''
            ) THEN ''
         END
      ),
      posten_bez_sap_de
   ) AS posten_bez_sap_cz -- CZ
,
   COALESCE(
      MAX(
         CASE
            WHEN (
               spr_id = 108
               AND NOT posten_kz_sap = ''
            ) THEN posten_bez_sap
            WHEN (
               spr_id = 108
               AND posten_kz_sap = ''
            ) THEN ''
         END
      ),
      posten_bez_sap_de
   ) AS posten_bez_sap_sk -- SK
,
   COALESCE(
      MAX(
         CASE
            WHEN (
               spr_id = 65
               AND NOT posten_kz_sap = ''
            ) THEN posten_bez_sap
            WHEN (
               spr_id = 65
               AND posten_kz_sap = ''
            ) THEN ''
         END
      ),
      posten_bez_sap_de
   ) AS posten_bez_sap_hr -- HR
,
   COALESCE(
      MAX(
         CASE
            WHEN (
               spr_id = 90
               AND NOT posten_kz_sap = ''
            ) THEN posten_bez_sap
            WHEN (
               spr_id = 90
               AND posten_kz_sap = ''
            ) THEN ''
         END
      ),
      posten_bez_sap_de
   ) AS posten_bez_sap_pl -- PL
,
   COALESCE(
      MAX(
         CASE
            WHEN (
               spr_id = 95
               AND NOT posten_kz_sap = ''
            ) THEN posten_bez_sap
            WHEN (
               spr_id = 95
               AND posten_kz_sap = ''
            ) THEN ''
         END
      ),
      posten_bez_sap_de
   ) AS posten_bez_sap_ro -- RO
,
   COALESCE(
      MAX(
         CASE
            WHEN (
               spr_id = 18
               AND NOT posten_kz_sap = ''
            ) THEN posten_bez_sap
            WHEN (
               spr_id = 18
               AND posten_kz_sap = ''
            ) THEN ''
         END
      ),
      posten_bez_sap_de
   ) AS posten_bez_sap_bg -- BG
FROM
   dbp_view.v_posten_kz_sap_spr_zu
GROUP BY
   
   posten_kz_sap
UNION
ALL
SELECT
   
   '' AS posten_kz_sap,
   'Sortiment' AS posten_bez_sap,
   'Sortiment' AS posten_bez_sap_de,
   'výber' AS posten_bez_sap_cz,
   'výber' AS posten_bez_sap_sk,
   'asortiman' AS posten_bez_sap_hr,
   'asortyment' AS posten_bez_sap_pl,
   'sortiment' AS posten_bez_sap_ro,
   'асортимент' AS posten_bez_sap_bg;